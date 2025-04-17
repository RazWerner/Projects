module bin2gray
  #(parameter width_p = 5)
  (input [width_p - 1 : 0] bin_i
  ,output [width_p - 1 : 0] gray_o);

  assign gray_o[width_p-1] = bin_i[width_p-1];
  for (genvar i = 0; i < width_p-1; i++)
   begin : grayloop
    assign gray_o[i] = (bin_i[i] ^ bin_i[i+1]);
   end

endmodule
