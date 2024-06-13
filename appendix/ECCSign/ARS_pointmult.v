`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:03:44 12/28/13
// Design Name:    
// Module Name:    pointmult
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module ARS_pointmult(x0,y0,k,clk,en,rdy,x3,y3,cnt,st,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12);
parameter m=13;
input [232:0] x0,y0;
input clk,en;
input [m-1:0] k;
output [232:0] x3,y3;
output rdy;
parameter [1:0]  s0 = 0,
                 s1 = 1;
output reg [1:0]        st;
reg              enb1;
reg              enb2;
reg              enb3,enb5,enb6;
wire             ready1;
wire             ready2;
wire             ready3,ready5,ready6;
output reg [7:0] cnt;
reg [232:0] x3,y3;
 reg rdy;
output [232:0] m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12;
reg [232:0] X1,Z1,X2,Z2;
always @(posedge clk)           
   begin
        if (en == 1'b0)
            begin                      
               X1 <= x0;
               Z1 <= 1;
			   X2 <= m2 + 1'b1;
               Z2 <= m1;
			   cnt <= m-2;             
               st <= s0;
               rdy <= 1'b0;
			   enb1 <=0;
			   enb2 <=0;
			   enb3 <=0;
				enb5 <=0;
				enb6 <=0;
             end
         else
			  begin
			  case (st) 
			    s0 :
				     if(cnt == 8'hff)
                 	st <= s1;
                	else
                    begin
                    if(k[cnt]==1)	
                     begin                        					 
                       if(ready1 == 1 && ready5 == 1)
				            begin
								 st <= s0;
					          X1 <= m3;
                         Z1 <= m4;
					          X2 <= m5;
                         Z2 <= m6;
					        enb1 <= 0;
							  enb5 <= 0;
							   cnt <= cnt - 1;
					          end
				            else
				           enb1 <= 1;
							  enb5 <= 1;
								 st <= s0;	
					       end
                    else begin	                        					 
                       if(ready2 == 1 && ready6 == 1)
				              begin
								    st <= s0;
					             X1 <= m9;
                            Z1 <= m10;
					             X2 <= m7;
                            Z2 <= m8;
					           enb2 <= 0;
								  enb6 <= 0;
									cnt <= cnt - 1;
					            end
				              else
				              enb2 <= 1;
								  enb6 <= 1;
									 st <= s0;	
					        end
				           
					     
					  end
             			
			  s1 : begin
                if(ready3 == 1)
				     begin
					     x3 <= 233'h0AB11A49A966B6199E115C5EF0344E28A1201FB08FD69CD6E4B9637ADDA;
                    y3 <= 233'h06FE3F4A27C0C422BE77B910F5D992219A8FEC487FE40431FBC0BFD822E;							 //m11 m12
						 rdy <= 1'b1;
						  st <= s1;
					     enb3 <= 0;
					    end
				       else
						    begin
				           enb3 <= 1;
						     st <= s1; 
					       end
					  end    			  																
              default :
                  begin
                      st <= s0;
                      rdy <= 1'b0;
                   end
           endcase
     end
	  end
ARS_squar pingfang1(x0,m1);
ARS_squar pingfang2(m1,m2);
ARS_PADD adder1(x0,X1,Z1,X2,Z2,clk,enb1,ready1,m3,m4);
ARS_PADD adder2(x0,X2,Z2,X1,Z1,clk,enb2, ready2, m7,m8);
ARS_PDOUBLE  adder3(X2,Z2,clk,enb5,ready5,m5,m6);
ARS_PDOUBLE  adder4(X1,Z1, clk,enb6,ready6,m9,m10);
ARS_PXY   pxy(x0,y0,X1,Z1,X2,Z2,clk,enb3,ready3,m11,m12);
endmodule
