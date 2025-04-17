`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2023 01:10:19 PM
// Design Name: 
// Module Name: AddSub8
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


module AddSub8(
    input [7:0] A,
    input [7:0] B,
    input sub,
    output [7:0] S,
    output ovfl
    );
    
    wire [7:0] B_neg;
    wire [7:0] TwosComplement;
    wire Cout;
    
    assign B_neg = sub ? ~B + 1 : B;
    assign TwosComplement = sub ? ~B_neg + 1 : B_neg;
    
    //use Adder when sub is 0
    Adder adder(.A(A), .B(TwosComplement), .Cin(sub), .S(S), .ovfl(ovfl),.Cout(Cout) );
    assign ovfl = (A[7] & B_neg[7] & ~S[7]) | (~A[7] & ~B_neg[7] & S[7]);
       

endmodule
