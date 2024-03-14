`timescale 1ns / 1ps
/**
* F function of DES
*/
module ARS_ENDEcrp (
    OUTR,  // Right-half output
    OUTL,  // Left-half output
    INR,  // Right-half input
    INL,  // Left-half input
    K_sub  //Subkey
);
  output [32:1] OUTR, OUTL;
  input [32:1] INR, INL;
  input [48:1] K_sub;

  wire [48:1] E;
  wire [48:1] X;
  wire [48:1] S;

  /**
  * Expansion function (E table)
  * expand 32-bit input to 48-bit output
  */
  assign E[48:1] = {
    INR[32],
    INR[1],
    INR[2],
    INR[3],
    INR[4],
    INR[5],
    INR[4],
    INR[5],
    INR[6],
    INR[7],
    INR[8],
    INR[9],
    INR[8],
    INR[9],
    INR[10],
    INR[11],
    INR[12],
    INR[13],
    INR[12],
    INR[13],
    INR[14],
    INR[15],
    INR[16],
    INR[17],
    INR[16],
    INR[17],
    INR[18],
    INR[19],
    INR[20],
    INR[21],
    INR[20],
    INR[21],
    INR[22],
    INR[23],
    INR[24],
    INR[25],
    INR[24],
    INR[25],
    INR[26],
    INR[27],
    INR[28],
    INR[29],
    INR[28],
    INR[29],
    INR[30],
    INR[31],
    INR[32],
    INR[1]
  };

  // xor expanded input with subkey
  assign X = E ^ K_sub;

  // Substitution function (S box)
  // 48-bit input is divided into 8 6-bit blocks
  // each block is substituted using a different S box
  // resulting in 8 4-bit blocks, back into a 32-bit block
  ARS_sbox1 u0 (
      .addr(X[06:01]),
      .dout(S[04:01])
  );
  ARS_sbox2 u1 (
      .addr(X[12:07]),
      .dout(S[08:05])
  );
  ARS_sbox3 u2 (
      .addr(X[18:13]),
      .dout(S[12:09])
  );
  ARS_sbox4 u3 (
      .addr(X[24:19]),
      .dout(S[16:13])
  );
  ARS_sbox5 u4 (
      .addr(X[30:25]),
      .dout(S[20:17])
  );
  ARS_sbox6 u5 (
      .addr(X[36:31]),
      .dout(S[24:21])
  );
  ARS_sbox7 u6 (
      .addr(X[42:37]),
      .dout(S[28:25])
  );
  ARS_sbox8 u7 (
      .addr(X[48:43]),
      .dout(S[32:29])
  );

  // Permutation function (P box)
  assign OUTR = {
    S[16], S[7], S[20], S[21], S[29], S[12], S[28],
    S[17], S[1], S[15], S[23], S[26], S[5], S[18],
    S[31], S[10], S[2], S[8], S[24], S[14], S[32],
    S[27], S[3], S[9], S[19], S[13], S[30], S[6],
    S[22], S[11], S[4], S[25]}^ INL;

  assign OUTL = INR;


endmodule

`timescale 1ns / 1ps
module ARS_sbox1 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 14;
      1:  dout = 4;
      2:  dout = 13;
      3:  dout = 1;
      4:  dout = 2;
      5:  dout = 15;
      6:  dout = 11;
      7:  dout = 8;
      8:  dout = 3;
      9:  dout = 10;
      10: dout = 6;
      11: dout = 12;
      12: dout = 5;
      13: dout = 9;
      14: dout = 0;
      15: dout = 7;
      16: dout = 0;
      17: dout = 15;
      18: dout = 7;
      19: dout = 4;
      20: dout = 14;
      21: dout = 2;
      22: dout = 13;
      23: dout = 1;
      24: dout = 10;
      25: dout = 6;
      26: dout = 12;
      27: dout = 11;
      28: dout = 9;
      29: dout = 5;
      30: dout = 3;
      31: dout = 8;
      32: dout = 4;
      33: dout = 1;
      34: dout = 14;
      35: dout = 8;
      36: dout = 13;
      37: dout = 6;
      38: dout = 2;
      39: dout = 11;
      40: dout = 15;
      41: dout = 12;
      42: dout = 9;
      43: dout = 7;
      44: dout = 3;
      45: dout = 10;
      46: dout = 5;
      47: dout = 0;
      48: dout = 15;
      49: dout = 12;
      50: dout = 8;
      51: dout = 2;
      52: dout = 4;
      53: dout = 9;
      54: dout = 1;
      55: dout = 7;
      56: dout = 5;
      57: dout = 11;
      58: dout = 3;
      59: dout = 14;
      60: dout = 10;
      61: dout = 0;
      62: dout = 6;
      63: dout = 13;

    endcase
  end


endmodule





module ARS_sbox2 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 15;
      1:  dout = 1;
      2:  dout = 8;
      3:  dout = 14;
      4:  dout = 6;
      5:  dout = 11;
      6:  dout = 3;
      7:  dout = 4;
      8:  dout = 9;
      9:  dout = 7;
      10: dout = 2;
      11: dout = 13;
      12: dout = 12;
      13: dout = 0;
      14: dout = 5;
      15: dout = 10;
      16: dout = 3;
      17: dout = 13;
      18: dout = 4;
      19: dout = 7;
      20: dout = 15;
      21: dout = 2;
      22: dout = 8;
      23: dout = 14;
      24: dout = 12;
      25: dout = 0;
      26: dout = 1;
      27: dout = 10;
      28: dout = 6;
      29: dout = 9;
      30: dout = 11;
      31: dout = 5;
      32: dout = 0;
      33: dout = 14;
      34: dout = 7;
      35: dout = 11;
      36: dout = 10;
      37: dout = 4;
      38: dout = 13;
      39: dout = 1;
      40: dout = 5;
      41: dout = 8;
      42: dout = 12;
      43: dout = 6;
      44: dout = 9;
      45: dout = 3;
      46: dout = 2;
      47: dout = 15;
      48: dout = 13;
      49: dout = 8;
      50: dout = 10;
      51: dout = 1;
      52: dout = 3;
      53: dout = 15;
      54: dout = 4;
      55: dout = 2;
      56: dout = 11;
      57: dout = 6;
      58: dout = 7;
      59: dout = 12;
      60: dout = 0;
      61: dout = 5;
      62: dout = 14;
      63: dout = 9;

    endcase
  end


endmodule




module ARS_sbox3 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 10;
      1:  dout = 0;
      2:  dout = 9;
      3:  dout = 14;
      4:  dout = 6;
      5:  dout = 3;
      6:  dout = 15;
      7:  dout = 5;
      8:  dout = 1;
      9:  dout = 13;
      10: dout = 12;
      11: dout = 7;
      12: dout = 11;
      13: dout = 4;
      14: dout = 2;
      15: dout = 8;
      16: dout = 13;
      17: dout = 7;
      18: dout = 0;
      19: dout = 9;
      20: dout = 3;
      21: dout = 4;
      22: dout = 6;
      23: dout = 10;
      24: dout = 2;
      25: dout = 8;
      26: dout = 5;
      27: dout = 14;
      28: dout = 12;
      29: dout = 11;
      30: dout = 15;
      31: dout = 1;
      32: dout = 13;
      33: dout = 6;
      34: dout = 4;
      35: dout = 9;
      36: dout = 8;
      37: dout = 15;
      38: dout = 3;
      39: dout = 0;
      40: dout = 11;
      41: dout = 1;
      42: dout = 2;
      43: dout = 12;
      44: dout = 5;
      45: dout = 10;
      46: dout = 14;
      47: dout = 7;
      48: dout = 1;
      49: dout = 10;
      50: dout = 13;
      51: dout = 0;
      52: dout = 6;
      53: dout = 9;
      54: dout = 8;
      55: dout = 7;
      56: dout = 4;
      57: dout = 15;
      58: dout = 14;
      59: dout = 3;
      60: dout = 11;
      61: dout = 5;
      62: dout = 2;
      63: dout = 12;

    endcase
  end


endmodule






module ARS_sbox4 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 7;
      1:  dout = 13;
      2:  dout = 14;
      3:  dout = 3;
      4:  dout = 0;
      5:  dout = 6;
      6:  dout = 9;
      7:  dout = 10;
      8:  dout = 1;
      9:  dout = 2;
      10: dout = 8;
      11: dout = 5;
      12: dout = 11;
      13: dout = 12;
      14: dout = 4;
      15: dout = 15;
      16: dout = 13;
      17: dout = 8;
      18: dout = 11;
      19: dout = 5;
      20: dout = 6;
      21: dout = 15;
      22: dout = 0;
      23: dout = 3;
      24: dout = 4;
      25: dout = 7;
      26: dout = 2;
      27: dout = 12;
      28: dout = 1;
      29: dout = 10;
      30: dout = 14;
      31: dout = 9;
      32: dout = 10;
      33: dout = 6;
      34: dout = 9;
      35: dout = 0;
      36: dout = 12;
      37: dout = 11;
      38: dout = 7;
      39: dout = 13;
      40: dout = 15;
      41: dout = 1;
      42: dout = 3;
      43: dout = 14;
      44: dout = 5;
      45: dout = 2;
      46: dout = 8;
      47: dout = 4;
      48: dout = 3;
      49: dout = 15;
      50: dout = 0;
      51: dout = 6;
      52: dout = 10;
      53: dout = 1;
      54: dout = 13;
      55: dout = 8;
      56: dout = 9;
      57: dout = 4;
      58: dout = 5;
      59: dout = 11;
      60: dout = 12;
      61: dout = 7;
      62: dout = 2;
      63: dout = 14;

    endcase
  end



endmodule





module ARS_sbox5 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 2;
      1:  dout = 12;
      2:  dout = 4;
      3:  dout = 1;
      4:  dout = 7;
      5:  dout = 10;
      6:  dout = 11;
      7:  dout = 6;
      8:  dout = 8;
      9:  dout = 5;
      10: dout = 3;
      11: dout = 15;
      12: dout = 13;
      13: dout = 0;
      14: dout = 14;
      15: dout = 9;
      16: dout = 14;
      17: dout = 11;
      18: dout = 2;
      19: dout = 12;
      20: dout = 4;
      21: dout = 7;
      22: dout = 13;
      23: dout = 1;
      24: dout = 5;
      25: dout = 0;
      26: dout = 15;
      27: dout = 10;
      28: dout = 3;
      29: dout = 9;
      30: dout = 8;
      31: dout = 6;
      32: dout = 4;
      33: dout = 2;
      34: dout = 1;
      35: dout = 11;
      36: dout = 10;
      37: dout = 13;
      38: dout = 7;
      39: dout = 8;
      40: dout = 15;
      41: dout = 9;
      42: dout = 12;
      43: dout = 5;
      44: dout = 6;
      45: dout = 3;
      46: dout = 0;
      47: dout = 14;
      48: dout = 11;
      49: dout = 8;
      50: dout = 12;
      51: dout = 7;
      52: dout = 1;
      53: dout = 14;
      54: dout = 2;
      55: dout = 13;
      56: dout = 6;
      57: dout = 15;
      58: dout = 0;
      59: dout = 9;
      60: dout = 10;
      61: dout = 4;
      62: dout = 5;
      63: dout = 3;

    endcase
  end


endmodule




module ARS_sbox6 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 12;
      1:  dout = 1;
      2:  dout = 10;
      3:  dout = 15;
      4:  dout = 9;
      5:  dout = 2;
      6:  dout = 6;
      7:  dout = 8;
      8:  dout = 0;
      9:  dout = 13;
      10: dout = 3;
      11: dout = 4;
      12: dout = 14;
      13: dout = 7;
      14: dout = 5;
      15: dout = 11;
      16: dout = 10;
      17: dout = 15;
      18: dout = 4;
      19: dout = 2;
      20: dout = 7;
      21: dout = 12;
      22: dout = 9;
      23: dout = 5;
      24: dout = 6;
      25: dout = 1;
      26: dout = 13;
      27: dout = 14;
      28: dout = 0;
      29: dout = 11;
      30: dout = 3;
      31: dout = 8;
      32: dout = 9;
      33: dout = 14;
      34: dout = 15;
      35: dout = 5;
      36: dout = 2;
      37: dout = 8;
      38: dout = 12;
      39: dout = 3;
      40: dout = 7;
      41: dout = 0;
      42: dout = 4;
      43: dout = 10;
      44: dout = 1;
      45: dout = 13;
      46: dout = 11;
      47: dout = 6;
      48: dout = 4;
      49: dout = 3;
      50: dout = 2;
      51: dout = 12;
      52: dout = 9;
      53: dout = 5;
      54: dout = 15;
      55: dout = 10;
      56: dout = 11;
      57: dout = 14;
      58: dout = 1;
      59: dout = 7;
      60: dout = 6;
      61: dout = 0;
      62: dout = 8;
      63: dout = 13;

    endcase
  end



endmodule



module ARS_sbox7 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 4;
      1:  dout = 11;
      2:  dout = 2;
      3:  dout = 14;
      4:  dout = 15;
      5:  dout = 0;
      6:  dout = 8;
      7:  dout = 13;
      8:  dout = 3;
      9:  dout = 12;
      10: dout = 9;
      11: dout = 7;
      12: dout = 5;
      13: dout = 10;
      14: dout = 6;
      15: dout = 1;
      16: dout = 13;
      17: dout = 0;
      18: dout = 11;
      19: dout = 7;
      20: dout = 4;
      21: dout = 9;
      22: dout = 1;
      23: dout = 10;
      24: dout = 14;
      25: dout = 3;
      26: dout = 5;
      27: dout = 12;
      28: dout = 2;
      29: dout = 15;
      30: dout = 8;
      31: dout = 6;
      32: dout = 1;
      33: dout = 4;
      34: dout = 11;
      35: dout = 13;
      36: dout = 12;
      37: dout = 3;
      38: dout = 7;
      39: dout = 14;
      40: dout = 10;
      41: dout = 15;
      42: dout = 6;
      43: dout = 8;
      44: dout = 0;
      45: dout = 5;
      46: dout = 9;
      47: dout = 2;
      48: dout = 6;
      49: dout = 11;
      50: dout = 13;
      51: dout = 8;
      52: dout = 1;
      53: dout = 4;
      54: dout = 10;
      55: dout = 7;
      56: dout = 9;
      57: dout = 5;
      58: dout = 0;
      59: dout = 15;
      60: dout = 14;
      61: dout = 2;
      62: dout = 3;
      63: dout = 12;


    endcase
  end


endmodule



module ARS_sbox8 (
    addr,
    dout
);
  input [6:1] addr;
  output [4:1] dout;
  reg [4:1] dout;

  always @(addr) begin
    case ({
      addr[6], addr[1], addr[5:2]
    })

      0:  dout = 13;
      1:  dout = 2;
      2:  dout = 8;
      3:  dout = 4;
      4:  dout = 6;
      5:  dout = 15;
      6:  dout = 11;
      7:  dout = 1;
      8:  dout = 10;
      9:  dout = 9;
      10: dout = 3;
      11: dout = 14;
      12: dout = 5;
      13: dout = 0;
      14: dout = 12;
      15: dout = 7;
      16: dout = 1;
      17: dout = 15;
      18: dout = 13;
      19: dout = 8;
      20: dout = 10;
      21: dout = 3;
      22: dout = 7;
      23: dout = 4;
      24: dout = 12;
      25: dout = 5;
      26: dout = 6;
      27: dout = 11;
      28: dout = 0;
      29: dout = 14;
      30: dout = 9;
      31: dout = 2;
      32: dout = 7;
      33: dout = 11;
      34: dout = 4;
      35: dout = 1;
      36: dout = 9;
      37: dout = 12;
      38: dout = 14;
      39: dout = 2;
      40: dout = 0;
      41: dout = 6;
      42: dout = 10;
      43: dout = 13;
      44: dout = 15;
      45: dout = 3;
      46: dout = 5;
      47: dout = 8;
      48: dout = 2;
      49: dout = 1;
      50: dout = 14;
      51: dout = 7;
      52: dout = 4;
      53: dout = 10;
      54: dout = 8;
      55: dout = 13;
      56: dout = 15;
      57: dout = 12;
      58: dout = 9;
      59: dout = 0;
      60: dout = 3;
      61: dout = 5;
      62: dout = 6;
      63: dout = 11;

    endcase
  end


endmodule
