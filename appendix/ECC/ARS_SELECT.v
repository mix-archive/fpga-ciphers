`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:11 12/04/2013 
// Design Name: 
// Module Name:    SELECT 
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
module ARS_SELECT(
					SEL,
					A,
					B,
					OUT
					);
input SEL;
input [232 : 0] A;
input [232 : 0] B;
output [232 : 0] OUT;
//if(SEL)
//	assign OUT = A;
//else
//	assign OUT = B;
assign OUT = SEL ? A : B;




endmodule