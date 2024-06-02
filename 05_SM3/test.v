`timescale 1ns / 1ps

module test_sm3;

  reg clk;
  reg reset;
  reg [31:0] din;
  reg [2:0] cmd_i;
  reg cmd_w_i;

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

    #21 reset = 1'b1;

    #17 reset = 1'b0;

    @(posedge clk);

    cmd_i   = 3'b010;
    cmd_w_i = 1'b1;

    @(posedge clk);
    cmd_w_i = 1'b0;
    din = 32'h61626380;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'h0;

    @(posedge clk);
    din = 32'd24;

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    while (cmd_o[3]) @(posedge clk);

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    #100;

    /*@(posedge clk);
        cmd_i = 3'b110;
        cmd_w_i = 1'b1;
 
        @(posedge clk);
        cmd_w_i = 1'b0;
        din=32'h80000000;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'b0;
        
        @(posedge clk);
        din=32'd512;
        
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
       
        while (cmd_o[3])
		@(posedge clk);
 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        */
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
endmodule
