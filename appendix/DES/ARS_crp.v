`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:47:07 12/03/2013 
// Design Name: 
// Module Name:    crp 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ARS_ENDEcrp(OUTR, OUTL, INR, INL, K_sub);
output	[32:1]	OUTR, OUTL;
input	[32:1]	INR, INL;
input	[48:1]	K_sub;

wire	[48:1] E;
wire	[48:1] X;
wire	[48:1] S;

assign E[48:1] = {	INR[32], INR[1], INR[2], INR[3], INR[4], INR[5], INR[4], INR[5],
			INR[6], INR[7], INR[8], INR[9], INR[8], INR[9], INR[10], INR[11],
			INR[12], INR[13], INR[12], INR[13], INR[14], INR[15], INR[16],
			INR[17], INR[16], INR[17], INR[18], INR[19], INR[20], INR[21],
			INR[20], INR[21], INR[22], INR[23], INR[24], INR[25], INR[24],
			INR[25], INR[26], INR[27], INR[28], INR[29], INR[28], INR[29],
			INR[30], INR[31], INR[32], INR[1]};

assign X = E ^ K_sub;

ARS_sbox1 u0( .addr(X[06:01]), .dout(S[04:01]) );
ARS_sbox2 u1( .addr(X[12:07]), .dout(S[08:05]) );
ARS_sbox3 u2( .addr(X[18:13]), .dout(S[12:09]) );
ARS_sbox4 u3( .addr(X[24:19]), .dout(S[16:13]) );
ARS_sbox5 u4( .addr(X[30:25]), .dout(S[20:17]) );
ARS_sbox6 u5( .addr(X[36:31]), .dout(S[24:21]) );
ARS_sbox7 u6( .addr(X[42:37]), .dout(S[28:25]) );
ARS_sbox8 u7( .addr(X[48:43]), .dout(S[32:29]) );

assign OUTR = {	S[16], S[7], S[20], S[21], S[29], S[12], S[28],
			S[17], S[1], S[15], S[23], S[26], S[5], S[18],
			S[31], S[10], S[2], S[8], S[24], S[14], S[32],
			S[27], S[3], S[9], S[19], S[13], S[30], S[6],
			S[22], S[11], S[4], S[25]}^ INL;

assign OUTL = INR;


endmodule

