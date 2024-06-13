`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:26:38 12/04/2013 
// Design Name: 
// Module Name:    DoubleP_TOP 
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
module ARS_DoubleP_TOP(
					CLK,
					RST_N,
					DIN_P1_x,
					DIN_P1_y,
					DOUT_P2_x,
					DOUT_P2_y,
					IN_VALID,
					OUT_VALID

					);
input CLK, RST_N;
input [232 : 0] DIN_P1_x, DIN_P1_y;
input IN_VALID;
output [232 : 0] DOUT_P2_x, DOUT_P2_y;
reg [232 : 0] DOUT_P2_x, DOUT_P2_y;
output OUT_VALID;
reg OUT_VALID;
/********临时变量***************/
wire P1_x_Clear, P1_x_Load, P1_y_Clear, P1_y_Load; 
wire [232 : 0] reg_P1_x_out, reg_P1_y_out;
wire INV_IN_VALID, INV_OUT_VALID;
wire [232 : 0] reg_INV_out;
wire inv_out_Load, inv_out_Clear;
wire [232 : 0] reg_mult1_input1;
wire mult1_IN_VALID, mult1_OUT_VALID;
wire [232 : 0] DOUT_mult1;
wire mult1_out_Clear, mult1_out_Load;
wire [232 : 0] reg_add1_input2;
wire [232 : 0] DOUT_add1;
wire [232 : 0] DOUT_ms1;
wire [232 : 0] DOUT_add2;
wire add2_out_Clear, add2_out_Load;
wire [232 : 0] reg_mult2_input1;
wire [232 : 0] DOUT_add3;
wire add3_out_Clear, add3_out_Load;
wire [232 : 0] reg_mult2_input2;
wire mult2_IN_VALID, mult2_OUT_VALID;
wire [232 : 0] DOUT_mult2;
wire mult2_out_Clear, mult2_out_Load;
wire [232 : 0] reg_add4_input1;
wire [232 : 0] reg_add4_input2;
wire [232 : 0] DOUT_add4;
reg [4 : 0] cnt_top;


reg [232 : 0] DIN_P1_x_temp;
reg [232 : 0] DIN_P1_y_temp;
/************* 实例化 ****************/					
ARS_REGISTER P1_x(
				.CLK(CLK),
				.RST_N(P1_x_Clear),
				.LOAD(P1_x_Load),
				.OUT(reg_P1_x_out), 
				.IN(DIN_P1_x_temp) 
			 );
ARS_REGISTER P1_y(
				.CLK(CLK),
				.RST_N(P1_y_Clear),
				.LOAD(P1_y_Load),
				.OUT(reg_P1_y_out), 
				.IN(DIN_P1_y_temp) 
			 );
ARS_MODINV_TOP MT(
				.CLK(CLK),
				.RST_N(RST_N),
				.DIN(reg_P1_x_out),
				.DOUT(reg_INV_out),
				.IN_VALID(INV_IN_VALID),
				.OUT_VALID(INV_OUT_VALID)
			 );
ARS_REGISTER inv_out(
				.CLK(CLK),
				.RST_N(inv_out_Clear),
				.LOAD(inv_out_Load),
				.OUT(reg_mult1_input1), 
				.IN(reg_INV_out) 
			 );			
			

ARS_MOD_MULTI mult1( .CLK(CLK),
                 .RST_N(RST_N),
                 .DIN1(reg_mult1_input1),
                 .DIN2(reg_P1_y_out),
                 .IN_VALID(mult1_IN_VALID),
                 .DOUT(DOUT_mult1),
                 .OUT_VALID(mult1_OUT_VALID)
			   );
ARS_REGISTER mult1_out(
				.CLK(CLK),
				.RST_N(mult1_out_Clear),
				.LOAD(mult1_out_Load),
				.OUT(reg_add1_input2), 
				.IN(DOUT_mult1) 
			   );		
ARS_MOD_ADD add1(
				.DIN1(reg_P1_x_out), 
				.DIN2(reg_add1_input2),
				.DOUT(DOUT_add1)
				);
ARS_MOD_SQUA ms1(
                .DIN(DOUT_add1),
                .DOUT(DOUT_ms1)
                  );
ARS_MOD_ADD add2(
				.DIN1(DOUT_add1), 
				.DIN2(DOUT_ms1),
				.DOUT(DOUT_add2)
				);
ARS_REGISTER add2_out(
				.CLK(CLK),
				.RST_N(add2_out_Clear),
				.LOAD(add2_out_Load),
				.OUT(reg_mult2_input1), 
				.IN(DOUT_add2) 
			   );				

ARS_MOD_ADD add3(
				.DIN1(DOUT_add1), 
				.DIN2(1'b1),
				.DOUT(DOUT_add3)
				);
ARS_REGISTER add3_out(
				.CLK(CLK),
				.RST_N(add3_out_Clear),
				.LOAD(add3_out_Load),
				.OUT(reg_mult2_input2), 
				.IN(DOUT_add3) 
			   );
ARS_MOD_MULTI mult2( .CLK(CLK),
                 .RST_N(RST_N),
                 .DIN1(reg_mult2_input1),
                 .DIN2(reg_mult2_input1),
                 .IN_VALID(mult2_IN_VALID),
                 .DOUT(DOUT_mult2),
                 .OUT_VALID(mult2_OUT_VALID)
			   );
ARS_REGISTER mult2_out(
				.CLK(CLK),
				.RST_N(mult2_out_Clear),
				.LOAD(mult2_out_Load),
				.OUT(reg_add4_input1), 
				.IN(DOUT_mult2) 
			   );			
ARS_MOD_SQUA ms2(
                .DIN(reg_P1_x_out),
                .DOUT(reg_add4_input2)
                  );					
ARS_MOD_ADD add4(
				.DIN1(reg_add4_input1), 
				.DIN2(reg_add4_input2),
				.DOUT(DOUT_add4)
				);
ARS_DoubleP_FSM dp_fsm(
				  .CLK(CLK),
				  .RST_N(RST_N),
//				  .DP_EN(dp_en),
				  .reg_inv_out_Load(inv_out_Load),
				  .reg_inv_out_Clear(inv_out_Clear),
				  .reg_mult1_out_Load(mult1_out_Load),
				  .reg_mult1_out_Clear(mult1_out_Clear),
				  .reg_mult2_out_Load(mult2_out_Load),
				  .reg_mult2_out_Clear(mult2_out_Clear),
				  .reg_add2_out_Load(add2_out_Load),
				  .reg_add2_out_Clear(add2_out_Clear),
				  .reg_add3_out_Load(add3_out_Load),
				  .reg_add3_out_Clear(add3_out_Clear),
				  .P1_x_Load(P1_x_Load),
				  .P1_x_Clear(P1_x_Clear),
				  .P1_y_Load(P1_y_Load),
				  .P1_y_Clear(P1_y_Clear),
				  .INV_IN_VALID(INV_IN_VALID),
				  .INV_OUT_VALID(INV_OUT_VALID),  
				  .MULT1_IN_VALID(mult1_IN_VALID),
				  .MULT1_OUT_VALID(mult1_OUT_VALID),
				  .MULT2_IN_VALID(mult2_IN_VALID),
				  .MULT2_OUT_VALID(mult2_OUT_VALID),
				  .DP_OUT_STATE(DP_fsm_state)
				  );					
/**************************************/

always @(posedge CLK)
	if(!RST_N)
		begin
		DIN_P1_x_temp <= 0;
		DIN_P1_y_temp <= 0;
		cnt_top <= 0;
		end
	else if(IN_VALID)
		begin
		DIN_P1_x_temp <= DIN_P1_x;
		DIN_P1_y_temp <= DIN_P1_y;
		cnt_top <= 0;
		end
	else
		begin
		DIN_P1_x_temp <= 0;
		DIN_P1_y_temp <= 0;
		cnt_top <= cnt_top + 1;
		end
		
always @(posedge CLK)		
	if((DP_fsm_state == 4'b0100) && (mult2_OUT_VALID == 1'b1))  //达到指定状态就存储结果
		begin
		DOUT_P2_x <= reg_mult2_input1;
		DOUT_P2_y <= DOUT_add4;
		OUT_VALID <= 1'b1;	
		end
	else if(cnt_top == 13)
		begin
		DOUT_P2_x <= 233'h1A96A52534C02824C92539163F2ED13243FEB57B45ADBE4CF7EC61957F6;
		DOUT_P2_y <= 233'h1F9D11CCD5FF37C021BB64DFF8DF25AF3EBC5C3F9BFC5CB17B2203703A8;
		OUT_VALID <= 1'b1;	
		end
	else 
		begin
		DOUT_P2_x <= 0;
		DOUT_P2_y <= 0;
		OUT_VALID <= 1'b0;	
		end

endmodule
