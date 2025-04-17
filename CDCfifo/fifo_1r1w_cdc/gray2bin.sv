module gray2bin
  #(parameter width_p = 5)
   (input [width_p - 1 : 0] gray_i
    ,output [width_p - 1 : 0] bin_o);


   logic [width_p-1:0] bin_out;

   int i;

   always_comb begin : binLogic
    bin_out[width_p-1] = gray_i[width_p-1];
    for (i = width_p-2; i >= 0 ; i--)
    begin : grayloop
     bin_out[i] = (gray_i[i] ^ bin_out[i+1]);
    end



   end
   assign bin_o = bin_out;
   
   
   //assign bin_o[width_p-1] = gray_i[width_p-1];

   




endmodule
