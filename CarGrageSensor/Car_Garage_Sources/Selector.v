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
module Selector(
    input [15:0] N,
    input [3:0] Sel,
    output three,
    output [3:0] H
    );
    
    assign three = ~Sel[0] & ~Sel[1] & Sel[2] & ~Sel[4];
    
    assign H[3:0] = (N[15:12] & {Sel[3], Sel[3], Sel[3], Sel[3]}) | // sel 1000
                    (N[11:8] & {Sel[2], Sel[2], Sel[2], Sel[2]}) | // sel 0100
                    (N[7:4] & {Sel[1], Sel[1], Sel[1], Sel[1]}) | // sel 0010
                    (N[3:0] & {Sel[0], Sel[0], Sel[0], Sel[0]}); // sel 0001
    
endmodule
