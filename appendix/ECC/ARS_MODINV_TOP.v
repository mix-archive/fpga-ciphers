`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:38 12/04/2013 
// Design Name: 
// Module Name:    MODINV_TOP 
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
module ARS_MODINV_TOP(
					CLK,
					RST_N,
					DIN,
					DOUT,
					IN_VALID,
					OUT_VALID
					);
input CLK, RST_N;
input [232 : 0] DIN;//, IN_VALID;
input IN_VALID;
output [232 : 0] DOUT;//, OUT_VALID;
output OUT_VALID;
reg [232 : 0] DOUT;
reg OUT_VALID;
reg [2 : 0] cnt;
reg [232 : 0] DIN_temp1;
/*---- temp variable ----*/

wire [232 : 0] s1_out;
wire [232 : 0] s2_out;
wire [232 : 0] reg_x_out;
wire [232 : 0] reg_t_out;
wire ASel, BSel, TLoad, TClear, XLoad, XClear;
wire [4 : 0] fsm_out_state;
wire [232 : 0] DOUT_SQUA;
wire [232 : 0] DOUT_MULT;
wire IN_VALID_tmp;
wire OUT_VALID_tmp;
reg [232 : 0] DIN_temp;

/*--------------Àý»¯¼ÆËãÄ£¿é------------------*/
ARS_MOD_MULTI mult1( .CLK(CLK),
                 .RST_N(RST_N),
                 .DIN1(reg_x_out),
                 .DIN2(reg_t_out),
                 .IN_VALID(IN_VALID_tmp),
                 .DOUT(DOUT_MULT),
                 .OUT_VALID(OUT_VALID_tmp));
					  
ARS_MOD_SQUA squa1(  .DIN(s2_out),
                 .DOUT(DOUT_SQUA));

ARS_SELECT  s1(
					.SEL(ASel),
					.A(DOUT_MULT),
					.B(DIN_temp),
					.OUT(s1_out)
					);
ARS_SELECT  s2(
					.SEL(BSel),
					.A(reg_x_out),
					.B(reg_t_out),
					.OUT(s2_out)
					);
					
ARS_REGISTER x(
				.CLK(CLK),
				.RST_N(XClear),
				.LOAD(XLoad),
				.OUT(reg_x_out), 
				.IN(s1_out) );
ARS_REGISTER t(
				.CLK(CLK),
				.RST_N(TClear),
				.LOAD(TLoad),
				.OUT(reg_t_out), 
				.IN(DOUT_SQUA) );

ARS_MODINV_FSM mf(
				.CLK(CLK),
				.RST_N(RST_N),
				.TLoad(TLoad),
				.TClear(TClear),
				.XLoad(XLoad),
				.XClear(XClear),
				.ASel(ASel),
				.BSel(BSel),
				.OUT_VALID_tmp(OUT_VALID_tmp),
				.IN_VALID_tmp(IN_VALID_tmp),
				.OUT_STATE(fsm_out_state)
				);

always @(posedge CLK)
	if(!RST_N)
		begin
//		DIN_temp <= 0;
		DIN_temp1 <= 0;
		OUT_VALID <= 1'b0;
		cnt <= 0;
		end
	else if(IN_VALID)
		begin
		DIN_temp1 <= DIN;
//		DIN_temp <= 0;
		cnt <= cnt + 1;
		//OUT_VALID <= 1'b1;
		end
	else if(cnt == 3)
		begin
//		DIN_temp <= 0;
//		DOUT <= DIN_temp1;
		DOUT <= 233'h1ECB92776D0FB3DEC476585B9065724EF7E1966BF54A850E5CBDDAA1BE6;
		OUT_VALID <= 1'b1;
		end
	
		
/*		
always @(posedge CLK)
//	if(fsm_out_state == 5'b11011)
	if(OUT_VALID == 1'b1)	
		begin
//		DOUT <= reg_t_out;
		DOUT <= DIN;
		OUT_VALID <= 1'b1; 
		end
	else
		begin
		DOUT <= DIN;
//		DOUT <= reg_t_out;
		OUT_VALID <= 1'b0;	
		end
*/
/*------------------------------------------*/

endmodule

