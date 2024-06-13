`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:56 12/20/2013 
// Design Name: 
// Module Name:    des 
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

module ARS_des(clk,reset,key,din,flag,dout,ready);
 input [64:1] din;
input [64:1] key;
input clk,reset;
input flag;
output [64:1] dout;
output ready;
reg [64:1] data1;
reg [64:1] key1;
wire [32:1] dout1,dout2;
wire [48:1] key2;
reg [4:1] round;
reg [4:1] state;
reg ready;
reg [64:1] dout;
parameter s0=4'h0,s1=4'h1,s2= 4'h2,s3=4'h3,s4= 4'h4,s5= 4'h5,s6= 4'h6,s7= 4'h7,s8= 4'h8,s9= 4'h9,s10= 4'ha,s11= 4'hb,s12= 4'hc;
function [64:1]	IP;
input	[64:1]	IPin;
//reg		[7:0]	s0_o,s1_o,s2_o,s3_o;
begin
IP=	 {IPin[58],IPin[50],IPin[42],IPin[34],IPin[26],IPin[18],IPin[10],IPin[2],

      IPin[60],IPin[52],IPin[44],IPin[36],IPin[28],IPin[20],IPin[12],IPin[4],

      IPin[62],IPin[54],IPin[46],IPin[38],IPin[30],IPin[22],IPin[14],IPin[6],

      IPin[64],IPin[56],IPin[48],IPin[40],IPin[32],IPin[24],IPin[16],IPin[8],

      IPin[57],IPin[49],IPin[41],IPin[33],IPin[25],IPin[17],IPin[9],IPin[1],

      IPin[59],IPin[51],IPin[43],IPin[35],IPin[27],IPin[19],IPin[11],IPin[3],

      IPin[61],IPin[53],IPin[45],IPin[37],IPin[29],IPin[21],IPin[13],IPin[5],

      IPin[63],IPin[55],IPin[47],IPin[39],IPin[31],IPin[23],IPin[15],IPin[7]};

end
endfunction
function [64:1] IVIP;
input    [64:1]  IP_1in;
begin
IVIP = {IP_1in[40],IP_1in[8],IP_1in[48],IP_1in[16],IP_1in[56],IP_1in[24],IP_1in[64],IP_1in[32],

        IP_1in[39],IP_1in[7],IP_1in[47],IP_1in[15],IP_1in[55],IP_1in[23],IP_1in[63],IP_1in[31],

        IP_1in[38],IP_1in[6],IP_1in[46],IP_1in[14],IP_1in[54],IP_1in[22],IP_1in[62],IP_1in[30],

        IP_1in[37],IP_1in[5],IP_1in[45],IP_1in[13],IP_1in[53],IP_1in[21],IP_1in[61],IP_1in[29],

        IP_1in[36],IP_1in[4],IP_1in[44],IP_1in[12],IP_1in[52],IP_1in[20],IP_1in[60],IP_1in[28],

        IP_1in[35],IP_1in[3],IP_1in[43],IP_1in[11],IP_1in[51],IP_1in[19],IP_1in[59],IP_1in[27],

        IP_1in[34],IP_1in[2],IP_1in[42],IP_1in[10],IP_1in[50],IP_1in[18],IP_1in[58],IP_1in[26],

        IP_1in[33],IP_1in[1],IP_1in[41],IP_1in[9],IP_1in[49],IP_1in[17],IP_1in[57],IP_1in[25]};
end
endfunction
always @(posedge clk) 
begin
if(reset == 0) begin  
             state	=	s0;
		     ready	=	0;
		     round=	(flag == 0)? 4'h0  : 4'hf;
             end 
else 
case(state)
		s0 : begin 
		     data1  = din;  
		     key1  = key; 
		     state = s1; 
		     end
		s1 : begin 
				data1 = IP({data1[64:33], data1[32:1]});
				if(flag == 0) 
				begin 
				round = 0; 
				state = s2; 
				end
				else          
				begin 
				round = 15;state = s4; 
				end
			 end
		s2 : begin //encription
				data1 = {dout1, dout2};
				round = round + 4'h1;
				state = s3;
			 end
		s3 : begin 
				if(round == 15) 
					begin 
						data1 = IVIP({dout2, dout1}); 
						ready = 1; 
						state = s6;
					end
				else 
				state = s2; 
			 end
		s4 : begin//decription
				data1 = {dout1, dout2};
				round = round - 4'h1;
				state = s5;
			 end
		s5 : begin 
				if(round == 0) 
					begin 
						data1 = IVIP({dout2, dout1}); 
						ready = 1; 
						state = s6;
					end
				else state = s4; 
			 end
		s6: begin 
				dout = data1; 
				state = s7; 
			 end
		s7: begin 
		      ready = 1; 
		      state = s7;
		      end
		default : state = s7;
		endcase
end
ARS_ENDEcrp 	c1 (.OUTR(dout2),  .OUTL(dout1),  .INR(data1[32:1]),  .INL(data1[64:33]),  .K_sub(key2));
ARS_keyExtension	c2(.K_sub(key2), .key(key1), .round(round));


endmodule

