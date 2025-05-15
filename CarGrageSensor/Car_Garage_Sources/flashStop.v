`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2025 12:24:58 PM
// Design Name: 
// Module Name: flashStop
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


module flashStop(
    input [1:0] C_i,
    output Stop_o
    );
    
    assign Stop_o = C_i[1] & C_i[0];
endmodule
