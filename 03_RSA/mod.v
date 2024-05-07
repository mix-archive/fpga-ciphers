module mod #(
    parameter WIDTH = 16
) (
    input  [WIDTH-1:0] Dividend,   //被除数
    input  [WIDTH-1:0] Divisor,    //除数
    output [WIDTH-1:0] remainder,  //余数
    output [WIDTH-1:0] Quotient    //商
);

  reg [WIDTH-1:0] Dividend_reg, Divisor_reg;  //寄存器
  reg [WIDTH:0] p;  //中间结果寄存器
  integer i;  //循环计数

  always @(Dividend or Divisor) begin
    Dividend_reg = Dividend;  //赋值给寄存器
    Divisor_reg = Divisor;
    p = 0;  //初始化中间结果
    for (i = 0; i < WIDTH; i = i + 1) begin  //对0到WIDTH-1每一位进行除法运算
      p = {p[WIDTH-2:0], Dividend_reg[WIDTH-1]};
      Dividend_reg[WIDTH-1:1] = Dividend_reg[WIDTH-2:0];
      p = p - Divisor_reg;
      if (p[WIDTH-1] == 1) begin
        Dividend_reg[0] = 1'b0;
        p = p + Divisor_reg;
      end else Dividend_reg[0] = 1'b1;
    end

  end

  assign remainder = p, Quotient = Dividend_reg;
endmodule
