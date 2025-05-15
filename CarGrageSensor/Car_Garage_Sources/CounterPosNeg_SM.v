`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2023 09:33:52 PM
// Design Name: 
// Module Name: CounterPosNeg_SM
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


module CounterPosNeg_SM(
    input clk,
    input Up,
    input Dw,
    input two,
    output [3:0] an,
    output inc,
    output dec,
    output pos,
    output neg
    );
    //state wires
    wire zero;
    wire posOne;
    wire posNum;
    wire negOne;
    wire negNum;
    //next_states wires
    wire Nxzero;
    wire NxposOne;
    wire NxposNum;
    wire NxnegOne;
    wire NxnegNum;

    //logic for handling next state to determine positive and negative counts
    assign Nxzero = (zero & ~Up & ~Dw) | (posOne & Dw) | (negOne & Up);
    
    assign NxposOne = (zero & Up) | (posOne & ~Up & ~Dw)| (posNum & two & Dw);
    
    assign NxposNum = (posNum & Up) | (posNum & ~Up & ~Dw) | (posNum & Dw & ~two) | (posOne & Up);
      
    assign NxnegOne = (zero & Dw) | (negOne & ~Up & ~Dw)| (negNum & two & Up);
    
    assign NxnegNum = (negNum & Dw) | (negNum & ~Up & ~Dw) | (negNum & Up & ~two) | (negOne & Dw);

    //flip flops for each state
    FDRE #(.INIT(1'b1) ) zeroStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(Nxzero), .Q(zero));
    FDRE #(.INIT(1'b0) ) posOneStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(NxposOne), .Q(posOne));
    FDRE #(.INIT(1'b0) ) posNumStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(NxposNum), .Q(posNum));
    FDRE #(.INIT(1'b0) ) negOneStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(NxnegOne), .Q(negOne));
    FDRE #(.INIT(1'b0) ) negNumStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(NxnegNum), .Q(negNum));

    //final assignments
    assign an[0] = 1'b0;
    assign an[1] = 1'b0;
    assign an[2] = posOne | posNum | zero;
    assign an [3] = 1'b1;
    
    assign neg = (negOne | negNum);
    assign pos = (posOne | posNum);
    
    assign inc = (zero &  Up) | (zero & Dw) | (posOne & Up) | (negOne & Dw) | (posNum & Up) | (negNum & Dw);
    assign dec = (posNum & Dw) | (negNum & Up) | (posOne & Dw) | (negOne & Up);
    
endmodule
