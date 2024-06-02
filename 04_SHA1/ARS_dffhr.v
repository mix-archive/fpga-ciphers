`timescale 1ns / 1ps
module ARS_dffhr (
    d,
    r,
    clk,
    q
);
  parameter WIDTH = 1;
  input r;
  input clk;
  input [WIDTH-1:0] d;
  output [WIDTH-1:0] q;
  reg [WIDTH-1:0] q;

  always @(posedge clk)
    if (r) q <= {WIDTH{1'b0}};
    else q <= d;

endmodule  // dffhr

