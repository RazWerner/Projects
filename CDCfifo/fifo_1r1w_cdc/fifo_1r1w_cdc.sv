module fifo_1r1w_cdc
 #(parameter [31:0] width_p = 32
  ,parameter [31:0] depth_log2_p = 8
  )
   // To emphasize that the two interfaces are in different clock
   // domains i've annotated the two sides of the fifo with "c" for
   // consumer, and "p" for producer. 
  (input [0:0] cclk_i
  ,input [0:0] creset_i
  ,input [width_p - 1:0] cdata_i
  ,input [0:0] cvalid_i
  ,output [0:0] cready_o 

  ,input [0:0] pclk_i
  ,input [0:0] preset_i
  ,output [0:0] pvalid_o 
  ,output [width_p - 1:0] pdata_o 
  ,input [0:0] pready_i
  );
   


  //Next write and read pointers determined combinationally
  logic [depth_log2_p:0] wr_i_n;
  logic [depth_log2_p:0] rd_i_n;
  //Read and Write pointers
  logic [depth_log2_p:0] wr_i;
  logic [depth_log2_p:0] rd_i;
  //full and empty signals
  logic [0:0] full;
  logic [0:0] empty;


  //Comb block for write pointer logic 
  always_comb begin :wrPtrLogic
  if(creset_i)
  begin 
    wr_i_n = '0;
  end
    else if (cvalid_i & cready_o)
    begin 
      wr_i_n = wr_i +1;
    end
    else
    begin
    wr_i_n = wr_i;
    end
  end

//Flip-Flop/Counter for write pointer runs on consumer clock
always_ff @(posedge cclk_i) begin: WRpointer
if (creset_i)
  begin
    wr_i <= '0;
  end
else
  begin 
    wr_i <= wr_i_n;
  end
end

//Sync ram 1r1w 
ram #(.depth_p(1<<depth_log2_p), .width_p(width_p), .filename_p("fifomem.bin")) fifomem (.pclk_i(pclk_i), .cclk_i(cclk_i), .rd_valid_i('1), .preset_i(preset_i), .creset_i(creset_i), .wr_valid_i(~full), .wr_data_i(cdata_i), .wr_addr_i(wr_i[depth_log2_p-1:0]), .rd_addr_i(rd_i_n[depth_log2_p-1:0]), .rd_data_o(dataSelected));

//write pointer binary to gray conversion unsycronized still in consumer clock domain
logic [depth_log2_p:0] WRpointerGrayUnSync;
bin2gray #(.width_p(depth_log2_p + 1)) wrPtrB2G (.bin_i(wr_i), .gray_o(WRpointerGrayUnSync));

//first flip flop in syncronizer for write pointer in producer domain
logic [depth_log2_p:0] WRpointerGraySync1;
always_ff @(posedge pclk_i) begin:WrSync1
  if (preset_i)
  begin
    WRpointerGraySync1 <= '0;
  end
  else
  begin
    WRpointerGraySync1 <= WRpointerGrayUnSync;
  end
end

//second flip flop in syncronizer for write pointer in producer domain
logic [depth_log2_p:0] WRpointerGraySync2;
always_ff @(posedge pclk_i) begin: WrSync2
  if (preset_i)
  begin
    WRpointerGraySync2 <= '0;
  end
  else
  begin
    WRpointerGraySync2 <= WRpointerGraySync1;
  end
end

//write pointer gray to binary conversion so write pointer is in producer domain;
logic [depth_log2_p:0] p_wr_ptr;
gray2bin #(.width_p(depth_log2_p + 1)) wrPtrG2B (.gray_i(WRpointerGraySync2), .bin_o(p_wr_ptr));

//slow down write pointer


//read pointer combinational logic 
always_comb begin :rdPtrLogic
  if (preset_i)
  begin
  rd_i_n = '0;
  end
  else if (pvalid_o & pready_i)
  begin 
    rd_i_n = rd_i +1;
  end
  else
  begin
   rd_i_n = rd_i;
  end
end

//read pointer counter/flip flop block
always_ff @(posedge pclk_i) begin: RDpointer
if (preset_i)
  begin
    rd_i <= '0;
  end
else
  begin 
    rd_i <= rd_i_n;
  end
end

//read pointer converted to gray in producer domain
logic [depth_log2_p:0] RDpointerGrayUnSync;
bin2gray #(.width_p(depth_log2_p + 1)) rdPtrB2G (.bin_i(rd_i), .gray_o(RDpointerGrayUnSync));

//read pointer first flip flop for consumer domain synchroniztion 
logic [depth_log2_p:0] RDpointerGraySync1;
always_ff @(posedge cclk_i) begin: RdSync1
  if (creset_i)
  begin
    RDpointerGraySync1 <= '0;
  end
  else
  begin
    RDpointerGraySync1 <= RDpointerGrayUnSync;
  end
end

//read pointer second flip flop for consumer domain synchroniztion
logic [depth_log2_p:0] RDpointerGraySync2;
always_ff @(posedge cclk_i) begin: RDSync2
  if (creset_i)
  begin
    RDpointerGraySync2 <= '0;
  end
  else
  begin
    RDpointerGraySync2 <= RDpointerGraySync1;
  end
end
//gray to binary conversion of consumer domain syncronized read pointer
logic [depth_log2_p:0] c_rd_ptr;
gray2bin #(.width_p(depth_log2_p + 1)) rdPtrG2B (.gray_i(RDpointerGraySync2), .bin_o(c_rd_ptr));

//comb block determining fifo is empty using cross domain syncronized write pointer
always_comb begin :emptyLogic
if ((p_wr_ptr == rd_i))
begin
 empty = '1;
end
else 
begin
  empty = '0;
end
end

//comb block determining fifo is full using cross domain syncronized read pointer
always_comb begin :fullLogic
if ((wr_i[depth_log2_p] != c_rd_ptr[depth_log2_p]) & (wr_i[depth_log2_p-1:0] == c_rd_ptr[depth_log2_p-1:0]))
begin
 full = '1;
end
else 
begin
  full = '0;
end
end

logic[width_p-1:0] dataSelected;
//assign data 
assign pdata_o = dataSelected;
//assign ready and valid signals 
assign cready_o = ~full;
assign pvalid_o = ~empty;


endmodule
