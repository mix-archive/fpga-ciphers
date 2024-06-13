`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:15:10 12/28/13
// Design Name:    
// Module Name:    PDOUBLE
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
module ARS_PDOUBLE(X1,Z1, clk, en, rdy,X2,Z2);
   input [232:0]    X1,Z1;
   input            clk;
   input            en;
   output           rdy;
   reg              rdy;
   output [232:0]   X2,Z2;
   reg [232:0]      X2,Z2;
   parameter [2:0]  s0 = 0,
                    s1 = 1,
                    s2 = 2,
                    s3 = 3,
                    s4 = 4;
   reg [2:0]        st;
   reg              enb;
   wire             ready;
   reg [232:0]      T1;
   wire [232:0]      n1,m1,m2,m3,m4,m5;

   always @(posedge clk)           
      begin
         if (en == 1'b0)
           begin
            X2 <= {233{1'b0}}; 
			   Z2 <= {233{1'b0}};
            T1 <= {233{1'b0}};           
            st <= s0;
            rdy <= 1'b0;
            enb <= 1'b0;
           end
         else
           begin          
             case (st)
               s0 :
                  begin
                     st <= s1;                                    
                     X2 <= m1;
					     T1 <= m2;
                  end
               s1 : 			   
				     if(ready == 1)
				       begin
                     st <= s2;
                     Z2 <= n1;
					      enb <= 0;
					    end
				     else
				       begin
				          enb <= 1;
                      st <= s1;					 
                    end                  
               s2 :                                     
				      begin
                     st <= s3;
                     T1 <= m3;					
					   end				              
               s3 :                                   
                    begin				  
                     X2 <= m4;            
                     st <= s4;
                    end 
               s4 :                  
                  begin                     
                        st <= s4;
                        X2 <= m5;
                        rdy <= 1'b1;
                  end                  
               default :
                  begin
                     st <= s0;
                     rdy <= 1'b0;
                  end
            endcase
         end
      end
ARS_mult_ip inst(T1,X2,clk,enb,ready,n1);
ARS_modadd  add1(X2,T1,m5);
ARS_squar pingfang1(X1,m1);
ARS_squar pingfang2(Z1,m2);
ARS_squar pingfang3(T1,m3);
ARS_squar pingfang4(X2,m4);
endmodule