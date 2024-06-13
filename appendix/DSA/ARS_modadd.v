`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:32 02/11/2014 
// Design Name: 
// Module Name:    modadd 
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
module ARS_modadd(a,b, p,clk, en, rdy, c);
   parameter SIZE=256;
	input [SIZE-1:0]    a,b,p;
   input            clk;
   input            en;
   output           rdy;
   reg              rdy;
   output [SIZE-1:0]   c;
   reg [SIZE-1:0]      c;
   parameter [1:0]  s0 = 0,
                    s1 = 1;
   reg [1:0]        st;
   reg [SIZE:0] d;
   always @(posedge clk)           
   begin
        if (en == 1'b0)
            begin
               c <= 0;                       
               d <=0;            
               st <= s0;
               rdy <= 1'b0;
             end
         else
            begin 
			     case (st) 
			        s0 :               
                  begin			                    
                     d <= a+b;
					      st <= s1;
                         end					 
                  s1 :                  				                               
                         if(d>p)
				               begin
                            d <= d-p;
							      st <= s1;
                             end 
				               else
				                 begin                          
					              rdy <= 1'b1;
									  c <= d	;
						            st <= s1;
                              end 
                   default :
                       begin
                         st <= s0;
                         rdy <= 1'b0;
                        end
                 endcase
		end
end
endmodule
