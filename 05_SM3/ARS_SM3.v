`timescale 1ns / 1ps
`define SM3_H0 32'h7380166f
`define SM3_H1 32'h4914b2b9
`define SM3_H2 32'h172442d7
`define SM3_H3 32'hda8a0600
`define SM3_H4 32'ha96f30bc
`define SM3_H5 32'h163138aa
`define SM3_H6 32'he38dee4d
`define SM3_H7 32'hb0fb0e4e

`define SM3_T0 32'h79cc4519
`define SM3_T1 32'h9d8a7a87

module ARS_SM3 (
    clk,
    reset,
    din,
    dout,
    cmd_i,
    cmd_w_i,
    cmd_o,
    read_counter
);

  input clk;  // global clock input
  input reset;  // global reset input , active high

  input [31:0] din;  // text input 32bit
  output [31:0] dout;  // text output 32bit

  input [2:0] cmd_i;  // command input
  input cmd_w_i;  // command input write enable
  output [3:0] cmd_o;  // command output(status)
  reg  [ 3:0] cmd;
  wire [ 3:0] cmd_o;

  reg  [31:0] dout;

  reg  [ 6:0] round;
  wire [ 6:0] round_plus_1;

  output reg [3:0] read_counter;

  reg [31:0] H0, H1, H2, H3, H4, H5, H6, H7;
  reg [31:0]
      W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15, W16, W17, W18, W19, Wt;
  reg [31:0] Tj;
  reg [31:0] A, B, C, D, E, F, G, H;

  reg busy;

  assign cmd_o = cmd;
  always @(posedge clk) begin
    if (reset) cmd <= 'b0;
    else if (cmd_w_i) cmd[2:0] <= cmd_i[2:0];  // busy bit can't write
    else begin
      cmd[3] <= busy;  // update busy bit
      if (~busy) cmd[1:0] <= 2'b00;  // hardware auto clean R/W bits
    end
  end

  //  functions
  wire [31:0] SS1_0, SS1, SS2, TT1, TT2;
  wire [31:0] FF1_ABC, FF2_ABC, FFj_ABC, GG1_EFG, GG2_EFG, GGj_EFG;
  wire [31:0] Wj0_1, Wj0_4, Wj1_1, Wj1_4, Wj2_1;
  reg [31:0] Wj1, Wj2;
  wire [31:0] next_C, next_E, next_G, next_Tj;
  wire [255:0] SM3_result;

  assign FF1_ABC = A ^ B ^ C;
  assign FF2_ABC = (A & B) | (A & C) | (B & C);
  assign GG1_EFG = E ^ F ^ G;
  assign GG2_EFG = (E & F) | (~E & G);

  assign FFj_ABC = (round < 'd22) ? FF1_ABC : FF2_ABC;
  assign GGj_EFG = (round < 'd22) ? GG1_EFG : GG2_EFG;

  assign Wj0_1 = W0 ^ W7 ^ {W13[16:0], W13[31:17]};
  assign Wj1_1 = {Wj0_1 ^ {Wj0_1[16:0],Wj0_1[31:17]} ^ {Wj0_1[8:0],Wj0_1[31:9]}} ^ {W3[24:0],W3[31:25]} ^ W10;
  assign Wj0_4 = W4 ^ W11 ^ {W17[16:0], W17[31:17]};
  assign Wj1_4 = {Wj0_4 ^ {Wj0_4[16:0],Wj0_4[31:17]} ^ {Wj0_4[8:0],Wj0_4[31:9]}} ^ {W7[24:0],W7[31:25]} ^ W14;
  assign Wj2_1 = Wj1_1 ^ Wj1_4;

  assign SS1_0 = {A[19:0], A[31:20]} + E + Tj;
  assign SS1 = {SS1_0[24:0], SS1_0[31:25]};
  assign SS2 = SS1 ^ {A[19:0], A[31:20]};

  assign TT1 = FFj_ABC + D + SS2 + Wj2;
  assign TT2 = GGj_EFG + H + SS1 + Wj1;

  assign next_C = {B[22:0], B[31:23]};
  assign next_E = TT2 ^ {TT2[22:0], TT2[31:23]} ^ {TT2[14:0], TT2[31:15]};
  assign next_G = {F[12:0], F[31:13]};
  assign next_Tj = {Tj[30:0], Tj[31]};

  assign SM3_result = {A, B, C, D, E, F, G, H};

  assign round_plus_1 = round + 1;

  //------------------------------------------------------------------    
  // SM3  round
  //------------------------------------------------------------------
  always @(posedge clk) begin
    if (reset) begin
      round <= 'd0;
      busy <= 'b0;

      W0 <= 'b0;
      W1 <= 'b0;
      W2 <= 'b0;
      W3 <= 'b0;
      W4 <= 'b0;
      W5 <= 'b0;
      W6 <= 'b0;
      W7 <= 'b0;
      W8 <= 'b0;
      W9 <= 'b0;
      W10 <= 'b0;
      W11 <= 'b0;
      W12 <= 'b0;
      W13 <= 'b0;
      W14 <= 'b0;
      W15 <= 'b0;
      W16 <= 'b0;
      W17 <= 'b0;
      W18 <= 'b0;
      W19 <= 'b0;
      Wt <= 'b0;

      A <= 'b0;
      B <= 'b0;
      C <= 'b0;
      D <= 'b0;
      E <= 'b0;
      F <= 'b0;
      G <= 'b0;
      H <= 'b0;

      H0 <= 'b0;
      H1 <= 'b0;
      H2 <= 'b0;
      H3 <= 'b0;
      H4 <= 'b0;
      H5 <= 'b0;
      H6 <= 'b0;
      H7 <= 'b0;

    end else begin
      case (round)
        'd0: begin
          if (cmd[1]) begin
            W0 <= din;
            busy <= 'b1;
            round <= round_plus_1;

            case (cmd[2])
              1'b0:    //  first message
                                begin
                A  <= `SM3_H0;
                B  <= `SM3_H1;
                C  <= `SM3_H2;
                D  <= `SM3_H3;
                E  <= `SM3_H4;
                F  <= `SM3_H5;
                G  <= `SM3_H6;
                H  <= `SM3_H7;

                H0 <= `SM3_H0;
                H1 <= `SM3_H1;
                H2 <= `SM3_H2;
                H3 <= `SM3_H3;
                H4 <= `SM3_H4;
                H5 <= `SM3_H5;
                H6 <= `SM3_H6;
                H7 <= `SM3_H7;
              end
              1'b1:    //  internal message
                                begin
                H0 <= A;
                H1 <= B;
                H2 <= C;
                H3 <= D;
                H4 <= E;
                H5 <= F;
                H6 <= G;
                H7 <= H;

              end
            endcase
          end else begin  // IDLE
            round <= 'd0;
          end
        end
        'd1: begin
          W1 <= din;
          round <= round_plus_1;
        end
        'd2: begin
          W2 <= din;
          round <= round_plus_1;
        end
        'd3: begin
          W3 <= din;
          round <= round_plus_1;
        end
        'd4: begin
          W4 <= din;
          round <= round_plus_1;
        end
        'd5: begin
          W5 <= din;
          round <= round_plus_1;

          Wj1 <= W0;
          Wj2 <= W0 ^ W4;
          Tj <= `SM3_T0;
        end
        'd6: begin
          W6 <= din;
          round <= round_plus_1;

          Wj1 <= W1;
          Wj2 <= W1 ^ W5;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;

        end
        'd7: begin
          W7 <= din;
          round <= round_plus_1;

          Wj1 <= W2;
          Wj2 <= W2 ^ W6;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd8: begin
          W8 <= din;
          round <= round_plus_1;

          Wj1 <= W3;
          Wj2 <= W3 ^ W7;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd9: begin
          W9 <= din;
          round <= round_plus_1;

          Wj1 <= W4;
          Wj2 <= W4 ^ W8;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd10: begin
          W10 <= din;
          round <= round_plus_1;

          Wj1 <= W5;
          Wj2 <= W5 ^ W9;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd11: begin
          W11 <= din;
          round <= round_plus_1;

          Wj1 <= W6;
          Wj2 <= W6 ^ W10;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd12: begin
          W12 <= din;
          round <= round_plus_1;

          Wj1 <= W7;
          Wj2 <= W7 ^ W11;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd13: begin
          W13 <= din;
          round <= round_plus_1;

          Wj1 <= W8;
          Wj2 <= W8 ^ W12;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd14: begin
          W14 <= din;
          round <= round_plus_1;

          Wj1 <= W9;
          Wj2 <= W9 ^ W13;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd15: begin
          W15 <= din;
          round <= round_plus_1;

          Wj1 <= W10;
          Wj2 <= W10 ^ W14;
          Wt <= W0 ^ W7 ^ {W13[16:0], W13[31:17]};
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;
        end
        'd16: begin
          Wj1 <= W11;
          Wj2 <= W11 ^ W15;
          Wt <= W1 ^ W8 ^ {W14[16:0], W14[31:17]};
          W16 <= {Wt ^ {Wt[16:0], Wt[31:17]} ^ {Wt[8:0], Wt[31:9]}} ^ {W3[24:0], W3[31:25]} ^ W10;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;

          round <= round_plus_1;
        end
        'd17: begin
          Wj1 <= W12;
          Wj2 <= W12 ^ W16;
          Wt <= W2 ^ W9 ^ {W15[16:0], W15[31:17]};
          W17 <= {Wt ^ {Wt[16:0], Wt[31:17]} ^ {Wt[8:0], Wt[31:9]}} ^ {W4[24:0], W4[31:25]} ^ W11;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;

          round <= round_plus_1;
        end
        'd18: begin
          Wj1 <= W13;
          Wj2 <= W13 ^ W17;
          Wt <= W3 ^ W10 ^ {W16[16:0], W16[31:17]};
          W18 <= {Wt ^ {Wt[16:0], Wt[31:17]} ^ {Wt[8:0], Wt[31:9]}} ^ {W5[24:0], W5[31:25]} ^ W12;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;

          round <= round_plus_1;
        end
        'd19: begin
          Wj1 <= W14;
          Wj2 <= W14 ^ W18;
          Wt <= W4 ^ W11 ^ {W17[16:0], W17[31:17]};
          W19 <= {Wt ^ {Wt[16:0], Wt[31:17]} ^ {Wt[8:0], Wt[31:9]}} ^ {W6[24:0], W6[31:25]} ^ W13;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;

          round <= round_plus_1;
        end
        'd20: begin
          Wj1 <= W15;
          Wj2 <= W15 ^ W19;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;

          round <= round_plus_1;
        end
        'd21: begin
          Wj1   <= Wj1_1;
          Wj2   <= Wj2_1;
          Tj    <= `SM3_T1;

          W0    <= W1;
          W1    <= W2;
          W2    <= W3;
          W3    <= W4;
          W4    <= W5;
          W5    <= W6;
          W6    <= W7;
          W7    <= W8;
          W8    <= W9;
          W9    <= W10;
          W10   <= W11;
          W11   <= W12;
          W12   <= W13;
          W13   <= W14;
          W14   <= W15;
          W15   <= W16;
          W16   <= W17;
          W17   <= W18;
          W18   <= W19;
          Wt    <= W3 ^ W10 ^ {W16[16:0], W16[31:17]};  //W19


          A     <= TT1;
          B     <= A;
          C     <= next_C;
          D     <= C;
          E     <= next_E;
          F     <= E;
          G     <= next_G;
          H     <= G;  // step 15

          round <= round_plus_1;
        end
        'd22,
            'd23,
            'd24,
            'd25,
            'd26,
            'd27,
            'd28,
            'd29,
            'd30,
            'd31,
            'd32,
            'd33,
            'd34,
            'd35,
            'd36,
            'd37,
            'd38,
            'd39,
            'd40,
            'd41,
            'd42,
            'd43,
            'd44,
            'd45,
            'd46,
            'd47,
            'd48,
            'd49,
            'd50,
            'd51,
            'd52,
            'd53,
            'd54,
            'd55,
            'd56,
            'd57,
            'd58,
            'd59,
            'd60,
            'd61,
            'd62,
            'd63,
            'd64,
            'd65,
            'd66,
            'd67,
            'd68:
                    begin
          W0 <= W1;
          W1 <= W2;
          W2 <= W3;
          W3 <= W4;
          W4 <= W5;
          W5 <= W6;
          W6 <= W7;
          W7 <= W8;
          W8 <= W9;
          W9 <= W10;
          W10 <= W11;
          W11 <= W12;
          W12 <= W13;
          W13 <= W14;
          W14 <= W15;
          W15 <= W16;
          W16 <= W17;
          W17 <= {Wt ^ {Wt[16:0], Wt[31:17]} ^ {Wt[8:0], Wt[31:9]}} ^ {W5[24:0], W5[31:25]} ^ W12;
          Wt <= W3 ^ W10 ^ {W16[16:0], W16[31:17]};

          Wj1 <= Wj1_1;
          Wj2 <= Wj2_1;
          Tj <= next_Tj;

          A <= TT1;
          B <= A;
          C <= next_C;
          D <= C;
          E <= next_E;
          F <= E;
          G <= next_G;
          H <= G;

          round <= round_plus_1;
        end
        'd69: begin
          A <= TT1 ^ H0;
          B <= A ^ H1;
          C <= next_C ^ H2;
          D <= C ^ H3;
          E <= next_E ^ H4;
          F <= E ^ H5;
          G <= next_G ^ H6;
          H <= G ^ H7;
          round <= 'd0;
          busy <= 'b0;
        end
        default: begin
          round <= 'd0;
          busy  <= 'b0;
        end
      endcase
    end
  end

  //------------------------------------------------------------------    
  // read result 
  //------------------------------------------------------------------    
  //assign read_counter_sub = read_counter - 'd1;
  always @(posedge clk) begin
    if (reset) begin
      dout <= 'b0;
      read_counter <= 'd9;
    end else begin
      if (cmd[0]) begin
        read_counter <= 'd9;  // SM3     256/32=8
      end else begin
        if (~busy) begin
          case (read_counter)
            'd7: dout <= SM3_result[8*32-1:7*32];
            'd6: dout <= SM3_result[7*32-1:6*32];
            'd5: dout <= SM3_result[6*32-1:5*32];
            'd4: dout <= SM3_result[5*32-1:4*32];
            'd3: dout <= SM3_result[4*32-1:3*32];
            'd2: dout <= SM3_result[3*32-1:2*32];
            'd1: dout <= SM3_result[2*32-1:1*32];
            'd0: dout <= SM3_result[1*32-1:0*32];
            default: dout <= 'b0;
          endcase
          if (|read_counter) read_counter <= read_counter - 'd1;
        end else begin
          dout <= 'b0;
        end
      end
    end
  end

endmodule

