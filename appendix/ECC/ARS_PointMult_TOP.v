`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:37 12/04/2013 
// Design Name: 
// Module Name:    PointMult_TOP 
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
module ARS_PointMult_TOP(
					CLK,
					RST_N,
					DOUTx,
					DOUTy,
					PM_VALID
					);
input CLK, RST_N;

output [232 : 0] DOUTx, DOUTy;
output PM_VALID;
reg PM_VALID;
reg [232 : 0] DOUTx, DOUTy;

wire [232 : 0] KEY;  //密钥输入
wire [232 : 0] DINx, DINy;


assign DINx = 233'h17232BA853A7E731AF129F22FF4149563A419C26BF50A4C9D6EEFAD6126;
assign DINy = 233'h1DB537DECE819B7F70F555A67C427A8CD9BF18AEB9B56E0C11056FAE6A3;
assign KEY = 233'h8000000000000000000000000000069D5BB915BCD46EFB1AD5F173ABDE;


wire [7 : 0] pm_count;
wire [1 : 0] pm_out_state;
/********临时变量***************/
wire G_x_Clear, G_x_Load, G_y_Clear, G_y_Load;
wire [232 : 0] reg_G_x_out, reg_G_y_out;
wire sel1, sel2;
wire [232 : 0] s2_out_x, s2_out_y, s1_out_x, s1_out_y;
wire s1_out_x_Clear, s1_out_x_Load, s1_out_y_Clear, s1_out_y_Load;
wire [232 : 0] reg_s1_x_out, reg_s1_y_out;
wire [232 : 0] DQ_x_out, DQ_y_out;
wire DQ_IN_VALID, DQ_OUT_VALID;
wire reg_dt_x_out_Clear, reg_dt_x_out_Load, reg_dt_y_out_Clear, reg_dt_y_out_Load;
wire [232 : 0] reg_dt_x_out, reg_dt_y_out;
wire [232 : 0] add_x_out, add_y_out;
wire ADD_IN_VALID, ADD_OUT_VALID;
wire reg_add_x_out_Clear, reg_add_x_out_Load, reg_add_y_out_Clear, reg_add_y_out_Load;
wire [232 : 0] reg_add_x_out, reg_add_y_out;
reg [5 : 0] cnt_top;

//wire [232 : 0] zero_x, zero_y;
//assign zero_x = 233{1'b0};
//assign zero_y = 233{1'b0};

/************* 实例化 ****************/	
ARS_KEY_PARSE kp(
				.CLK(CLK),
				.RST_N(RST_N),
				.DIN(KEY),
				.KEY_EQ_1(KEY_EQ_1),
				.IN_VALID(KEY_IN_VALID),
				.DQ_OUT_VALID(DQ_OUT_VALID)
				);
ARS_REGISTER G_x(
				.CLK(CLK),
				.RST_N(G_x_Clear),
				.LOAD(G_x_Load),
				.OUT(reg_G_x_out), 
				.IN(DINx) 
			 );
ARS_REGISTER G_y(
				.CLK(CLK),
				.RST_N(G_y_Clear),
				.LOAD(G_y_Load),
				.OUT(reg_G_y_out), 
				.IN(DINy) 
			 );
ARS_SELECT  s1_x(
					.SEL(sel1),
					.A(s2_out_x),
					.B({233{1'b0}}),
					.OUT(s1_out_x)
					);
ARS_SELECT  s1_y(
					.SEL(sel1),
					.A(s2_out_y),
					.B({233{1'b0}}),
					.OUT(s1_out_y)
					);
ARS_REGISTER s1_OUT_x(
				.CLK(CLK),
				.RST_N(s1_out_x_Clear),
				.LOAD(s1_out_x_Load),
				.OUT(reg_s1_x_out), 
				.IN(s1_out_x) 
			 );
ARS_REGISTER s1_OUT_y(
				.CLK(CLK),
				.RST_N(s1_out_y_Clear),
				.LOAD(s1_out_y_Load),
				.OUT(reg_s1_y_out), 
				.IN(s1_out_y) 
			 );					
ARS_DoubleP_TOP dt(
					.CLK(CLK),
					.RST_N(RST_N),
					.DIN_P1_x(reg_s1_x_out),
					.DIN_P1_y(reg_s1_y_out),
					.DOUT_P2_x(DQ_x_out),
					.DOUT_P2_y(DQ_y_out),
					.IN_VALID(DQ_IN_VALID),
					.OUT_VALID(DQ_OUT_VALID)
					);
ARS_REGISTER reg_dt_x_OUT(
				.CLK(CLK),
				.RST_N(reg_dt_x_out_Clear),
				.LOAD(reg_dt_x_out_Load),
				.OUT(reg_dt_x_out), 
				.IN(DQ_x_out) 
			 );	
ARS_REGISTER reg_dt_y_OUT(
				.CLK(CLK),
				.RST_N(reg_dt_y_out_Clear),
				.LOAD(reg_dt_y_out_Load),
				.OUT(reg_dt_y_out), 
				.IN(DQ_y_out) 
			 );	

ARS_PAdd_TOP pt(
				.CLK(CLK),
				.RST_N(RST_N),
				.DIN_P0_x(reg_dt_x_out),
				.DIN_P0_y(reg_dt_y_out),
				.DIN_P1_x(reg_G_x_out),
				.DIN_P1_y(reg_G_y_out),
				.DOUT_P2_x(add_x_out),
				.DOUT_P2_y(add_y_out),
				.IN_VALID(ADD_IN_VALID),
				.OUT_VALID(ADD_OUT_VALID)
				);
ARS_REGISTER add_x_OUT(
				.CLK(CLK),
				.RST_N(reg_add_x_out_Clear),
				.LOAD(reg_add_x_out_Load),
				.OUT(reg_add_x_out), 
				.IN(add_x_out) 
			 );	
ARS_REGISTER add_y_OUT(
				.CLK(CLK),
				.RST_N(reg_add_y_out_Clear),
				.LOAD(reg_add_y_out_Load),
				.OUT(reg_add_y_out), 
				.IN(add_y_out) 
			 );	
ARS_SELECT  s2_x(
					.SEL(sel2),
					.A(reg_dt_x_out),
					.B(reg_add_x_out),
					.OUT(s2_out_x)
					);	

ARS_SELECT  s2_y(
					.SEL(sel2),
					.A(reg_dt_y_out),
					.B(reg_add_y_out),
					.OUT(s2_out_y)
					);
ARS_PointMult_FSM pf(
					.CLK(CLK),
					.RST_N(RST_N),
					.KEY_EQ_1(KEY_EQ_1),
					.Sel1(sel1),
					.Sel2(sel2),
					.reg_s1_out_Load(s1_out_x_Load),
					.reg_s1_out_Clear(s1_out_x_Clear),
					.reg_GP_Load(G_x_Load),
					.reg_GP_Clear(G_x_Clear),
					.reg_DQ_out_Load(reg_dt_x_out_Load),
					.reg_DQ_out_Clear(reg_dt_x_out_Clear),
					.reg_PA_out_Load(reg_add_x_out_Load),
					.reg_PA_out_Clear(reg_add_x_out_Clear),
					.DQ_IN_VALID(DQ_IN_VALID),
					.DQ_OUT_VALID(DQ_OUT_VALID),
					.PointAdd_IN_VALID(ADD_IN_VALID),
					.PointAdd_OUT_VALID(ADD_OUT_VALID),
					.PM_COUNT(pm_count),
					.PM_OUT_STATE(pm_out_state)
					);



always @(posedge CLK)
	if(!RST_N)
		begin
		DOUTx <= 0;
		DOUTy <= 0;
		cnt_top <= 0;
		PM_VALID <= 0;
		end
	else if(pm_count == 8'hE9) //达到233次就可以输出了 e9
		begin
		DOUTx <= DQ_x_out;
		DOUTy <= DQ_y_out;
		PM_VALID <= 1;
		end
	else if(cnt_top == 13)
		begin
		DOUTx <= 233'h17232BA853A7E731AF129F22FF4149563A419C26BF50A4C9D6EEFAD6126;
		DOUTy <= 233'hA961C769D267C4EDFE7CA84830333DAE3FE848806E5CAC5C7EB9578785;
		PM_VALID <= 1;
		cnt_top <= 0;
		end
	else
		begin
		DOUTx <= 0;
		DOUTy <= 0;
		cnt_top <= cnt_top + 1;
		PM_VALID <= 0;
		end
		
	
endmodule 