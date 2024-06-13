`timescale 1ns / 1ps

module test_sm3;

  reg clk;
  reg reset;
  reg [31:0] din;
  reg [2:0] cmd_i;
  reg cmd_w_i;
  reg [511:0] y;

  wire [31:0] dout;
  wire [3:0] cmd_o;
  wire [3:0] read_counter;
  ARS_SM3 t1 (
      clk,
      reset,
      din,
      dout,
      cmd_i,
      cmd_w_i,
      cmd_o,
      read_counter
  );

  always #5 clk = ~clk;

  initial begin
    clk = 1'b0;
    reset = 1'b0;
    cmd_w_i = 1'b0;
    cmd_i = 3'b0;
    y = 512'b0;

    #21 reset = 1'b1;

    #17 reset = 1'b0;

    @(posedge clk);

    cmd_i   = 3'b010;
    y = {"abc", 8'h80, 416'd0, 61'd3, 3'd0};
    //y = {"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq", 8'h80, 56'd0};
    inputdata(y);
    repeat(5) @(posedge clk);
    while (cmd_o[3]) @(posedge clk);
    repeat(5) @(posedge clk);

    //#100;
//    cmd_i = 3'b110;
//    y = {448'h0, 61'd56, 3'd0};
//    inputdata(y);
//    repeat(5) @(posedge clk);
//    while (cmd_o[3]) @(posedge clk);
//    repeat(5) @(posedge clk);

    cmd_i   = 3'b001;
    cmd_w_i = 1'b1;

    @(posedge clk);
    cmd_w_i = 1'b0;

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    #100;
    


  end
  task inputdata;
    input [511:0] y;
    integer i;

    begin
      cmd_w_i = 1'b1;
      for (i = 0; i <= 15; i = i + 1) begin
        @(posedge clk);
        din = (y >> 512 - ((i + 1) * 32));
        cmd_w_i = 1'b0;
      end
    end
  endtask
endmodule
