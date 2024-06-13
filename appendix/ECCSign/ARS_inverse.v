`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:17:14 12/28/13
// Design Name:    
// Module Name:    inverse
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
module ARS_inverse(a, clk, en, rdy, aout);
   input [232:0]    a;
   input            clk;
   input            en;
   output           rdy;
   reg              rdy;
   output [232:0]   aout;
   reg [232:0]      aout;
   parameter [5:0]  s0 = 0,
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
                    s16 = 16,
                    s17 = 17,
                    s18 = 18,
                    s19 = 19,
                    s20 = 20,
                    s21 = 21,
					     s22 = 22,
                    s23 = 23,
                    s24 = 24,
                    s25 = 25,
                    s26 = 26;
   reg [5:0]        st;
   reg              enb1;
   reg              enb2;
   wire             ready1;
   wire             ready2;
   reg [2:0]        cnt1;
   reg [2:0]        cnt2;
   reg [3:0]        cnt3;
   reg [4:0]        cnt4;
   reg [5:0]        cnt5;
   reg [6:0]        cnt6;
   reg [232:0]      x;
   reg [232:0]      t;
	wire [232:0] m1,m2,m3,n1,n2;
   always @(posedge clk)
   begin            
      if (en == 1'b0)
         begin
            aout <= {233{1'b0}};           
            cnt1 <= {3{1'b0}};
			   cnt2 <= {3{1'b0}};
			   cnt3 <= {4{1'b0}};
			   cnt4 <= {5{1'b0}};
			   cnt5 <= {6{1'b0}};
			   cnt6 <= {7{1'b0}};
            x <= {233{1'b0}};
            t <= {233{1'b0}};            
            st <= s0;
            rdy <= 1'b0;
            enb1 <= 1'b0;
			   enb2 <= 1'b0;
         end
     else  begin       
            case (st)
               s0 :
                  begin
                     st <= s1;                                    
                     t <= m1;
                  end
               s1 :                  
				     if(ready1 == 1)
				       begin
                     st <= s2;
                     x <= n1;
					     enb1 <= 0;
					    end
				      else
				        begin
				         enb1 <= 1;
                       st <= s1;					 
                    end                  
               s2 :                  
                  begin
                     st <= s3;
                     t <= m2;
                  end               
               s3 :                  
                  if(ready1 == 1)
                    begin				  
                     x <= n1;            
                     st <= s4;
					      enb1 <= 0;
                    end 
				      else
				        begin
				         enb1 <= 1;
                       st <= s3;					 
                    end  	
               s4 :                  
                  begin                     
                        st <= s5;
                        t <= m2;                        
                  end                  
               s5 :
				    if(cnt1 < 2)
					    begin
                     t <= m3;
                     st <= s5;
                     cnt1 <=cnt1 + 1'b1;
                  end
				    else
				      st <= s6;
				   s6 :                  
                  if(ready2 == 1)
				         begin                     
                        st <= s7;
                        x <= n2;
                        enb2 <= 0;
                    end 
				      else
				        begin
				         enb2 <= 1;
                       st <= s6;					 
                    end  
                s7 :                  
                  begin                     
                        st <= s8;
                        t <= m2;                        
                  end 
   			    s8 :                  
                  if(ready1 == 1)
				        begin                     
                        st <= s9;
                         x <= n1;
							 enb1 <= 0;                        
                     end 
				       else
				        begin
				          enb1 <= 1;
                       st <= s8;					 
                    end  	
          		 s9 :                  
                  begin                     
                        st <= s10;
                         t <= m2;                        
                  end 
				   s10 :
				     if(cnt2 < 6)
					    begin
                     t <= m3;
                     st <= s10;
                     cnt2 <=cnt2 + 1'b1;
                   end
				      else
				       st <= s11; 
				   s11 :                  
                  if(ready2 == 1)
				        begin                     
                        st <= s12;
                        x <= n2;
								enb2 <= 0;                        
                    end
				      else
				        begin
				          enb2 <= 1;
                       st <= s11;					 
                    end  	
				   s12 :                  
                  begin                     
                        st <= s13;
                        t <= m2;                        
                  end 
				   s13 : 
                  if(cnt3 < 13)
					     begin
                     t <= m3;
                     st <= s13;
                     cnt3 <=cnt3 + 1'b1;
                    end
				      else
				         st <= s14;
				   s14 :                  
                  if(ready2 == 1)
				          begin                     
                        st <= s15;
                        x <= n2;
								enb2 <= 0;                        
                     end
					   else
					     begin
				          enb2 <= 1;
                       st <= s14;					 
                    end   
				  s15 :                  
                  begin                     
                        st <= s16;
                        t <= m2;                        
                  end
				  s16 :                  
                  if(ready1 == 1)
				        begin                     
                        st <= s17;
                        x <= n1;
								enb1 <= 0;                        
                    end 
				      else
				        begin
				         enb1 <= 1;
                       st <= s16;					 
                    end  
				  s17 :                  
                  begin                     
                        st <= s18;
                        t <= m2;                        
                  end 
				  s18 : 
                  if(cnt4 < 28)
					     begin
                     t <= m3;
                     st <= s18;
                     cnt4 <=cnt4 + 1'b1;
                    end
				      else
				        st <= s19; 
				  s19 : 
				       if(ready2 == 1)
                     begin                     
                        st <= s20;
                        x <= n2; 
								enb2 <= 0;                       
                     end 
				       else
					     begin
				         enb2 <= 1;
                       st <= s19;					 
                    end   
				  s20 :                  
                  begin                     
                        st <= s21;
                        t <= m2;                        
                  end 
				  s21 : 
                  if(cnt5 < 57)
					     begin
                     t <= m3;
                     st <= s21;
                     cnt5 <=cnt5 + 1'b1;
                    end
				      else
				        st <= s22;
				  s22 :                  
                  if(ready2 == 1)
				         begin                     
                        st <= s23;
                        x <= n2; 
								enb2 <= 0;                       
                    end 
				      else
					     begin
				          enb2 <= 1;
                       st <= s22;					 
                    end  
				  s23 :                  
                  begin                     
                        st <= s24;
                        t <= m2;                        
                  end 
              s24 : 
                  if(cnt6 < 115)
					     begin
                     t <= m3;
                     st <= s24;
                     cnt6 <=cnt6 + 1'b1;
                    end
				      else
				        st <= s25;
       	     s25 :                  
                  if(ready2 == 1)
				        begin                     
                        st <= s26;
                        x <= n2;
								enb2 <= 0;                        
                    end
				     else
					     begin
				          enb2 <= 1;
                       st <= s25;					 
                    end   
				  s26 :                  
                  begin                     
                        st <= s26;
                        aout <= m2;
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
   
ARS_mult_ip inst1(a, t, clk, enb1, ready1, n1);
ARS_mult_ip inst2(x, t, clk, enb2, ready2, n2);
ARS_squar pingfang1(a,m1);
ARS_squar pingfang2(x,m2);
ARS_squar pingfang3(t,m3);
endmodule
