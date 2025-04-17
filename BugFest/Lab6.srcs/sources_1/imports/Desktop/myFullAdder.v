`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2023 11:55:00 AM
// Design Name: 
// Module Name: myFullAdder
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


module myFullAdder(
    input a,
    input b,
    input Cin,
    output s,
    output Cout
    );
    assign s = (a ^ b) ^ Cin;
    assign Cout = (a & b & ~Cin) + (a & b & Cin) + (~a & b & Cin) + (a & b & Cin);
endmodule
