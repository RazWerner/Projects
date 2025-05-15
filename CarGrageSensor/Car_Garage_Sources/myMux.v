`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2023 12:06:13 PM
// Design Name: 
// Module Name: myMux
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


module myMux(
    input [6:0] i0,
    input [6:0] i1,
    input s,
    output [6:0] busOut
    );
    assign busOut = ({7{~s}} & i0) | ({7{s}} & i1);
    
endmodule