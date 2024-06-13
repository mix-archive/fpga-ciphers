`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:41:15 12/23/2013
// Design Name:   sms4
// Module Name:   E:/LIZI/sms4/test.v
// Project Name:  sms4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sms4
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg  [0:127] kin;
reg  [0:127] din;
reg  start;
reg  enc;
reg  load;
reg  [0:1] kvld;
reg  clk;
reg  reset;

wire [0:127] kout;
wire [0:127] dout;
wire busy;
wire ready;
wire kstr;

ARS_sms4  sms4test(
                        .kout(kout),
                        .dout(dout),
                        .busy(busy),
                        .ready(ready),
                        .kstr(kstr),
                        .kin(kin),
                        .din(din),
                        .start(start),
                        .enc(enc),
                        .load(load),
                        .kvld(kvld),
                        .clk(clk),
                        .reset(reset)
                        );


initial 
 begin
   din=128'h404cd32180dfa2c34f77b017c3f2b4d8;
   kin=128'h0123456789abcdeffedcba9876543210;
   reset=0;
   clk=0;
   $display("the input data is : %h", din);
   $display("the input key is : %h", kin);
   #4 reset   = 1;
   #4 enc     = 0;
      start   = 1;
      load = 1;
      kvld = 2'b01;
   #4 kvld = 2'b11;
   #130 load = 0;
   #300
   $display("The output key is :%h", kout);
   $display("The encrypted data is :%h", dout);
   #10
   din=128'h80523109584320957398746586785985;
   kin=128'h0123456789abcdeffedcba9876543210;
   $display("the input data is : %h", din);
   $display("the input key is : %h", kin);
   #4 enc     = 1;
      load = 1;
      kvld = 2'b01;
   #4 kvld = 2'b11;
   #130 load = 0;
   #300
   $display("The output key is :%h", kout);
   $display("The encrypted data is :%h", dout);
   $stop;
  end
  
always #2 clk=~clk;

endmodule