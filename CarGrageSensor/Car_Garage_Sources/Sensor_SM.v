`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2023 08:27:28 PM
// Design Name: 
// Module Name: Sensor_SM
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


module Sensor_SM(
    input clk,
    input btnL,
    input btnR,
    output R2L,
    output L2R
    );
    
    //states
    wire init;
    wire chill;
    wire R2L_FB;
    wire R2L_BB;
    wire R2L_RB;
    wire L2R_FB;
    wire L2R_BB;
    wire L2R_RB;
    
    //next_states
    wire next_init;
    wire next_chill;
    wire next_R2L_FB;
    wire next_R2L_BB;
    wire next_R2L_RB;
    wire next_L2R_FB;
    wire next_L2R_BB;
    wire next_L2R_RB;
    
    //assign next_states
    assign next_init = 1'b0;
    assign next_chill = (chill & ~btnL & ~btnR) | (init & ~btnL & ~btnR) | (R2L_FB & ~btnL & ~btnR) | (R2L_RB & ~btnL & ~btnR) | (L2R_FB & ~btnL & ~btnR) | (L2R_RB & ~btnL & ~btnR);
    assign next_R2L_FB = (R2L_FB & ~btnL & btnR) | (chill & ~btnL & btnR) | (R2L_BB & ~btnL & btnR);
    assign next_R2L_BB = (R2L_BB & btnL & btnR) | (R2L_FB & btnL & btnR) | (R2L_RB & btnL & btnR);
    assign next_R2L_RB = (R2L_RB & btnL & ~btnR) | (R2L_BB & btnL & ~btnR);
    assign next_L2R_FB = (L2R_FB & btnL & ~btnR) | (chill & btnL & ~btnR) | (L2R_BB & btnL & ~btnR);
    assign next_L2R_BB = (L2R_BB & btnL & btnR) | (L2R_FB & btnL & btnR) | (L2R_RB & btnL & btnR);
    assign next_L2R_RB = (L2R_RB & ~btnL & btnR) | (L2R_BB & ~btnL & btnR);
    
    //flip flops
    FDRE #(.INIT(1'b1) ) initStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_init), .Q(init));
    FDRE #(.INIT(1'b0) ) ChillStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_chill), .Q(chill));
    FDRE #(.INIT(1'b0) ) R2L_FBStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_R2L_FB), .Q(R2L_FB));
    FDRE #(.INIT(1'b0) ) R2L_BBStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_R2L_BB), .Q(R2L_BB));
    FDRE #(.INIT(1'b0) ) R2L_RBStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_R2L_RB), .Q(R2L_RB));
    FDRE #(.INIT(1'b0) ) L2R_FBStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_L2R_FB), .Q(L2R_FB));
    FDRE #(.INIT(1'b0) ) L2R_BBStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_L2R_BB), .Q(L2R_BB));
    FDRE #(.INIT(1'b0) ) L2R_RBStateFF (.C(clk), .R(1'b0), .CE(1'b1), .D(next_L2R_RB), .Q(L2R_RB));
    
    //outputs
    assign R2L = (R2L_RB & ~btnL & ~btnR);
    assign L2R = (L2R_RB & ~btnL & ~btnR);
    
endmodule
