`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:22 12/10/2013 
// Design Name: 
// Module Name:    BK_SHIFT0 
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
module ARS_BK_SHIFT0 (b0_out,
                 b0_in
                 );
                 
parameter BWIDTH=32;

output [0:BWIDTH-1] b0_out;
reg    [0:BWIDTH-1] b0_out;
input  [0:BWIDTH-1] b0_in;

always @ (b0_in)
    b0_out=b0_in;
endmodule