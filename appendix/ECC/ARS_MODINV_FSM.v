`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:15 12/04/2013 
// Design Name: 
// Module Name:    MODINV_FSM 
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
module ARS_MODINV_FSM(
				CLK,
				RST_N,
				TLoad,
				TClear,
				XLoad,
				XClear,
				ASel,
				BSel,
				OUT_VALID_tmp,
				IN_VALID_tmp,
				OUT_STATE
				);
input CLK, RST_N;
output TLoad, TClear, XLoad, XClear;
reg TLoad, TClear, XLoad, XClear;
output ASel, BSel;
reg ASel, BSel;
reg [4 : 0] cState, nState;

input OUT_VALID_tmp;
output IN_VALID_tmp;
reg IN_VALID_tmp;
output [4 : 0] OUT_STATE;
reg [4 : 0] OUT_STATE;

reg [1 : 0] state6_reg;
reg [2 : 0] state11_reg;
reg [3 : 0] state14_reg;
reg [4 : 0] state19_reg;
reg [5 : 0] state22_reg;
reg [6 : 0] state25_reg;


always @(posedge CLK)
	if(!RST_N)
		begin
		cState <= {5{1'b0}};
		state6_reg <= {2{1'b0}};
		state11_reg <= {3{1'b0}};
		state14_reg <= {4{1'b0}};
		state19_reg <= {5{1'b0}};
		state22_reg <= {6{1'b0}};
		state25_reg <= {7{1'b0}};
		OUT_STATE <= {5{1'b0}};
		end
	else
		begin
		cState <= nState;
		OUT_STATE <= cState;
		end

always @(cState)
	case(cState)
		5'b00000 : begin  //initial state
					TLoad = 0; TClear = 1; XLoad = 0; XClear = 1;
					ASel = 0; BSel = 0;
					nState = 5'b00001;
				   end
		5'b00001 : begin //first state   1:T=A^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 0; BSel = 1;
					IN_VALID_tmp<=1'b1; //multi input valid !
					nState = 5'b00010;
				   end
		5'b00010 : begin // 2:X=AT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 0; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b00011;
							end
					else
							begin
							nState = 5'b00010;
							IN_VALID_tmp <= 1'b0;	
							end
				   end
		5'b00011 : begin   //3:T=X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					IN_VALID_tmp<=1'b1; //multi input valid !
					nState = 5'b00100;
				   end
		5'b00100 : begin // 4:X=AT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 0; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b00101;
							end
					else
							begin
							nState = 5'b00100;
							IN_VALID_tmp <= 1'b0;	
							end
				   end
		5'b00101 : begin   // 5:T=X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 0; BSel = 1;
					IN_VALID_tmp<=1'b1; //multi input valid !
					nState = 5'b00110;
				   end
		5'b00110 : begin   // 6:T=T^2    2 times
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 0; BSel = 0;
//					if(state6_reg < 2)
					if(state6_reg >= 4)
						begin
						state6_reg <= state6_reg + 1;
						nState = 5'b00110;
						end
					else
						begin
						IN_VALID_tmp<=1'b1; //multi input valid !
						state6_reg <= 0;
						nState = 5'b00111;
						end
						
				   end
		5'b00111 : begin  // 7:X=XT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 0;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b01000;
							end
					else
							begin
							nState = 5'b00111;
							IN_VALID_tmp <= 1'b0;	
							end
				
				   end
		5'b01000 : begin //8:T=X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;	
					IN_VALID_tmp <= 1'b1; 
					nState = 5'b01001;
				   end		
		5'b01001 : begin // 9:X=AT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 0; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)
							begin
							IN_VALID_tmp <= 1'b1;
							nState = 5'b01010;
							end
					else
							begin
							nState = 5'b01001;
							IN_VALID_tmp <= 1'b0;	
							end
					end
		5'b01010 : begin // 10:T=X^2
				    TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
				    IN_VALID_tmp <= 1'b1; 
					nState = 5'b01011;
				   end
		5'b01011 : begin // 11:T=T^2   6 times		
				   TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 0;
//					if(state11_reg < 6)
					if(state11_reg >= 8)
						begin
						state11_reg <= state11_reg + 3'b001; 
						nState = 5'b01011;
						end
					else
						begin
						IN_VALID_tmp <= 1'b1; 
						state11_reg <= 0;
						nState = 5'b01100;
						end
					end
		5'b01100 : begin // 12:X=XT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b01101;
							end
					else
							begin
							nState = 5'b01100;
							IN_VALID_tmp <= 1'b0;	
							end
					end
		5'b01101 : begin // 13:T=X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					IN_VALID_tmp <= 1'b1; 
					nState = 5'b01110;
				   end
		5'b01110 : begin // 14:T = T^2  13 times
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 0;
//					if(state14_reg < 13)
					if(state14_reg >= 16)
						begin
						state14_reg <= state14_reg + 4'b0001;
						nState = 5'b01110;
						end
					else
						begin
						state14_reg <= 0;
						nState = 5'b01111;
						IN_VALID_tmp <= 1'b1;
						end
				    end
		5'b01111: begin // 15:X=XT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b10000;
							end
					else
							begin
							nState = 5'b01111;
							IN_VALID_tmp <= 1'b0;	
							end
				   end
		5'b10000 : begin // 16: T=X^2
				   	TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					IN_VALID_tmp <= 1'b1; 
					nState = 5'b10001;
				   end
		5'b10001 : begin // 17: X=AT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 0; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)
							begin
							IN_VALID_tmp <= 1'b1;
							nState = 5'b10010;
							end
					else
							begin
							nState = 5'b10001;
							IN_VALID_tmp <= 1'b0;	
							end
				   end
		5'b10010 : begin // 18: T=X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					IN_VALID_tmp <= 1'b1; 
					nState = 5'b10011;
				   end
		5'b10011 : begin // 19: T=T^2  28 times
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 0;
//					if(state19_reg < 28)
					if(state19_reg >= 32)
						begin
						state19_reg <= state19_reg + 5'b00001;
						nState = 5'b10011;
						end
					else
						begin
						state19_reg <= 0;
						nState = 5'b10100;
						IN_VALID_tmp <= 1'b1;
						end
				   end
		5'b10100 : begin // 20: X=XT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b10101;
							end
					else
							begin
							nState = 5'b10100;
							IN_VALID_tmp <= 1'b0;	
							end
				   end
		5'b10101 : begin // 21: T=X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					IN_VALID_tmp <= 1'b1; 
					nState = 5'b10110;
				   end
		5'b10110 : begin // 22: T=T^2 57 times
				    TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 0;
//					if(state22_reg < 57)
					if(state22_reg >= 64)
						begin
						state22_reg <= state22_reg + 6'b000001;
						nState = 5'b10110;
						end
					else
						begin
						state22_reg <= 0;
						nState = 5'b10111;
						IN_VALID_tmp <= 1'b1;
						end
				   end
		5'b10111 : begin //23: X=XT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b11000;
							end
					else
							begin
							nState = 5'b10111;
							IN_VALID_tmp <= 1'b0;	
							end
				   end
		5'b11000 : begin //24: T=X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					IN_VALID_tmp <= 1'b1; 
					nState = 5'b11001;
				   end
		5'b11001 : begin //25: T=T^2 115 times
				   	TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 0;
//					if(state25_reg < 115)
					if(state25_reg >= 128)
						begin
						state25_reg <= state25_reg + 7'b0000001;
						nState = 5'b11001;
						end
					else
						begin
						state25_reg <= 0;
						nState = 5'b11010;
						IN_VALID_tmp <= 1'b1;
						end
				   end
		5'b11010 : begin //26: X=XT
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					if(OUT_VALID_tmp == 1'b1)  //multi operation finish !
							begin
							IN_VALID_tmp <= 1'b1; 
							nState = 5'b11011;
							end
					else
							begin
							nState = 5'b11010;
							IN_VALID_tmp <= 1'b0;	
							end
				   end
		5'b11011 : begin // 27: INVA = X^2
					TLoad = 1; TClear = 0; XLoad = 1; XClear = 0;
					ASel = 1; BSel = 1;
					IN_VALID_tmp <= 1'b1; 
					nState = 5'b11100; //invaild state
				   end
		default : begin
					TLoad = 0; TClear = 0; XLoad = 0; XClear = 0;
					ASel = 0; BSel = 0;
					IN_VALID_tmp <= 1'b0; 
					nState = 5'b00000;
				  end
		endcase
//always @(posedge CLK)
//		begin


endmodule