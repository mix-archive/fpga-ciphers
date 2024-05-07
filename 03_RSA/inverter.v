`define UPDATING 3'd1 // 定义状态常量，更新状态为1
`define CHECK 3'd2 // 检查状态常量，检查状态为2
`define HOLDING 3'd3 // 保持状态常量，保持状态为3

module inverter #(
    parameter int WIDTH = 32
) (  // 定义模块inverter，带有参数WIDTH，默认为32位
    input [WIDTH-1:0] p,  // 输入端口p，宽度为WIDTH
    input [WIDTH-1:0] q,  // 输入端口q，宽度为WIDTH
    input clk,  // 输入时钟信号
    input reset,  // 输入复位信号
    output finish,  // 输出完成信号
    output [WIDTH*2-1:0] e,  // 输出e，宽度为2*WIDTH
    output [WIDTH*2-1:0] d  // 输出d，宽度为2*WIDTH
);

  reg [WIDTH*2-1:0] phin_reg, a, b, y, y_prev;  // 定义寄存器变量
  reg [2:0] state;  // 定义状态寄存器
  reg [WIDTH-1:0] e_reg;  // 定义e的寄存器

  wire [WIDTH*2-1:0] phin = (p - 1) * (q - 1);  // 定义wire变量phin，表示(p-1)*(q-1)
  wire [WIDTH*2-1:0] quotient, b_next;  // 定义wire变量quotient和b_next
  wire [WIDTH*2-1:0] y_next = y_prev - quotient * y;  // 定义wire变量y_next
  wire [  WIDTH-1:0] e_plus3 = e_reg + 2;  // 定义wire变量e_plus3

  assign finish = (state == `HOLDING) ? 1'b1 : 1'b0;  // 根据状态判断完成信号
  assign e = e_reg;  // 赋值e的输出
  assign d = y_prev;  // 赋值d的输出

  mod #(2 * WIDTH) x_mod_y (  // 实例化模块x_mod_y
      .Dividend (a),
      .Divisor  (b),
      .Quotient (quotient),
      .remainder(b_next)
  );

  //拓展欧几里得算法
  always @(posedge clk) begin  // 时钟触发always块
    if (reset) begin  // 如果复位信号为1
      phin_reg <= phin;  // 将phin的值赋给phin_reg
      a <= phin;  // 将phin的值赋给a
      b <= 3;  // 将常数3赋给b
      e_reg <= 3;  // 将常数3赋给e_reg
      y <= 1;  // 将常数1赋给y
      y_prev <= 0;  // 将常数0赋给y_prev
      state <= `UPDATING;  // 将状态设为UPDATING
    end
    case (state)  // 根据状态进行不同的操作
      `UPDATING: begin  // 如果状态为UPDATING
        if (b != 0) begin  // 如果b不等于0
          a <= b;  // 将b的值赋给a
          b <= b_next;  // 将b_next的值赋给b
          y <= y_next;  // 将y_next的值赋给y
          y_prev <= y;  // 将y的值赋给y_prev
          state <= `UPDATING;  // 保持状态为UPDATING
        end else state <= `CHECK;  // 如果b等于0，状态转为CHECK
      end
      `CHECK: begin  // 如果状态为CHECK
        if (a == 64'd1 && y_prev[WIDTH*2-1] == 1'b0)  // 如果a等于1且y_prev的最高位为0
          state <= `HOLDING;  // 状态转为HOLDING
        else begin  // 否则
          a <= phin_reg;  // 将phin_reg的值赋给a
          b <= e_plus3;  // 将e_plus3的值赋给b
          e_reg <= e_plus3;  // 将e_plus3的值赋给e_reg
          y <= 1;  // 将常数1赋给y
          y_prev <= 0;  // 将常数0赋给y_prev
          state <= `UPDATING;  // 状态转为UPDATING
        end
      end
      `HOLDING: begin  // 如果状态为HOLDING
      end  // 什么也不做
    endcase
  end
endmodule
