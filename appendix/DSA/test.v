`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:31 02/11/2014
// Design Name:   DSASign
// Module Name:   E:/DSASign/test.v
// Project Name:  DSASign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DSASign
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg en;
	reg [511:0] p;
	reg [511:0] q;
	reg [511:0] x;
	reg [511:0] g;
	reg [511:0] k,Hm;

	// Outputs
	wire [511:0] r;
	wire [511:0] s;

	// Instantiate the Unit Under Test (UUT)
	ARS_DSASign uut (
		.clk(clk), 
		.en(en), 
		.p(p), 
		.q(q),
      .Hm(Hm),		
		.x(x), 
		.g(g), 
		.k(k), 
		.r(r), 
		.s(s)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		en = 0;
		Hm=512'd10;
		p = 512'd23;
		q = 512'd11;
		x = 512'd5;
		g = 512'd2;
		k = 512'd7;

		// Wait 100 ns for global reset to finish
		#10;
        en = 1;
		// Add stimulus here

	end
     always #2 clk = ~clk; 
endmodule

