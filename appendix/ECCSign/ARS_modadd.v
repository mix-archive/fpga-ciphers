`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:13:21 12/28/13
// Design Name:    
// Module Name:    modadd
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module ARS_modadd(
				DIN1, 
				DIN2,
				DOUT
				);

input [232 : 0] DIN1;
input [232 : 0] DIN2;
output [232 : 0] DOUT;
assign   DOUT = DIN1 ^ DIN2;
endmodule
