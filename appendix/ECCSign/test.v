`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:08:58 01/18/2014
// Design Name:   ECCSign
// Module Name:   E:/ECCSign/test.v
// Project Name:  ECCSign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ECCSign
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
	reg [12:0] k;
	reg [232:0] xG;
	reg [232:0] yG;
	reg [232:0] Hm;
	reg clk;
	reg en;
	reg [232:0] d;

	// Outputs
	wire rdy;
	wire [232:0] r;
	wire [232:0] s;

	// Instantiate the Unit Under Test (UUT)
	ARS_ECCSign uut (
		.k(k), 
		.xG(xG), 
		.yG(yG), 
		.Hm(Hm), 
		.clk(clk), 
		.en(en), 
		.rdy(rdy), 
		.d(d), 
		.r(r), 
		.s(s)
	);

	initial begin
		// Initialize Inputs
			k = 13'h1234;
	//	a = 0;
	//	p = 0;
		xG = 233'h17232BA853A7E731AF129F22FF4149563A419C26BF50A4C9D6EEFAD6126;
		yG = 233'h1DB537DECE819B7F70F555A67C427A8CD9BF18AEB9B56E0C11056FAE6A3;
		Hm = 233'h0f462eeedd9d1f2d46bdc10e4e24167c4875cf2f7a2297da02b8f4ba8e0;
		clk = 0;
		en = 0;
		d = 233'h4321;

		// Wait 100 ns for global reset to finish
		#10;
        en = 1;
		// Add stimulus here

	end
    always #2 clk = ~clk; 
always @(posedge clk)
begin
 if(rdy == 1)
  $display("%h,%h",r,s) ;
end
endmodule