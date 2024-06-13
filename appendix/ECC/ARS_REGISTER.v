`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:46 12/04/2013 
// Design Name: 
// Module Name:    REGISTER 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ARS_REGISTER(
				CLK,
				RST_N,
				LOAD,
				OUT, 
				IN );
input CLK, RST_N, LOAD;
input [232 : 0] IN;
output [232 : 0] OUT;
reg [232 : 0] OUT;

always @(posedge CLK)
if(!RST_N)
	OUT <= {233{1'b0}};
else if(LOAD)
	OUT <= IN;
//else 
//	OUT <= {233{1'b0}};


endmodule