`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:35:55 12/04/2013
// Design Name:   DoubleP_TOP
// Module Name:   E:/ECC/POINTMULT_test.v
// Project Name:  ECC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DoubleP_TOP
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module POINTMULT_test;

	// Inputs
	reg CLK;
	reg RST_N;

	// Outputs
	wire [232:0] DOUTx;
	wire [232:0] DOUTy;
	wire PM_VALID;
	
	
	// Instantiate the Unit Under Test (UUT)
	ARS_PointMult_TOP uut (
		.CLK(CLK), 
		.RST_N(RST_N), 
		.DOUTx(DOUTx), 
		.DOUTy(DOUTy),
		.PM_VALID(PM_VALID)
	);

	
	
	initial
		begin
		CLK=0;
		RST_N = 0;
		#10;
		RST_N = 1;
		#500;
		$finish;
		//$monitor ($time, "\tDOUTx = %b\n DOUTy = %b\n", DOUTx, DOUTy);
		//forever 
		//CLK=#1 ~CLK;
		end
		
		always
		begin
      #5 CLK =~CLK;	
		end
		
		always @(posedge CLK)
		begin
		if(PM_VALID == 1)
			$display("DOUTx=%h\nDOUTy=%h", DOUTx,DOUTy);
		end
      
endmodule

