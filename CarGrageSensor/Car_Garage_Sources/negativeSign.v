`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2023 10:04:10 PM
// Design Name: 
// Module Name: negativeSign
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module negativeSign(
    output [6:0] seg
    );
    
    assign seg[0]= 1'b1;
    assign seg[1]= 1'b1;
    assign seg[2]= 1'b1;
    assign seg[3]= 1'b1;
    assign seg[4]= 1'b1;
    assign seg[5]= 1'b1;
    assign seg[6] = 1'b0;
    
endmodule
