`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:21 12/04/2013 
// Design Name: 
// Module Name:    KEY_PARSE 
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
module ARS_KEY_PARSE(
				CLK,
				RST_N,
				DIN,
				KEY_EQ_1,
				IN_VALID,
				DQ_OUT_VALID
				);

input CLK, RST_N;
input [232 : 0] DIN;
input IN_VALID, DQ_OUT_VALID;
output KEY_EQ_1;
reg KEY_EQ_1;

reg [232 : 0] data_temp;

always @(posedge CLK)
	if(!RST_N)
		begin
			data_temp <= 0;
			KEY_EQ_1 <= 0;
		end
    else if(IN_VALID)
		begin
			data_temp <= DIN;
			KEY_EQ_1 <= 0;
		end
	else if(DQ_OUT_VALID)
		begin
			if(data_temp[232] == 1'b1)
				begin
					KEY_EQ_1 <= 1'b1;
				end
			else
				begin
					KEY_EQ_1 <= 1'b0;
				end
			data_temp <= {{data_temp[231:0]},1'b0};	
		end
	else
		KEY_EQ_1 <= 1'b0;
	
			
//always @(posedge CLK)
//	if()

				
endmodule 