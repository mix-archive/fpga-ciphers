`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:05 12/10/2013 
// Design Name: 
// Module Name:    sms4_ori 
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
module ARS_sms4(kout,
                 dout,
                 busy,
                 ready,
                 kstr,
                 kin,
                 din,
                 start,
                 enc,
                 load,
                 kvld,
                 clk,
                 reset);
                 
parameter DWIDTH=128;
parameter RWIDTH=32;

output [0:DWIDTH-1] kout;
output [0:DWIDTH-1] dout;
output busy;
output ready;
output kstr;

input  [0:DWIDTH-1] kin;
input  [0:DWIDTH-1] din;
input  start;
input  enc;
input  load;
input  [0:1] kvld;
input  clk;
input  reset;

wire get_data;
wire get_key;
wire ed_run;
wire exp_run;
wire mode;
wire [0:4] counter;
wire [0:RWIDTH-1] round_key;

ARS_sms4_control  control(
                          .busy(busy),
                          .dout_vld(ready),
                          .key_str(kstr),
                          .get_data(get_data),
                          .get_key(get_key),
                          .counter(counter),
                          .mode(mode),
                          //.ed_mode(ed_mode),
                          .exp_run(exp_run),
                          .ed_run(ed_run),
                          .start(start),
                          .enc(enc),
                          .din_vld(load),
                          .key_vld(kvld),
                          .clk(clk),
                          .reset(reset)
                          );

ARS_keyextension  expand(
                       .key_out(kout),
                       .round_key(round_key),
                       .key_in(kin),
                       .get_key(get_key),
                       .exp_run(exp_run),
                       .mode(mode),
                       //.ed_mode(ed_mode),
                       .clk(clk),
                       .reset(reset),
                       .counter(counter)
                       );
                       
ARS_edcrypt  edcrypt(
                     .data_out(dout),
                     .data_in(din),
                     .round_key(round_key),
                     .get_data(get_data),
                     .ed_run(ed_run),
                    // .counter(counter),
                     //.mode(mode),
                     .clk(clk),
                     .reset(reset)
                     );
endmodule