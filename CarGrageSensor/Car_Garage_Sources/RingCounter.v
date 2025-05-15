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
module RingCounter(
    input clk,
    input Advance,
    output [3:0] Out
    );
    
    FDRE #(.INIT(1'b1) ) FFR1 (.C(clk), .R(1'b0), .CE(Advance), .D(Out[3]), .Q(Out[0]));
    FDRE #(.INIT(1'b0) ) FFR2 (.C(clk), .R(1'b0), .CE(Advance), .D(Out[0]), .Q(Out[1]));
    FDRE #(.INIT(1'b0) ) FFR3 (.C(clk), .R(1'b0), .CE(Advance), .D(Out[1]), .Q(Out[2]));
    FDRE #(.INIT(1'b0) ) FFR4 (.C(clk), .R(1'b0), .CE(Advance), .D(Out[2]), .Q(Out[3]));
    
endmodule
