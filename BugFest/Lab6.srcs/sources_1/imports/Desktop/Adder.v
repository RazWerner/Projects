`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2023 12:20:48 PM
// Design Name: 
// Module Name: Adder
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


module Adder(
    input [14:0] A,
    input [14:0] B,
    input Cin,
    output [14:0] S,
    output ovfl,
    output Cout
    );
    wire [14:0] bitConnect;
    
    myFullAdder zeroBit (.a(A[0]), .b(B[0]), .Cin(Cin), .s(S[0]), .Cout(bitConnect[0]));
    myFullAdder oneBit (.a(A[1]), .b(B[1]), .Cin(bitConnect[0]), .s(S[1]), .Cout(bitConnect[1]));
    myFullAdder twoBit (.a(A[2]), .b(B[2]), .Cin(bitConnect[1]), .s(S[2]), .Cout(bitConnect[2]));
    myFullAdder threeBit (.a(A[3]), .b(B[3]), .Cin(bitConnect[2]), .s(S[3]), .Cout(bitConnect[3]));
    myFullAdder fourBit (.a(A[4]), .b(B[4]), .Cin(bitConnect[3]), .s(S[4]), .Cout(bitConnect[4]));
    myFullAdder fiveBit (.a(A[5]), .b(B[5]), .Cin(bitConnect[4]), .s(S[5]), .Cout(bitConnect[5]));
    myFullAdder sixBit (.a(A[6]), .b(B[6]), .Cin(bitConnect[5]), .s(S[6]), .Cout(bitConnect[6]));
    myFullAdder sevenBit (.a(A[7]), .b(B[7]), .Cin(bitConnect[6]), .s(S[7]), .Cout(bitConnect[7]));
    myFullAdder eightBit (.a(A[8]), .b(B[8]), .Cin(bitConnect[7]), .s(S[8]), .Cout(bitConnect[8]));
    myFullAdder nineBit (.a(A[9]), .b(B[9]), .Cin(bitConnect[8]), .s(S[9]), .Cout(bitConnect[9]));
    myFullAdder tenBit (.a(A[10]), .b(B[10]), .Cin(bitConnect[9]), .s(S[10]), .Cout(bitConnect[10]));
    myFullAdder elevenBit (.a(A[11]), .b(B[11]), .Cin(bitConnect[10]), .s(S[11]), .Cout(bitConnect[11]));
    myFullAdder twelveBit (.a(A[12]), .b(B[12]), .Cin(bitConnect[11]), .s(S[12]), .Cout(bitConnect[12]));
    myFullAdder thirteenBit (.a(A[13]), .b(B[13]), .Cin(bitConnect[12]), .s(S[13]), .Cout(bitConnect[13]));
    myFullAdder fourteenBit (.a(A[14]), .b(B[14]), .Cin(bitConnect[13]), .s(S[14]), .Cout(bitConnect[14]));
    
    assign ovfl = (bitConnect[14] ^ Cout);
endmodule