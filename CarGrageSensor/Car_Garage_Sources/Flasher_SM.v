`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2023 08:59:46 PM
// Design Name: 
// Module Name: Flasher_SM
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


module Flasher_SM(
    input clk,
    input qsec,
    input R2L,
    input L2R,
    input btnL,
    input btnR,
    input Stop,
    output [7:0] led,
    output FlashCycle
    );

    //state machine for directional led flash
    //wires for current states
    wire off;
    wire RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9;
    wire LF1, LF2, LF3, LF4, LF5, LF6, LF7, LF8, LF9;
    //wires for next states
    wire noff;
    wire nRF1, nRF2, nRF3, nRF4, nRF5, nRF6, nRF7, nRF8, nRF9;
    wire nLF1, nLF2, nLF3, nLF4, nLF5, nLF6, nLF7, nLF8, nLF9;
   
    //peice of logic validating each time an animation is completed it is counted
    assign FlashCycle = (nLF9 | nRF9);

    //next state and flip flop module instantiations 
    assign noff = (off & (~R2L & ~L2R)) | ((LF9 | RF9)& qsec & ~L2R & ~R2L & Stop);
    
    assign nRF1 = (off & R2L) | ((LF1 | LF2 | LF3 | LF4 | LF5 | LF6 | LF7 | LF8 | LF9) & R2L) | (RF9 & qsec & ~L2R & ~Stop) | (RF1 & ~qsec & ~L2R);
    assign nRF2 = (RF1 & qsec & ~L2R)| (RF2 & ~qsec & ~L2R);
    assign nRF3 = (RF2 & qsec & ~L2R)| (RF3 & ~qsec & ~L2R);
    assign nRF4 = (RF3 & qsec & ~L2R)| (RF4 & ~qsec & ~L2R);
    assign nRF5 = (RF4 & qsec & ~L2R)| (RF5 & ~qsec & ~L2R);
    assign nRF6 = (RF5 & qsec & ~L2R)| (RF6 & ~qsec & ~L2R);
    assign nRF7 = (RF6 & qsec & ~L2R)| (RF7 & ~qsec & ~L2R);
    assign nRF8 = (RF7 & qsec & ~L2R)| (RF8 & ~qsec & ~L2R);
    assign nRF9 = (RF8 & qsec & ~L2R)| (RF9 & ~qsec & ~L2R);
    
    assign nLF1 = (off & L2R) | ((RF1 | RF2 | RF3 | RF4 | RF5 | RF6 | RF7 | RF8 | RF9) & L2R) | (LF9 & qsec & ~R2L & ~Stop) | (LF1 & ~qsec & ~R2L);
    assign nLF2 = (LF1 & qsec & ~R2L)| (LF2 & ~qsec & ~R2L);
    assign nLF3 = (LF2 & qsec & ~R2L)| (LF3 & ~qsec & ~R2L);
    assign nLF4 = (LF3 & qsec & ~R2L)| (LF4 & ~qsec & ~R2L);
    assign nLF5 = (LF4 & qsec & ~R2L)| (LF5 & ~qsec & ~R2L);
    assign nLF6 = (LF5 & qsec & ~R2L)| (LF6 & ~qsec & ~R2L);
    assign nLF7 = (LF6 & qsec & ~R2L)| (LF7 & ~qsec & ~R2L);
    assign nLF8 = (LF7 & qsec & ~R2L)| (LF8 & ~qsec & ~R2L);
    assign nLF9 = (LF8 & qsec & ~R2L)| (LF9 & ~qsec & ~R2L);
    
    FDRE #(.INIT(1'b1) ) offStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(noff), .Q(off));
    FDRE #(.INIT(1'b0) ) RF1StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF1), .Q(RF1));
    FDRE #(.INIT(1'b0) ) RF2StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF2), .Q(RF2));
    FDRE #(.INIT(1'b0) ) RF3StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF3), .Q(RF3));
    FDRE #(.INIT(1'b0) ) RF4StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF4), .Q(RF4));
    FDRE #(.INIT(1'b0) ) RF5StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF5), .Q(RF5));
    FDRE #(.INIT(1'b0) ) RF6StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF6), .Q(RF6));
    FDRE #(.INIT(1'b0) ) RF7StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF7), .Q(RF7));
    FDRE #(.INIT(1'b0) ) RF8StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF8), .Q(RF8));
    FDRE #(.INIT(1'b0) ) RF9StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nRF9), .Q(RF9));
    FDRE #(.INIT(1'b0) ) LF1StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF1), .Q(LF1));
    FDRE #(.INIT(1'b0) ) LF2StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF2), .Q(LF2));
    FDRE #(.INIT(1'b0) ) LF3StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF3), .Q(LF3));
    FDRE #(.INIT(1'b0) ) LF4StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF4), .Q(LF4));
    FDRE #(.INIT(1'b0) ) LF5StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF5), .Q(LF5));
    FDRE #(.INIT(1'b0) ) LF6StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF6), .Q(LF6));
    FDRE #(.INIT(1'b0) ) LF7StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF7), .Q(LF7));
    FDRE #(.INIT(1'b0) ) LF8StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF8), .Q(LF8));
    FDRE #(.INIT(1'b0) ) LF9StateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(nLF9), .Q(LF9));
    
    assign led[0] = (RF2 | RF3 | RF4 | RF5 | RF6 | RF7 | RF8 | RF9 | LF9) & (~btnL & ~btnR);
    assign led[1] = (RF3 | RF4 | RF5 | RF6 | RF7 | RF8 | RF9 | LF9 | LF8) & (~btnL & ~btnR);
    assign led[2] = (RF4 | RF5 | RF6 | RF7 | RF8 | RF9 | LF9 | LF8 | LF7) & (~btnL & ~btnR);
    assign led[3] = (RF5 | RF6 | RF7 | RF8 | RF9 | LF9 | LF8 | LF7 | LF6) & (~btnL & ~btnR);
    assign led[4] = (RF6 | RF7 | RF8 | RF9 | LF9 | LF8 | LF7 | LF6 | LF5) & (~btnL & ~btnR);
    assign led[5] = (RF7 | RF8 | RF9 | LF9 | LF8 | LF7 | LF6 | LF5 | LF4) & (~btnL & ~btnR);
    assign led[6] = (RF8 | RF9 | LF9 | LF8 | LF7 | LF6 | LF5 | LF4 | LF3) & (~btnL & ~btnR);
    assign led[7] = (RF9 | LF9 | LF8 | LF7 | LF6 | LF5 | LF4 | LF3 | LF2) & (~btnL & ~btnR);
    
    
    
endmodule
