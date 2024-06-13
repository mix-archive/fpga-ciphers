`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:35 12/10/2013 
// Design Name: 
// Module Name:    key_expand_ori 
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
module ARS_keyextension (key_out,
                       round_key,
                       key_in,
                       get_key,
                       exp_run,                      
                       mode,
                       //ed_mode,
                       clk,
                       reset,
                       counter);
                       
parameter DWIDTH=128;
parameter RWIDTH=32;
parameter FK0=32'HA3B1BAC6;
parameter FK1=32'H56AA3350;
parameter FK2=32'H677D9197;
parameter FK3=32'HB27022DC;

output [0:DWIDTH-1] key_out;
output [0:RWIDTH-1] round_key;
input  [0:DWIDTH-1] key_in;
input  [0:4] counter;
input  get_key;
input  exp_run;
input  mode;
//input  ed_mode;
input  clk;
input  reset;

reg    [0:DWIDTH-1] key_out;
reg    [0:DWIDTH-1] key_reg;
reg    [0:DWIDTH-1] next_key;
reg    [0:RWIDTH-1] cur_3,cur_2,cur_1,cur_0;
reg    [0:RWIDTH-1] next_3,next_2,next_1,next_0;
reg    [0:RWIDTH-1] round_key;
wire   [0:RWIDTH-1] ck;
reg    [0:RWIDTH-1] fir_ad;
//reg    round_key_vld;
wire   [0:RWIDTH-1] b_shift0;
wire   [0:RWIDTH-1] b_shift1;
wire   [0:RWIDTH-1] b_shift2;
wire   [0:7] sbox3,sbox2,sbox1,sbox0;

always @ (posedge clk or negedge reset)
  if (!reset)
    key_reg<=0;
       else  
         key_reg<=next_key;
  
always @ (get_key or exp_run or key_in or key_reg or next_3 or next_2 or next_1 or next_0)   //generate next_key
  begin
   if(get_key)
      next_key={key_in[0:31]^FK0,key_in[32:63]^FK1,key_in[64:95]^FK2,key_in[96:127]^FK3};
    else
      if(exp_run)
            next_key={next_0,next_1,next_2,next_3};
              else
                next_key=key_reg;
  end 
  
always @ (mode or cur_3 or cur_2 or cur_1 or cur_0 or b_shift2 or b_shift1 or b_shift0)
  begin
    if(mode)
     begin
       next_0=cur_1;
       next_1=cur_2;
       next_2=cur_3;
       next_3=cur_0^b_shift2^b_shift1^b_shift0;
     end
       else          
            begin
               next_3=cur_2;
               next_2=cur_1;
               next_1=cur_0;
               next_0=cur_3^b_shift2^b_shift1^b_shift0;
             end
   end
   
always @ (cur_3 or cur_2 or cur_1 or cur_0 or mode or ck)
begin
    case (mode)
      1'b1 : fir_ad=ck^cur_3^cur_2^cur_1;   
      1'b0 : fir_ad=ck^cur_2^cur_1^cur_0;     
     default : fir_ad=0;
    endcase     
end

//always @ (next_3 or next_2 or next_1 or next_0 or mode or get_key or ck)
//    case ({mode,get_key})
//      3'b111 : fir_ad=ck^next_3^next_2^next_1;
//      3'b011 : fir_ad=ck^next_3^next_2^next_1;
//      3'b010 : fir_ad=ck^next_2^next_1^next_0;
//     default : fir_ad=0;
//    endcase

always @(key_reg)
begin        
  cur_3 = key_reg[96:127];
  cur_2 = key_reg[64:95];
  cur_1 = key_reg[32:63];
  cur_0 = key_reg[0:31];
  key_out = key_reg;
  round_key=key_reg[96:127];
end

//always @(posedge clk or negedge reset)
//  if(!reset)
//    round_vld<=0;
//      else
//        round_vld<=round_key_vld;
        
//always @(counter or ed_mode)
//if(ed_mode)
//    round_key_vld=0;
//  else 
//    round_key_vld=1;
//  else 
//   round_key_vld=0;
      
//always @(round_key_vld or key_reg)
//  if(round_key_vld)
//   round_key = key_reg[96:127]; 
//   else
//    round_key=key_reg[96:127];
    
    
ARS_CK    Ck(
         .ck(ck),
         .counter(counter)
         );

ARS_sbox  Sbox3(
            .sout(sbox3),
            .sin(fir_ad[24:31])
            );
ARS_sbox  Sbox2(
            .sout(sbox2),
            .sin(fir_ad[16:23])
            );
ARS_sbox  Sbox1(
            .sout(sbox1),
            .sin(fir_ad[8:15])
            );
ARS_sbox  Sbox0(
            .sout(sbox0),
            .sin(fir_ad[0:7])
            );
            
ARS_BK_SHIFT2  B_shift2(
                     .b2_out(b_shift2),
                     .b2_in({sbox0,sbox1,sbox2,sbox3})
                     );
ARS_BK_SHIFT1  B_shift1(
                     .b1_out(b_shift1),
                     .b1_in({sbox0,sbox1,sbox2,sbox3})
                     );
ARS_BK_SHIFT0  B_shift0(
                     .b0_out(b_shift0),
                     .b0_in({sbox0,sbox1,sbox2,sbox3})
                     );
endmodule