module control #(
    parameter int WIDTH = 32
) (
    input [WIDTH-1:0] p,
    q,
    input clk,
    input reset,
    input reset1,
    input encrypt_decrypt,
    input [WIDTH-1:0] msg_in,
    output [WIDTH*2-1:0] msg_out,
    output mod_exp_finish
);

  wire inverter_finish;
  wire [WIDTH*2-1:0] e, d;
  wire [WIDTH*2-1:0] exponent = encrypt_decrypt ? e : d;
  wire [WIDTH*2-1:0] modulo = p * q;
  wire [WIDTH*2-1:0] msg_reg = msg_in;

  inverter #(
      .WIDTH(WIDTH)
  ) i (
      .p(p),
      .q(q),
      .clk(clk),
      .reset(reset),
      .finish(inverter_finish),
      .e(e),
      .d(d)
  );

  mod_exp #(
      .WIDTH(WIDTH)
  ) m (
      .base(msg_reg),
      .modulo(modulo),
      .exponent(exponent),
      .clk(clk),
      .reset(reset1),
      .finish(mod_exp_finish),
      .result(msg_out)
  );

endmodule
