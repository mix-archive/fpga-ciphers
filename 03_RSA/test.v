`timescale 1ns / 1ps

module test;

  parameter int WIDTH = 128;

  reg clk;
  reg reset;
  reg reset1;
  reg encrypt_decrypt;
  reg [WIDTH*2-1:0] p;
  reg [WIDTH*2-1:0] q;
  reg [WIDTH*2-1:0] msg_in;

  wire [WIDTH*2-1:0] msg_out;
  wire mod_exp_finish;

  control #(WIDTH) dut (
      .p(p),
      .q(q),
      .clk(clk),
      .reset(reset),
      .reset1(reset1),
      .encrypt_decrypt(encrypt_decrypt),
      .msg_in(msg_in),
      .msg_out(msg_out),
      .mod_exp_finish(mod_exp_finish)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 0;
    reset1 = 0;
    encrypt_decrypt = 1;
    p = 128'd113680897410347;
    q = 128'd7999808077935876437321;
    msg_in = 256'h0000000000000000000000000000000000262d806a3e18f03ab37b2857e7e149;

    // start
    #1 reset = 1;
    #10 reset = 0;
    #1000 reset1 = 1;
    #10 reset1 = 0;
  end

endmodule

