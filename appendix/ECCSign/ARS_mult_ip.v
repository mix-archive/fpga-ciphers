`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:10:49 12/28/13
// Design Name:    
// Module Name:    mult_ip
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
module ARS_mult_ip(a, b, clk, en, rdy, c);
   parameter         m = 233;
   parameter         k = 32;
   parameter         n = 7;
   parameter         r = 9;
   input [m-1:0]     a;
   input [m-1:0]     b;
   input             clk;
   input             en;
   output            rdy;
   reg               rdy;
   output [m-1:0]    c;
   reg [m-1:0]       c;
   parameter [k-1:0] ak = {k{1'b0}};
   parameter [1:0]   s_state_s0 = 0,
                     s_state_s1 = 1,
                     s_state_s2 = 2;
   reg [1:0]         state;
   
   always @(clk)
   begin: xhdl0
      reg [m-1:0]       av;
      reg [m-1:0]       cv;
      reg [k-1:0]       as;
      reg [7:0]         ct;
      reg               cm;
      integer           i;
      if (en == 1'b0)
      begin
         ct = {8{1'b0}};
         av = {m{1'b0}};
         as = {k{1'b0}};
         cv = {m{1'b0}};
         state <= s_state_s0;
         rdy <= 1'b0;
      end
      else 
         case (state)
            s_state_s0 :
               begin
                  if (ct == 0)
                     av = a;
                  as = av[m - 1:m - k];
                  for (i = k - 1; i >= 0; i = i - 1)
                  begin
                     if (as[i] == 1'b1)
                        cv = cv ^ b;
                     cm = cv[m - 1];
                     cv = {cv[m - 2:0], 1'b0};
                     if (cm == 1'b1)
                     begin
                        cv[74] = cv[74] ^ 1'b1;
                        cv[0] = 1'b1;
                     end
                  end
                  if (ct < n - 1)
                  begin
                     ct = ct + 1;
                     state <= s_state_s0;
                  end
                  else
                     state <= s_state_s1;
                  av = {av[m - k - 1:0], ak};
               end
            s_state_s1 :
               begin
                  as = av[m - 1:m - k];
                  if (r > 1 & k > 1)
                  begin
                     for (i = k - 1; i >= k - r + 1; i = i - 1)
                     begin
                        if (as[i] == 1'b1)
                           cv = cv ^ b;
                        cm = cv[m - 1];
                        cv = {cv[m - 2:0], 1'b0};
                        if (cm == 1'b1)
                        begin
                           cv[74] = cv[74] ^ 1'b1;
                           cv[0] = 1'b1;
                        end
                     end
                     if (as[k - r] == 1'b1)
                        cv = b ^ cv;
                  end
                  else
                     if (as[k - 1] == 1'b1)
                        cv = b ^ cv;
                  c <= cv;
                  rdy <= 1'b1;
                  state <= s_state_s2;
               end
            s_state_s2 :
               state <= s_state_s2;
            
            default :
               begin
                  state <= s_state_s0;
                  rdy <= 1'b0;
               end
         endcase
   end
   
endmodule

