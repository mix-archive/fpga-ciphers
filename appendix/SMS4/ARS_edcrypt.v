`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:21 12/10/2013 
// Design Name: 
// Module Name:    edcrypt_ori 
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
module ARS_edcrypt (data_out,
                    data_in,
                    round_key,
                    get_data,
                    ed_run,
                   // mode,
                    clk,
                    reset);
                
parameter DWIDTH=128;
parameter RWIDTH=32;

output [0:DWIDTH-1] data_out;
input  [0:DWIDTH-1] data_in;
input  [0:RWIDTH-1] round_key;
input  get_data;
input  ed_run;
//input  [0:4] counter;
//input  mode;
input  clk;
input  reset;

reg    [0:DWIDTH-1] data_reg;
reg    [0:DWIDTH-1] data_out;
reg    [0:DWIDTH-1] next_data;
reg    [0:RWIDTH-1] cur_3,cur_2,cur_1,cur_0;
reg    [0:RWIDTH-1] next_3,next_2,next_1,next_0;
reg    [0:RWIDTH-1] fir_ad;
wire   [0:RWIDTH-1] b_shift4,b_shift3,b_shift2,b_shift1,b_shift0;
wire   [0:7] sbox3,sbox2,sbox1,sbox0; 
reg    [0:31] sbox_out;

always @ (posedge clk or negedge reset)
  if(!reset)
    data_reg<=0;
      else 
        data_reg<=next_data;
    
always @ (get_data or ed_run or data_in or next_3 or next_2 or next_1 or next_0 or data_reg)
  if(get_data)
   begin
    next_data=data_in;
   end
     else 
       if(ed_run)
         next_data={next_0,next_1,next_2,next_3};
          else
           next_data=data_reg;
  
always @ (cur_3 or cur_2 or cur_1 or cur_0 or b_shift4 or b_shift3 or b_shift2 or b_shift1 or b_shift0)
  begin 
    next_0=cur_1;
    next_1=cur_2;
    next_2=cur_3;
    next_3=cur_0^b_shift4^b_shift3^b_shift2^b_shift1^b_shift0;
  end
  
always @ (cur_3 or cur_2 or cur_1 or round_key)
 begin
  fir_ad=cur_3^cur_2^cur_1^round_key;
 end 
 
 always @ (sbox3 or sbox2 or sbox1 or sbox0)
   sbox_out={sbox0,sbox1,sbox2,sbox3};
  
ARS_sbox   Sbox3(
            .sout(sbox3),
            .sin(fir_ad[24:31])
            );
ARS_sbox   Sbox2(
            .sout(sbox2),
            .sin(fir_ad[16:23])
            );
ARS_sbox   Sbox1(
            .sout(sbox1),
            .sin(fir_ad[8:15])
            );
ARS_sbox   Sbox0(
            .sout(sbox0),
            .sin(fir_ad[0:7])
            );
            
ARS_B_SHIFT4  B_shift4(
                   .b4_out(b_shift4),
                   .b4_in(sbox_out)
                   );
ARS_B_SHIFT3  B_shift3(
                   .b3_out(b_shift3),
                   .b3_in(sbox_out)
                   );
ARS_B_SHIFT2  B_shift2(
                   .b2_out(b_shift2),
                   .b2_in(sbox_out)
                   );
ARS_B_SHIFT1  B_shift1(
                   .b1_out(b_shift1),
                   .b1_in(sbox_out)
                   );
ARS_B_SHIFT0  B_shift0(
                   .b0_out(b_shift0),
                   .b0_in(sbox_out)
                   );
                   
always @(data_reg)
begin        
  cur_0 = data_reg[0:31];
  cur_1 = data_reg[32:63];
  cur_2 = data_reg[64:95];
  cur_3 = data_reg[96:127];
  data_out={data_reg[96:127],data_reg[64:95],data_reg[32:63],data_reg[0:31]};
end

endmodule