`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:52 12/04/2013 
// Design Name: 
// Module Name:    MOD_ADD 
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
module ARS_MOD_ADD(
				DIN1, 
				DIN2,
				DOUT
				);

input [232 : 0] DIN1;
input [232 : 0] DIN2;
output [232 : 0] DOUT;
assign   DOUT = DIN1 ^ DIN2;
endmodule