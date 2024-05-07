`define UPDATE 2'd1
`define HOLD 2'd2

module mod_exp #(
    parameter WIDTH = 32
) (
    input [WIDTH*2-1:0] base,
    input [WIDTH*2-1:0] modulo,
    input [WIDTH*2-1:0] exponent,
    input clk,
    input reset,
    output finish,
    output [WIDTH*2-1:0] result
);

  reg [WIDTH*2-1:0] base_reg, modulo_reg, exponent_reg, result_reg;
  reg [1:0] state;

  wire [WIDTH*2-1:0] result_mul_base = result_reg * base_reg;
  wire [WIDTH*2-1:0] result_next;
  wire [WIDTH*2-1:0] base_squared = base_reg * base_reg;
  wire [WIDTH*2-1:0] base_next;
  wire [WIDTH*2-1:0] exponent_next = exponent_reg >> 1;

  assign finish = (state == `HOLD) ? 1'b1 : 1'b0;  //finish在HOLD时置1，否则为0.
  assign result = result_reg;

  mod #(
      .WIDTH(WIDTH * 2)
  ) base_squared_mod (  //平方模modulo结果
      .Dividend (base_squared),
      .Divisor  (modulo_reg),
      .remainder(base_next),
      .Quotient ()
  );

  mod #(
      .WIDTH(WIDTH * 2)
  ) result_mul_base_mod (  //计算结果x基数的乘积模modulo
      .Dividend (result_mul_base),
      .Divisor  (modulo_reg),
      .remainder(result_next),
      .Quotient ()
  );

  always @(posedge clk) begin
    if (reset) begin  //reset为1，设置状态UPDATE
      base_reg <= base;
      modulo_reg <= modulo;
      exponent_reg <= exponent;
      result_reg <= 32'd1;
      state <= `UPDATE;
    end else
      case (state)
        `UPDATE: begin  //指数不为0，根据指数最低位更新结果、基数和指数，保持UPDATE，指数为0，转为HOLD
          if (exponent_reg != 0) begin
            if (exponent_reg[0]) result_reg <= result_next;
            base_reg <= base_next;
            exponent_reg <= exponent_next;
            state <= `UPDATE;
          end else state <= `HOLD;
        end

        `HOLD: begin
        end
      endcase
  end
endmodule
