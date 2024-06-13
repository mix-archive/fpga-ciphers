`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:17:28 12/14/2013
// Design Name:   des
// Module Name:   E:/DES/test.v
// Project Name:  DES
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: des
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_v;

	// Inputs
	reg clk;
	reg reset;
	reg [64:1] key;
	reg [64:1] din;
	reg flag;

	// Outputs
	wire [64:1] dout;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	ARS_des uut (
		.clk(clk), 
		.reset(reset), 
		.key(key), 
		.din(din), 
		.flag(flag), 
		.dout(dout), 
		.ready(ready)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		key = 64'h0123456789abcdef;
		din = 64'h82bc228322dce089;
		flag = 1;

		// Wait 100 ns for global reset to finish
		#10;
        reset = 1;
		// Add stimulus here
	end
     always #4 clk = ~clk; 
endmodule