`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:10:11 12/28/13
// Design Name:    
// Module Name:    PADD
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
module ARS_PADD(x0,X1,Z1,X2,Z2, clk, en, rdy, X3,Z3);
   input [232:0]    x0,X1,Z1,X2,Z2;
   input            clk;
   input            en;
   output           rdy;
   reg              rdy;
   output [232:0]   X3,Z3;
   reg [232:0]      X3,Z3;
   parameter [2:0]  s0 = 0,
                    s1 = 1,
                    s2 = 2,
                    s3 = 3,
                    s4 = 4,
                    s5 = 5,
                    s6 = 6,
                    s7 = 7;
   reg [2:0]        st;
   reg              enb1;
   reg              enb2;
   reg              enb3;
   reg              enb4;
   wire             ready1;
   wire             ready2;
   wire             ready3;
   wire             ready4;
   reg [232:0]      t2;
   reg [232:0]      t3;
   wire [232:0]      n1,n2,n3,n4,m1,m2,m3;
   always @(posedge clk)           
      begin
         if (en == 1'b0)
         begin
            X3 <= {233{1'b0}}; 
			   Z3 <= {233{1'b0}};
            t2 <= {233{1'b0}};
            t3 <= {233{1'b0}};            
            st <= s0;
            rdy <= 1'b0;
            enb1 <= 1'b0;
			enb2 <= 1'b0;
			enb3 <= 1'b0;
			enb4 <= 1'b0;
         end
         else
         begin          
            case (st)
               s0 :
                  begin
                     st <= s1;                                    
                     t3 <= x0;
                  end
               s1 :                  
				  if(ready1 == 1)
				    begin
                     st <= s2;
                     X3 <= n1;
					 enb1 <= 0;
					end
				   else
				     begin
				       enb1 <= 1;
                       st <= s1;					 
                    end                  
               s2 :                  
                   if(ready2 == 1)
				    begin
                     st <= s3;
                     Z3 <= n2;
					 enb2 <= 0;
					end
				   else
				     begin
				       enb2 <= 1;
                       st <= s2;					 
                    end                  
               s3 :                  
                  if(ready3 == 1)
                    begin				  
                     t2 <= n3;            
                     st <= s4;
					 enb3 <= 0;
                    end 
				  else
				     begin
				       enb3 <= 1;
                       st <= s3;					 
                    end  	
               s4 :                  
                  begin                     
                        st <= s5;
                        Z3 <= m1;                        
                  end                  
               s5 :
                  begin				    
                     Z3 <= m2;
                     st <= s6;
                  end				
				  s6 :                  
                  if(ready4 == 1)
				        begin                     
                        st <= s7;
                        X3 <= n4;
                        enb4 <= 0;
                    end 
				      else
				       begin
				         enb4 <= 1;
                       st <= s6;					 
                    end  
                s7 :                  
                  begin                     
                        st <= s7;
                        X3 <= m3;
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
   
ARS_mult_ip inst1(X1, Z2, clk, enb1, ready1, n1);
ARS_mult_ip inst2(Z1, X2, clk, enb2, ready2, n2);
ARS_mult_ip inst3(X3, Z3, clk, enb3, ready3, n3);
ARS_mult_ip inst4(Z3, t3, clk, enb4, ready4, n4);
ARS_modadd  add1(X3,Z3,m1);
ARS_modadd  add2(X3,t2,m3);
ARS_squar pingfang3(Z3,m2);
endmodule

