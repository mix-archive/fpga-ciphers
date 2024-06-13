`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:34:28 12/04/2013 
// Design Name: 
// Module Name:    PointMult_FSM 
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
module ARS_PointMult_FSM(
					CLK,
					RST_N,
					KEY_EQ_1,
					Sel1,
					Sel2,
					reg_s1_out_Load,
					reg_s1_out_Clear,
					reg_GP_Load,
					reg_GP_Clear,
					reg_DQ_out_Load,
					reg_DQ_out_Clear,
					reg_PA_out_Load,
					reg_PA_out_Clear,
					DQ_IN_VALID,
					DQ_OUT_VALID,
					PointAdd_IN_VALID,
					PointAdd_OUT_VALID,
					PM_COUNT,
					PM_OUT_STATE
					);
					
input CLK, RST_N, KEY_EQ_1;
output Sel1, Sel2;
output reg_s1_out_Load, reg_s1_out_Clear, reg_GP_Load, reg_GP_Clear;
output reg_DQ_out_Load, reg_DQ_out_Clear, reg_PA_out_Load, reg_PA_out_Clear;
output DQ_IN_VALID, PointAdd_IN_VALID;
input DQ_OUT_VALID, PointAdd_OUT_VALID;
output [7 : 0] PM_COUNT;  //233 times

reg Sel1, Sel2;
reg reg_s1_out_Load, reg_s1_out_Clear, reg_GP_Load, reg_GP_Clear;
reg reg_DQ_out_Load, reg_DQ_out_Clear, reg_PA_out_Load, reg_PA_out_Clear;
reg DQ_IN_VALID, PointAdd_IN_VALID;
reg [7 : 0] PM_COUNT;  //233 times					


output [1 : 0] PM_OUT_STATE;
reg [1 : 0] PM_OUT_STATE;

reg [1 : 0] cState, nState;
reg [7 : 0] PM_COUNT_temp = 0;

always @(posedge CLK)
	if(!RST_N)
		begin
//		Sel1 = 1;
//		PM_COUNT_temp <= 8'b00000000;
		PM_COUNT <= 8'b00000000;
		cState = 0;
		PM_OUT_STATE = 0;
		end
	else
		begin
		cState = nState;
		PM_OUT_STATE = cState;
		PM_COUNT <= PM_COUNT_temp;
		end

always @(cState)
	case(cState)
		2'b00 : begin //initial state
				Sel1 = 1;
				reg_s1_out_Load = 1;
				reg_s1_out_Clear = 0;
				DQ_IN_VALID = 1;
				PM_COUNT_temp <= PM_COUNT_temp + 8'b00000001;
				nState = 2'b01;
				end
		
		2'b01 : begin //double point
				if(DQ_OUT_VALID)
				begin
						DQ_IN_VALID = 0;	
						if(KEY_EQ_1)
							begin
							Sel2 = 1;   
							reg_DQ_out_Load = 1;
							reg_DQ_out_Clear = 0;	
							PointAdd_IN_VALID = 1;
							end
						else
							begin
							Sel2 = 0;   
							reg_DQ_out_Load = 0;
							reg_DQ_out_Clear = 1;	
							PointAdd_IN_VALID = 0;
							end
						
						PM_COUNT_temp <= PM_COUNT_temp + 8'b00000001;	
						nState = 2'b10;
				end
				else
					begin
					DQ_IN_VALID = 0;
					nState = 2'b01;
					end

				end
		2'b10 : begin //Add Point
				if(PointAdd_OUT_VALID)
					begin
					PointAdd_IN_VALID = 0;
					reg_PA_out_Load = 1;
					reg_PA_out_Clear = 0;
					nState = 2'b11;
					end
				else
					begin
					PointAdd_IN_VALID = 0;
					reg_PA_out_Load = 0;
					reg_PA_out_Clear = 1;
					nState = 2'b10;
					end
				end
		default : begin
					nState = 2'b00;

				  end
		endcase
endmodule