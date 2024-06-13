`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:02:46 01/18/2014 
// Design Name: 
// Module Name:    ECCSign 
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
module ARS_ECCSign(k,xG,yG,Hm,clk,en,rdy,d,r,s);
parameter m=13;
input [232:0] xG,yG;
input [m-1:0] k;
input [232:0] Hm,d;
input en,clk;
output reg [232:0] r,s;
output rdy;
reg rdy;
wire [232:0] m1,m2,m3,m4,m5,m6,m7,m8;
reg [232:0] n1,n2,n3,n4,x1,y1;
parameter [2:0] s0 = 0,
                s1 = 1,
					 s2 = 2,
					 s3 = 3,
					 s4 = 4,
					 s5 = 5,
					 s6 = 6;
reg [2:0] st;
reg enb1,enb2,enb3,enb4;
wire ready1,ready2,ready3,ready4;
always @(posedge clk)
begin
  if(en==0)	begin
   	x1 <=0;
		y1 <=0;
		rdy <=0;
		r <=0;
		s<=0;
		st <=s0;
		enb1 <= 0;
		enb2 <= 0;
		enb3 <= 0;
		enb4 <= 0;
		 end
	else
	  begin
	    case(st)
		   s0:begin
			  if(ready1 == 1) begin
			    x1 <= m1;
				 y1 <= m2;
				 st <= s1;
				 enb1 <= 0;
				 end
				 else
				   begin
					 enb1 <=1;
					 st <=s0;
					 end
				end
			s1:begin
			   r <= m3;
				st <= s2;
				end
			s2:begin
			   n1 <= m4;
				st <= s3;
				end
         s3:begin
			   if(ready2 == 1)
				  begin
				   n2 <= m5;
					st <= s4;
					enb2 <= 0;
					end
             else
				   begin
					 st<=s3;
					 enb2 <= 1;
					 end
              end
           s4:begin
			      n3 <= m6;
					st <= s5;
			   end
			 s5:begin
			   if(ready3 == 1)
				  begin
				    n4 <= m7;
					 st <= s6;
					 enb3 <= 0;
					 end
             else
				   begin
					  st <= s5;
					  enb3 <= 1;
					  end
               end
           s6:begin
			      if(ready4 == 1)
					  begin
					    st <= s6;
						 s <= m8;
						 enb4 <= 0;
						 rdy <= 1;
						 end
						 else
						  begin
						    enb4 <= 1;
							 st <= s6;
							 end
              end
				default:begin
				   rdy <= 0;
					r <= 0;
					s <= 0;
					end
				 endcase
         end
end
ARS_pointmult  pointmult(xG,yG,k,clk,enb1,ready1,m1,m2);
ARS_modadd     modadd1(Hm,x1,m3);	
ARS_modadd     modadd2(r,d,m4);
ARS_mult_ip    mult_ip1(r,d,clk,enb2,ready2,m5);
ARS_modadd     modadd3({220'h0,k},n2,m6);
ARS_inverse    inverse(n1, clk, enb3, ready3, m7);
ARS_mult_ip    mult_ip2(n4,n3,clk,enb4,ready4,m8);			   	   
endmodule
