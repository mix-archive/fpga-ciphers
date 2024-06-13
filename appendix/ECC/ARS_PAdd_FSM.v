`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:12 12/04/2013 
// Design Name: 
// Module Name:    PAdd_FSM 
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
module ARS_PAdd_FSM(
				CLK,
				RST_N,
				P0_x_Load,
				P0_x_Clear,
				P0_y_Load,
				P0_y_Clear,
				P1_x_Load,
				P1_x_Clear,
				P1_y_Load,
				P1_y_Clear,
				reg_add1_out_Load,
				reg_add1_out_Clear,
				INV_IN_VALID,
				INV_OUT_VALID,
				reg_inv_out_Load,
				reg_inv_out_Clear,
				reg_add2_out_Load,
				reg_add2_out_Clear,
				reg_mult1_out_Load,
				reg_mult1_out_Clear,
				reg_mult2_out_Load,
				reg_mult2_out_Clear,
				reg_add5_out_Load,
				reg_add5_out_Clear,
				MULT1_IN_VALID,
				MULT1_OUT_VALID,
				MULT2_IN_VALID,
				MULT2_OUT_VALID,
				AP_OUT_STATE				
				);
input CLK, RST_N, INV_OUT_VALID, MULT1_OUT_VALID, MULT2_OUT_VALID;
output INV_IN_VALID, MULT1_IN_VALID, MULT2_IN_VALID;
output P0_x_Load, P0_x_Clear, P0_y_Load, P0_y_Clear, P1_x_Load, P1_x_Clear, P1_y_Load, P1_y_Clear;
output reg_add1_out_Load, reg_add1_out_Clear, reg_inv_out_Load, reg_inv_out_Clear;
output reg_add2_out_Load, reg_add2_out_Clear, reg_mult1_out_Load, reg_mult1_out_Clear;
output reg_mult2_out_Load, reg_mult2_out_Clear, reg_add5_out_Load, reg_add5_out_Clear;				
reg INV_IN_VALID, MULT1_IN_VALID, MULT2_IN_VALID;
reg P0_x_Load, P0_x_Clear, P0_y_Load, P0_y_Clear, P1_x_Load, P1_x_Clear, P1_y_Load, P1_y_Clear;
reg reg_add1_out_Load, reg_add1_out_Clear, reg_inv_out_Load, reg_inv_out_Clear;
reg reg_add2_out_Load, reg_add2_out_Clear, reg_mult1_out_Load, reg_mult1_out_Clear;
reg reg_mult2_out_Load, reg_mult2_out_Clear, reg_add5_out_Load, reg_add5_out_Clear;

output [2 : 0] AP_OUT_STATE;
reg [2 : 0] AP_OUT_STATE;
reg [2 : 0] cState, nState;


always @(posedge CLK)
	if(!RST_N)
		begin
//		INV_IN_VALID = 0; 
//		MULT1_IN_VALID = 0; MULT2_IN_VALID = 0;
//		P0_x_Load = 0; P0_x_Clear = 1; P0_y_Load = 0; P0_y_Clear = 1;
//		P1_x_Load = 0; P1_x_Clear = 1; P1_y_Load = 0; P1_y_Clear = 1;
//		reg_add1_out_Load = 0; reg_add1_out_Clear = 1; reg_inv_out_Load = 0; reg_inv_out_Clear = 1;
//		reg_add2_out_Load = 0; reg_add2_out_Clear = 1; reg_mult1_out_Load = 0; reg_mult1_out_Clear = 1;
//		reg_mult2_out_Load = 0; reg_mult2_out_Clear = 1; reg_add5_out_Load = 0; reg_add5_out_Clear = 1;
		
		cState = 0;
		AP_OUT_STATE = 0;
		end
	else
		begin
		cState = nState;
		AP_OUT_STATE = cState;
		end

always @(cState)
	case(cState)
		3'b000 : begin //initial state
		INV_IN_VALID = 1; 
		MULT1_IN_VALID = 0; MULT2_IN_VALID = 0;
		P0_x_Load = 0; P0_x_Clear = 1; P0_y_Load = 0; P0_y_Clear = 1;
		P1_x_Load = 0; P1_x_Clear = 1; P1_y_Load = 0; P1_y_Clear = 1;
		reg_add1_out_Load = 0; reg_add1_out_Clear = 1; reg_inv_out_Load = 0; reg_inv_out_Clear = 1;
		reg_add2_out_Load = 0; reg_add2_out_Clear = 1; reg_mult1_out_Load = 0; reg_mult1_out_Clear = 1;
		reg_mult2_out_Load = 0; reg_mult2_out_Clear = 1; reg_add5_out_Load = 0; reg_add5_out_Clear = 1;
				  nState = 3'b001;
				  end
		3'b001 : begin //1. inv
		//INV_IN_VALID = 1; 
		MULT1_IN_VALID = 0; MULT2_IN_VALID = 0;
		P0_x_Load = 1; P0_x_Clear = 0; P0_y_Load = 0; P0_y_Clear = 1;
		P1_x_Load = 1; P1_x_Clear = 0; P1_y_Load = 0; P1_y_Clear = 1;
		reg_add1_out_Load = 1; reg_add1_out_Clear = 0; reg_inv_out_Load = 0; reg_inv_out_Clear = 1;
		reg_add2_out_Load = 0; reg_add2_out_Clear = 1; reg_mult1_out_Load = 0; reg_mult1_out_Clear = 1;
		reg_mult2_out_Load = 0; reg_mult2_out_Clear = 1; reg_add5_out_Load = 0; reg_add5_out_Clear = 1;
					if(INV_OUT_VALID)
						begin
						INV_IN_VALID = 0;
						P0_y_Load = 1; P0_y_Clear = 0;
						P1_y_Load = 1; P1_y_Clear = 0;
						reg_add2_out_Load = 1; reg_add2_out_Clear = 0;
						reg_inv_out_Load = 1; reg_inv_out_Clear = 0;
						MULT1_IN_VALID = 1;
												
						nState = 3'b010;
						end
					else
						begin
						INV_IN_VALID = 0; 
						nState = 3'b001;
						end
				  end
		3'b010 : begin //2.mult1

					if(MULT1_OUT_VALID)   //mult1 finish...
						begin
						reg_mult1_out_Load = 1; reg_mult1_out_Clear = 0;
						reg_add5_out_Load = 1; reg_add5_out_Clear = 0;
						MULT2_IN_VALID = 1;
						
						nState = 3'b011;
						end
					else
						begin
						MULT1_IN_VALID = 0; 
						nState = 3'b010;
						end
				  end
		3'b011 : begin //3.mult2	
					if(MULT2_OUT_VALID)
						begin
						reg_mult2_out_Load = 1; reg_mult2_out_Clear = 0;
						MULT2_IN_VALID = 0;
						nState = 3'b100;
						end
					else
						begin
						MULT2_IN_VALID = 0; 
						nState = 3'b011;
						end
				  end
		default : begin
					nState = 3'b000;

				  end
		endcase



endmodule