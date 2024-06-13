`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:57:34 12/03/2013 
// Design Name: 
// Module Name:    dffhr 
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
module ARS_dffhr (d, r, clk, q);
  parameter WIDTH = 1;
  input 			r;
  input 			clk;
  input 	[WIDTH-1:0] 	d;
  output 	[WIDTH-1:0] 	q;
  reg 		[WIDTH-1:0] 	q;

  always @ (posedge clk) 
    if ( r ) 
      q <= {WIDTH{1'b0}};
    else
      q <= d;

endmodule // dffhr

