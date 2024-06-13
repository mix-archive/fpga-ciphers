`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:15:37 12/28/13
// Design Name:    
// Module Name:    PXY
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
module ARS_PXY(x0, y0,X1,Z1,X2,Z2,clk, en, rdy, X4,Z4);
   input [232:0]    x0, y0,X1,Z1,X2,Z2;
   input            clk;
   input            en;
   output           rdy;
   reg              rdy;
   output [232:0]   X4,Z4;
   reg [232:0]      X4,Z4;
   parameter [4:0]  s0 = 0,
                    s1 = 1,
                    s2 = 2,
                    s3 = 3,
                    s4 = 4,
                    s5 = 5,
                    s6 = 6,
                    s7 = 7,
					     s8 = 8,
                    s9 = 9,
                    s10 = 10,
                    s11 = 11,
                    s12 = 12,
                    s13 = 13,
                    s14 = 14,
					     s15 = 15,
                    s16 = 16;
   reg [4:0]        st;
   reg              enb1;
   reg              enb2;
   reg              enb3;
   reg              enb4;
   reg              enb5;
   reg              enb6;
   reg              enb7;
   reg              enb8,enb9,enb10,enb11;
   wire             ready1;
   wire             ready2;
   wire             ready3;
   wire             ready4;
   wire             ready5;
   wire             ready6;
   wire             ready7;
   wire             ready8,ready9,ready10,ready11;   
   reg [232:0]      X3,Z3;
   reg [232:0]      T1,T2,T3,T4;
   wire [232:0] m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,n1,n2,n3,n4,n5,n6,n7;
   always @(posedge clk)
   begin            
      if (en == 1'b0)
         begin
            X3 <= {233{1'b0}}; 
			Z3 <= {233{1'b0}};
			X4 <= {233{1'b0}}; 
			Z4 <= {233{1'b0}};
            T1 <= {233{1'b0}};
            T2 <= {233{1'b0}};
            T3 <= {233{1'b0}};
            T4 <= {233{1'b0}};
            st <= s0;
            rdy <= 1'b0;
            enb1 <= 1'b0;
			  enb2 <= 1'b0;
			  enb3 <= 1'b0;
			  enb4 <= 1'b0;
			  enb5 <= 1'b0;
			  enb6 <= 1'b0;
			  enb7 <= 1'b0;
			  enb8 <= 1'b0;
			  enb9 <= 1'b0;
			  enb10 <= 1'b0;
			  enb11 <= 1'b0;
         end
       else  begin       
            case (st)
               s0 :
			         if(Z1==0)
                    begin
                     X4 <= 0;                                    
                     Z4 <= 0;
                    end
				      else if(Z2==0)
                    begin
                     X4 <= x0;                                    
                     Z4 <= x0^y0;
                    end
				     else
				         st <= s1;
               s1 :                  
				       begin
                     st <= s2;
                     T3 <= x0;
					      T4 <= y0;
					    end              
               s2 :                  
                   if(ready1 == 1 && ready9==1)
                    begin				  
                     T1 <= m1;
					      Z3 <= m2;
                     st <= s3;
					  enb1 <= 0;
					  enb9 <= 0;
                    end 
				      else
				        begin
				         enb1 <= 1;
							enb9 <= 1;
                       st <= s2;					 
                    end  	           
               s3 :                  
                  if(ready2 == 1)
                    begin				  
                     Z4 <= m3;            
                    st <= s4;
				  enb2 <= 0;
                    end 
				      else
				        begin
				         enb2 <= 1;
                       st <= s3;					 
                    end  	
               s4 :                  
                  begin                     
                        st <= s5;
                        Z3 <= n1;                        
                  end                  
               s5 :
			      if(ready3 == 1)
				    begin
                       X3 <= m4;
                       st <= s6;
					   enb3 <= 0;
                     end
				  else
				      begin
				         enb3 <= 1;
                       st <= s5;					 
                      end
				s6 :                                    
				      begin                     
                        st <= s7;
                        Z4 <= n2;
                      end 				    
                s7 : 
				  if(ready4 == 1)
                    begin                     
                        st <= s8;
                        Z4 <= m5; 
						enb4 <= 0;
                     end
				   else
				      begin
				         enb4 <= 1;
                       st <= s7;					 
                      end	 
   			    s8 :                  
				        begin                     
                        st <= s9;
                         T2 <= n3;                        
                     end 				       
          		s9 :                  
                  begin                     
                        st <= s10;
                          T2 <= n4;                        
                  end 
				s10 :
				   if(ready5 == 1 && ready10 ==1)
					    begin
                       T2 <= m6;
					   T1 <= m7;
                       st <= s11;
					   enb5 <= 0;
						enb10 <= 0;
                   end
				      else
				        begin
				        enb5 <= 1;
						  enb10 <= 1;
                       st <= s10;					 
                    end  
				s11 :                  
				        begin                     
                        st <= s12;
                        T2 <= n5;                       
                    end				     
				s12 :                  
                    if(ready6 == 1)
				          begin                     
                        st <= s13;
                        T1 <= m8;
						enb6 <= 0;                        
                     end
					   else
					     begin
				        enb6 <= 1;
                        st <= s12;					 
                    end   
				s13 : 
                  if(ready7 == 1 && ready11 ==1)
				          begin                     
                        st <= s14;
                        T2 <= m9;
						X4 <= m10;
						enb7 <= 0; 
						enb11<= 0; 
                     end
					   else
					     begin
				          enb7 <= 1;
							 enb11 <= 1;
                       st <= s13;					 
                    end   
				s14 :                                    
				      begin                     
                        st <= s15;
                        Z4 <= n6;                      
                     end					  
				s15 :                  
                   if(ready8 == 1)
				        begin                     
                        st <= s16;
                        Z4 <= m11;
						enb8 <= 0;                        
                    end 
				      else
				        begin
				         enb8 <= 1;
                         st <= s15;					 
                        end
				s16 :                  
				        begin                     
                        st <= s16;
                        Z4 <= n7; 
						rdy <= 1;
                        end 
               default :
                  begin
                     st <= s0;
                     rdy <= 1'b0;
                  end
            endcase
         end
end   
ARS_mult_ip inst1(Z1, Z2, clk, enb1, ready1, m1);
ARS_mult_ip inst2(Z1, T3, clk, enb9, ready9, m2);
ARS_mult_ip inst3(Z2, T3, clk, enb2, ready2, m3);
ARS_mult_ip inst4(Z4, X1, clk, enb3, ready3, m4);
ARS_mult_ip inst5(Z4, Z3, clk, enb4, ready4, m5);
ARS_mult_ip inst6(T2, T1, clk, enb5, ready5, m6);
ARS_mult_ip inst7(T1, T3, clk, enb10, ready10, m7);
ARS_inverse   fan(T1, clk, enb6, ready6, m8);
ARS_mult_ip inst8(T2, T1, clk, enb7, ready7, m9);
ARS_mult_ip inst9(T1, X3, clk, enb11, ready11, m10);
ARS_mult_ip inst10(Z4, T2, clk, enb8, ready8, m11);
ARS_modadd  jia1(Z3, X1,n1);
ARS_modadd  jia2(Z4, X2,n2);
ARS_squar pingfang1(T3,n3);
ARS_modadd  jia3(T2, T4,n4);
ARS_modadd  jia4(T2, Z4,n5);
ARS_modadd  jia5(X4, T3,n6);
ARS_modadd  jia6(Z4, T4,n7);
endmodule
