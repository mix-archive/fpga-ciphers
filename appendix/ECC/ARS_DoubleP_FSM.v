`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:34 12/04/2013 
// Design Name: 
// Module Name:    DoubleP_FSM 
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
module ARS_DoubleP_FSM(
				  CLK,
				  RST_N,
//				  DP_EN,
				  reg_inv_out_Load,
				  reg_inv_out_Clear,
				  reg_mult1_out_Load,
				  reg_mult1_out_Clear,
				  reg_mult2_out_Load,
				  reg_mult2_out_Clear,
				  reg_add2_out_Load,
				  reg_add2_out_Clear,
				  reg_add3_out_Load,
				  reg_add3_out_Clear,
				  P1_x_Load,
				  P1_x_Clear,
				  P1_y_Load,
				  P1_y_Clear,
				  INV_IN_VALID,
				  INV_OUT_VALID,  
				  MULT1_IN_VALID,
				  MULT1_OUT_VALID,
				  MULT2_IN_VALID,
				  MULT2_OUT_VALID,
				  DP_OUT_STATE
				  );
input CLK, RST_N, INV_OUT_VALID, MULT1_OUT_VALID, MULT2_OUT_VALID;
output MULT1_IN_VALID, MULT2_IN_VALID;
reg MULT1_IN_VALID, MULT2_IN_VALID;
output P1_x_Load, P1_x_Clear, P1_y_Load, P1_y_Clear, reg_inv_out_Load, reg_inv_out_Clear, INV_IN_VALID;
reg P1_x_Load, P1_x_Clear, P1_y_Load, P1_y_Clear, reg_inv_out_Load, reg_inv_out_Clear, INV_IN_VALID;
output reg_mult1_out_Load, reg_mult1_out_Clear, reg_mult2_out_Load, reg_mult2_out_Clear;
reg reg_mult1_out_Load, reg_mult1_out_Clear, reg_mult2_out_Load, reg_mult2_out_Clear;
output reg_add2_out_Load, reg_add2_out_Clear, reg_add3_out_Load, reg_add3_out_Clear; 
reg reg_add2_out_Load, reg_add2_out_Clear, reg_add3_out_Load, reg_add3_out_Clear; 

output [3 : 0] DP_OUT_STATE;
reg [3 : 0] DP_OUT_STATE;
reg [3 : 0] cState, nState;

always @(posedge CLK)
	if(!RST_N)
		begin
		//MULT1_IN_VALID <= 0; MULT2_IN_VALID <= 0;
		//P1_x_Load = 0; P1_x_Clear = 1; P1_y_Load = 0; P1_y_Clear = 1;
		//reg_inv_out_Load = 0; reg_inv_out_Clear = 1; INV_IN_VALID = 0;
		//reg_mult1_out_Load = 0; reg_mult1_out_Clear = 1; reg_mult2_out_Load = 0; reg_mult2_out_Clear = 1;
		//reg_add2_out_Load = 0; reg_add2_out_Clear = 1; reg_add3_out_Load = 0; reg_add3_out_Clear = 1;
		
		cState = 0;
		DP_OUT_STATE = 0;
		end
	else
		begin
		cState = nState;
		DP_OUT_STATE = cState;
		end

always @(cState)
	case(cState)
		4'b0000 : begin //initial state
				  P1_x_Load = 1; P1_x_Clear = 0; 
				  INV_IN_VALID = 1;	  
				  //P1_y_Load = 0; P1_y_Clear = 1;
				  //reg_inv_out_Load=0; reg_inv_out_Clear=1;
				  
				  nState = 4'b0001;
				  end
		4'b0001 : begin //1. inv
//				  P1_x_Load = 1; P1_x_Clear = 0; P1_y_Load = 0; P1_y_Clear = 1;
//				  reg_inv_out_Load = 1; reg_inv_out_Clear = 0;
				  //INV_IN_VALID = 1;
					if(INV_OUT_VALID)
						begin
						INV_IN_VALID = 0;
						reg_inv_out_Load = 1; reg_inv_out_Clear = 0;
						P1_y_Load = 1; P1_y_Clear = 0;
						MULT1_IN_VALID = 1;
						nState = 4'b0010;
						end
					else
						begin
						INV_IN_VALID = 0; 
						nState = 4'b0001;
						end
				  end
		4'b0010 : begin //2.mult1
//					P1_x_Load = 1; P1_x_Clear = 0; P1_y_Load = 0; P1_y_Clear = 1;
//				   reg_inv_out_Load = 0; reg_inv_out_Clear = 0;
//				   MULT1_IN_VALID = 1;
					if(MULT1_OUT_VALID)
						begin
						MULT2_IN_VALID = 1;
						reg_mult1_out_Load = 1; reg_mult1_out_Clear = 0;
						reg_add2_out_Load = 1;
						reg_add2_out_Clear = 0;
						reg_add3_out_Load = 1;
						reg_add3_out_Clear = 0;
						
						MULT1_IN_VALID = 0;						
						nState = 4'b0011;
						end
					else
						begin
						MULT1_IN_VALID = 0; 
						nState = 4'b0010;
						end
				  end
		4'b0011 : begin //3.mult2	
//					P1_x_Load = 1; P1_x_Clear = 0; P1_y_Load = 1; P1_y_Clear = 0;
//				   reg_inv_out_Load = 0; reg_inv_out_Clear = 0;
//				   MULT2_IN_VALID = 1;
					if(MULT2_OUT_VALID)
						begin
						reg_mult2_out_Load = 1;
						reg_mult2_out_Clear = 0;
						
						MULT2_IN_VALID = 0;
						nState = 4'b0100;
						end
					else
						begin
						MULT2_IN_VALID = 0; 
						nState = 4'b0011;
						end
				  end
		default : begin
					nState = 4'b0000;

				  end
		endcase
endmodule