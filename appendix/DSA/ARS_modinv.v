`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:05 02/11/2014 
// Design Name: 
// Module Name:    modinv 
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
module ARS_modinv(a, p,clk, en, rdy, b);
   parameter SIZE=256;
	input [SIZE-1:0]    a, p;
   input            clk;
   input            en;
   output           rdy;
   reg              rdy;
   output [SIZE-1:0]   b;
   reg [SIZE-1:0]      b;
   parameter [1:0]  s0 = 0,
                    s1 = 1,
                    s2 = 2,
						  s3 = 3;
   reg [1:0]        st;
   reg [SIZE-1:0]      u;
   reg [SIZE-1:0]      v;
   reg [SIZE-1:0]      s,r;
   always @(posedge clk)           
   begin
        if (en == 1'b0)
            begin
               b <= {256{1'b0}};                       
               u <= a;
               v <= p;
				   s <= 256'h1;
               r <= {256{1'b0}};             
               st <= s0;
               rdy <= 1'b0;
             end
         else
            begin 		 
                  case (st)
                   s0 :
                     if(u/2==0)				 
				            begin
					           st <= s0;
                           u <= u/2;
									if(s/2 == 0)
									  s <= s/2;
									  else
										s <= (s+p)/2;
									end
				            else							     
				              st <= s1;
                   s1 :                  
				         if(v/2==0)				 
				            begin
					           st <= s1;
                           v <= v/2;
										if(v/2 == 0)
									  r <= r/2;
									  else
										r <= (r+p)/2;									 					              
								end					            
				         else							      
				                st <= s2;          
                   s2 : 
                         if(u>=v)
				                 begin
                               u <= u-v;
                               s <= s-r;
										 st <= s3;
                              end 
				             else
				                 begin
                               v <= v-u;
                               r <= r-s;
										 st <= s3;
                             end                         						
						 s3 :
						   if(u!=1 && v!=1)
							   st <=s0;		 			   
                   	 else if(u==1)
							        begin
								       b <=((s + p)>p)?s:(s + p);
								        rdy <=1'b1;
								      end
                          else
							        begin
							         b <=((r + p)>p)?r:(r + p);
								     rdy <=1'b1;
								     end  
						 default :
                      begin
							  b <=0;
                       st <= s0;
                       end
            endcase		        		       
      end 
end
endmodule