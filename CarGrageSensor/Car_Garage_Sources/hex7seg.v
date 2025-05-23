`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 04:41:46 PM
// Design Name: 
// Module Name: top
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
module hex7seg(
    input [3:0] n,
    output [6:0] seg
);
    //logic for each segment of 7 segment display converts hex to 7 segment readable numbers and letters
    assign seg[0] = (~n[3] & ~n[2] & ~n[1] & n[0]) | (~n[3] & n[2] & ~n[1] & ~n[0]) | (n[3] & ~n[2] & n[1] & n[0]) | (n[3] & n[2] & ~n[1] & n[0]);
    assign seg[1] = (~n[3] & n[2] & ~n[1] & n[0]) | (~n[3] & n[2] & n[1] & ~n[0]) | (n[3] & ~n[2] & n[1] & n[0]) | (n[3] & n[2] & ~n[1] & ~n[0]) | (n[3] & n[2] & n[1] & ~n[0]) | (n[3] & n[2] & n[1] & n[0]);
    assign seg[2] = (~n[3] & ~n[2] & n[1] & ~n[0]) | (n[3] & n[2] & ~n[1] & ~n[0]) | (n[3] & n[2] & n[1] & ~n[0]) | (n[3] & n[2] & n[1] & n[0]);
    assign seg[3] = (~n[3] & ~n[2] & ~n[1] & n[0]) | (~n[3] & n[2] & ~n[1] & ~n[0]) | (~n[3] & n[2] & n[1] & n[0]) | (n[3] & ~n[2] & ~n[1] & n[0]) | (n[3] & ~n[2] & n[1] & ~n[0]) | (n[3] & n[2] & n[1] & n[0]);
    assign seg[4] = (~n[3] & ~n[2] & ~n[1] & n[0]) | (~n[3] & ~n[2] & n[1] & n[0]) | (~n[3] & n[2] & ~n[1] & ~n[0]) | (~n[3] & n[2] & ~n[1] & n[0]) | (~n[3] & n[2] & n[1] & n[0]) | (n[3] & ~n[2] & ~n[1] & n[0]);
    assign seg[5] = (~n[3] & ~n[2] & ~n[1] & n[0]) | (~n[3] & ~n[2] & n[1] & ~n[0])| (~n[3] & ~n[2] & n[1] & n[0]) | (~n[3] & n[2] & n[1] & n[0])| (n[3] & n[2] & ~n[1] & n[0]);
    assign seg[6] = (~n[3]& ~n[2]& ~n[1]& ~n[0]) | (~n[3]&~n[2]&~n[1]&n[0]) | (~n[3]&n[2]&n[1]&n[0]) | (n[3]&n[2]&~n[1]&~n[0]);
endmodule
