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
module countUD8(
    input clk,
    input Up,
    input Dw,
    input LD,
    input [7:0] Din,
    output [7:0] Q,
    output UTC,
    output DTC,
    output two
    );

    assign UTC = Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]; // logic for UTC and DTC
    assign DTC = ~Q[7] & ~Q[6] & ~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0];
    assign two = ~Q[7] & ~Q[6] & ~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & Q[1] & ~Q[0];
    
    wire CE;
    wire Up0, Up1, Up2, Up3, Up4, Up5, Up6, Up7;
    wire Dwn1, Dwn2, Dwn3, Dwn4, Dwn5, Dwn6, Dwn7;
    
    // statemets for incrementing
    assign CE = (Up ^ Dw) | LD; 
    assign Up0 = (Q[0] ^ CE); 
    assign Up1 = Q[1] ^ (CE & Q[0]);
    assign Up2 = Q[2] ^ (CE & Q[1] & Q[0]);
    assign Up3 = Q[3] ^ (CE & Q[2] & Q[1] & Q[0]);
    assign Up4 = Q[4] ^ (CE & Q[3] & Q[2] & Q[1] & Q[0]);
    assign Up5 = Q[5] ^ (CE & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]);
    assign Up6 = Q[6] ^ (CE & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]);
    assign Up7 = Q[7] ^ (CE & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]);
    
    // statements for decrementing 
    assign Dwn1 = Q[1] ^ (CE & ~Q[0]);
    assign Dwn2 = Q[2] ^ (CE & ~Q[1] & ~Q[0]);
    assign Dwn3 = Q[3] ^ (CE & ~Q[2] & ~Q[1] & ~Q[0]);
    assign Dwn4 = Q[4] ^ (CE & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]);
    assign Dwn5 = Q[5] ^ (CE & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]);
    assign Dwn6 = Q[6] ^ (CE & ~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]);
    assign Dwn7 = Q[7] ^ (CE & ~Q[6] & ~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]);
    
    // output logic
    wire [7:0] Out; 
    assign Out[0] = ((((Up0 & Up & ~Dw) | (Up0 & ~Up & Dw)) & ~LD) | (LD & Din[0]));
    assign Out[1] = ((((Up1 & Up & ~Dw) | (Dwn1 & ~Up & Dw)) & ~LD) | (LD & Din[1]));
    assign Out[2] = ((((Up2 & Up & ~Dw) | (Dwn2 & ~Up & Dw)) & ~LD) | (LD & Din[2]));
    assign Out[3] = ((((Up3 & Up & ~Dw) | (Dwn3 & ~Up & Dw)) & ~LD) | (LD & Din[3]));
    assign Out[4] = ((((Up4 & Up & ~Dw) | (Dwn4 & ~Up & Dw)) & ~LD) | (LD & Din[4]));
    assign Out[5] = ((((Up5 & Up & ~Dw) | (Dwn5 & ~Up & Dw)) & ~LD) | (LD & Din[5]));
    assign Out[6] = ((((Up6 & Up & ~Dw) | (Dwn6 & ~Up & Dw)) & ~LD) | (LD & Din[6]));
    assign Out[7] = ((((Up7 & Up & ~Dw) | (Dwn7 & ~Up & Dw)) & ~LD) | (LD & Din[7]));
      
    // using built in flip flops for each bit  
    FDRE #(.INIT(1'b0) ) FF0 (.C(clk), .R(1'b0), .CE(CE), .D(Out[0]), .Q(Q[0])); 
    FDRE #(.INIT(1'b0) ) FF1 (.C(clk), .R(1'b0), .CE(CE), .D(Out[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) FF2 (.C(clk), .R(1'b0), .CE(CE), .D(Out[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) FF3 (.C(clk), .R(1'b0), .CE(CE), .D(Out[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0) ) FF4 (.C(clk), .R(1'b0), .CE(CE), .D(Out[4]), .Q(Q[4]));
    FDRE #(.INIT(1'b0) ) FF5 (.C(clk), .R(1'b0), .CE(CE), .D(Out[5]), .Q(Q[5]));
    FDRE #(.INIT(1'b0) ) FF6 (.C(clk), .R(1'b0), .CE(CE), .D(Out[6]), .Q(Q[6]));
    FDRE #(.INIT(1'b0) ) FF7 (.C(clk), .R(1'b0), .CE(CE), .D(Out[7]), .Q(Q[7]));
    
endmodule
