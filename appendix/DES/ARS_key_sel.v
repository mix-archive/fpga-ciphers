`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:48:57 12/03/2013 
// Design Name: 
// Module Name:    key_sel 
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
module ARS_keyExtension(K_sub, key, round);
output	[1:48]	K_sub;
input	[1:64]	key;
input	[3:0]	round;

wire [55:0]	K;
reg  [1:48]	K_sub;
wire [1:48]	K1, K2, K3, K4, K5, K6, K7, K8, K9;
wire [1:48]	K10, K11, K12, K13, K14, K15, K16;

assign K = {		key[01 : 07], key[09:15], key[17:23], key[25:31],
				key[33: 39], key[41:47], key[49:55], key[57:63]
		   }; 

always @(K1 or K2 or K3 or K4 or K5 or K6 or K7 or K8 or K9 or K10
              or K11 or K12 or K13 or K14 or K15 or K16 or round)
	case (round)		// synopsys full_case parallel_case
            0:  K_sub = K1;
            1:  K_sub = K2;
            2:  K_sub = K3;
            3:  K_sub = K4;
            4:  K_sub = K5;
            5:  K_sub = K6;
            6:  K_sub = K7;
            7:  K_sub = K8;
            8:  K_sub = K9;
            9:  K_sub = K10;
            10: K_sub = K11;
            11: K_sub = K12;
            12: K_sub = K13;
            13: K_sub = K14;
            14: K_sub = K15;
            15: K_sub = K16;
	endcase

 
assign K1[1] = K[47];
assign K1[2] = K[11];
assign K1[3] = K[26];
assign K1[4] = K[3];
assign K1[5] = K[13];
assign K1[6] = K[41];
assign K1[7] = K[27];
assign K1[8] = K[6];
assign K1[9] = K[54];
assign K1[10] = K[48];
assign K1[11] = K[39];
assign K1[12] = K[19];
assign K1[13] = K[53];
assign K1[14] = K[25];
assign K1[15] = K[33];
assign K1[16] = K[34];
assign K1[17] = K[17];
assign K1[18] = K[5];
assign K1[19] = K[4];
assign K1[20] = K[55];
assign K1[21] = K[24];
assign K1[22] = K[32];
assign K1[23] = K[40];
assign K1[24] = K[20];
assign K1[25] = K[36];
assign K1[26] = K[31];
assign K1[27] = K[21];
assign K1[28] = K[8];
assign K1[29] = K[23];
assign K1[30] = K[52];
assign K1[31] = K[14];
assign K1[32] = K[29];
assign K1[33] = K[51];
assign K1[34] = K[9];
assign K1[35] = K[35];
assign K1[36] = K[30];
assign K1[37] = K[2];
assign K1[38] = K[37];
assign K1[39] = K[22];
assign K1[40] = K[0];
assign K1[41] = K[42];
assign K1[42] = K[38];
assign K1[43] = K[16];
assign K1[44] = K[43];
assign K1[45] = K[44];
assign K1[46] = K[1];
assign K1[47] = K[7];
assign K1[48] = K[28];
assign K2[1] = K[54];
assign K2[2] = K[18];
assign K2[3] = K[33];
assign K2[4] = K[10];
assign K2[5] = K[20];
assign K2[6] = K[48];
assign K2[7] = K[34];
assign K2[8] = K[13];
assign K2[9] = K[4];
assign K2[10] = K[55];
assign K2[11] = K[46];
assign K2[12] = K[26];
assign K2[13] = K[3];
assign K2[14] = K[32];
assign K2[15] = K[40];
assign K2[16] = K[41];
assign K2[17] = K[24];
assign K2[18] = K[12];
assign K2[19] = K[11];
assign K2[20] = K[5];
assign K2[21] = K[6];
assign K2[22] = K[39];
assign K2[23] = K[47];
assign K2[24] = K[27];
assign K2[25] = K[43];
assign K2[26] = K[38];
assign K2[27] = K[28];
assign K2[28] = K[15];
assign K2[29] = K[30];
assign K2[30] = K[0];
assign K2[31] = K[21];
assign K2[32] = K[36];
assign K2[33] = K[31];
assign K2[34] = K[16];
assign K2[35] = K[42];
assign K2[36] = K[37];
assign K2[37] = K[9];
assign K2[38] = K[44];
assign K2[39] = K[29];
assign K2[40] = K[7];
assign K2[41] = K[49];
assign K2[42] = K[45];
assign K2[43] = K[23];
assign K2[44] = K[50];
assign K2[45] = K[51];
assign K2[46] = K[8];
assign K2[47] = K[14];
assign K2[48] = K[35];
assign K3[1] = K[11];
assign K3[2] = K[32];
assign K3[3] = K[47];
assign K3[4] = K[24];
assign K3[5] = K[34];
assign K3[6] = K[5];
assign K3[7] = K[48];
assign K3[8] = K[27];
assign K3[9] = K[18];
assign K3[10] = K[12];
assign K3[11] = K[3];
assign K3[12] = K[40];
assign K3[13] = K[17];
assign K3[14] = K[46];
assign K3[15] = K[54];
assign K3[16] = K[55];
assign K3[17] = K[13];
assign K3[18] = K[26];
assign K3[19] = K[25];
assign K3[20] = K[19];
assign K3[21] = K[20];
assign K3[22] = K[53];
assign K3[23] = K[4];
assign K3[24] = K[41];
assign K3[25] = K[2];
assign K3[26] = K[52];
assign K3[27] = K[42];
assign K3[28] = K[29];
assign K3[29] = K[44];
assign K3[30] = K[14];
assign K3[31] = K[35];
assign K3[32] = K[50];
assign K3[33] = K[45];
assign K3[34] = K[30];
assign K3[35] = K[1];
assign K3[36] = K[51];
assign K3[37] = K[23];
assign K3[38] = K[31];
assign K3[39] = K[43];
assign K3[40] = K[21];
assign K3[41] = K[8];
assign K3[42] = K[0];
assign K3[43] = K[37];
assign K3[44] = K[9];
assign K3[45] = K[38];
assign K3[46] = K[22];
assign K3[47] = K[28];
assign K3[48] = K[49];
assign K4[1] = K[25];
assign K4[2] = K[46];
assign K4[3] = K[4];
assign K4[4] = K[13];
assign K4[5] = K[48];
assign K4[6] = K[19];
assign K4[7] = K[5];
assign K4[8] = K[41];
assign K4[9] = K[32];
assign K4[10] = K[26];
assign K4[11] = K[17];
assign K4[12] = K[54];
assign K4[13] = K[6];
assign K4[14] = K[3];
assign K4[15] = K[11];
assign K4[16] = K[12];
assign K4[17] = K[27];
assign K4[18] = K[40];
assign K4[19] = K[39];
assign K4[20] = K[33];
assign K4[21] = K[34];
assign K4[22] = K[10];
assign K4[23] = K[18];
assign K4[24] = K[55];
assign K4[25] = K[16];
assign K4[26] = K[7];
assign K4[27] = K[1];
assign K4[28] = K[43];
assign K4[29] = K[31];
assign K4[30] = K[28];
assign K4[31] = K[49];
assign K4[32] = K[9];
assign K4[33] = K[0];
assign K4[34] = K[44];
assign K4[35] = K[15];
assign K4[36] = K[38];
assign K4[37] = K[37];
assign K4[38] = K[45];
assign K4[39] = K[2];
assign K4[40] = K[35];
assign K4[41] = K[22];
assign K4[42] = K[14];
assign K4[43] = K[51];
assign K4[44] = K[23];
assign K4[45] = K[52];
assign K4[46] = K[36];
assign K4[47] = K[42];
assign K4[48] = K[8];
assign K5[1] = K[39];
assign K5[2] = K[3];
assign K5[3] = K[18];
assign K5[4] = K[27];
assign K5[5] = K[5];
assign K5[6] = K[33];
assign K5[7] = K[19];
assign K5[8] = K[55];
assign K5[9] = K[46];
assign K5[10] = K[40];
assign K5[11] = K[6];
assign K5[12] = K[11];
assign K5[13] = K[20];
assign K5[14] = K[17];
assign K5[15] = K[25];
assign K5[16] = K[26];
assign K5[17] = K[41];
assign K5[18] = K[54];
assign K5[19] = K[53];
assign K5[20] = K[47];
assign K5[21] = K[48];
assign K5[22] = K[24];
assign K5[23] = K[32];
assign K5[24] = K[12];
assign K5[25] = K[30];
assign K5[26] = K[21];
assign K5[27] = K[15];
assign K5[28] = K[2];
assign K5[29] = K[45];
assign K5[30] = K[42];
assign K5[31] = K[8];
assign K5[32] = K[23];
assign K5[33] = K[14];
assign K5[34] = K[31];
assign K5[35] = K[29];
assign K5[36] = K[52];
assign K5[37] = K[51];
assign K5[38] = K[0];
assign K5[39] = K[16];
assign K5[40] = K[49];
assign K5[41] = K[36];
assign K5[42] = K[28];
assign K5[43] = K[38];
assign K5[44] = K[37];
assign K5[45] = K[7];
assign K5[46] = K[50];
assign K5[47] = K[1];
assign K5[48] = K[22];
assign K6[1] = K[53];
assign K6[2] = K[17];
assign K6[3] = K[32];
assign K6[4] = K[41];
assign K6[5] = K[19];
assign K6[6] = K[47];
assign K6[7] = K[33];
assign K6[8] = K[12];
assign K6[9] = K[3];
assign K6[10] = K[54];
assign K6[11] = K[20];
assign K6[12] = K[25];
assign K6[13] = K[34];
assign K6[14] = K[6];
assign K6[15] = K[39];
assign K6[16] = K[40];
assign K6[17] = K[55];
assign K6[18] = K[11];
assign K6[19] = K[10];
assign K6[20] = K[4];
assign K6[21] = K[5];
assign K6[22] = K[13];
assign K6[23] = K[46];
assign K6[24] = K[26];
assign K6[25] = K[44];
assign K6[26] = K[35];
assign K6[27] = K[29];
assign K6[28] = K[16];
assign K6[29] = K[0];
assign K6[30] = K[1];
assign K6[31] = K[22];
assign K6[32] = K[37];
assign K6[33] = K[28];
assign K6[34] = K[45];
assign K6[35] = K[43];
assign K6[36] = K[7];
assign K6[37] = K[38];
assign K6[38] = K[14];
assign K6[39] = K[30];
assign K6[40] = K[8];
assign K6[41] = K[50];
assign K6[42] = K[42];
assign K6[43] = K[52];
assign K6[44] = K[51];
assign K6[45] = K[21];
assign K6[46] = K[9];
assign K6[47] = K[15];
assign K6[48] = K[36];
assign K7[1] = K[10];
assign K7[2] = K[6];
assign K7[3] = K[46];
assign K7[4] = K[55];
assign K7[5] = K[33];
assign K7[6] = K[4];
assign K7[7] = K[47];
assign K7[8] = K[26];
assign K7[9] = K[17];
assign K7[10] = K[11];
assign K7[11] = K[34];
assign K7[12] = K[39];
assign K7[13] = K[48];
assign K7[14] = K[20];
assign K7[15] = K[53];
assign K7[16] = K[54];
assign K7[17] = K[12];
assign K7[18] = K[25];
assign K7[19] = K[24];
assign K7[20] = K[18];
assign K7[21] = K[19];
assign K7[22] = K[27];
assign K7[23] = K[3];
assign K7[24] = K[40];
assign K7[25] = K[31];
assign K7[26] = K[49];
assign K7[27] = K[43];
assign K7[28] = K[30];
assign K7[29] = K[14];
assign K7[30] = K[15];
assign K7[31] = K[36];
assign K7[32] = K[51];
assign K7[33] = K[42];
assign K7[34] = K[0];
assign K7[35] = K[2];
assign K7[36] = K[21];
assign K7[37] = K[52];
assign K7[38] = K[28];
assign K7[39] = K[44];
assign K7[40] = K[22];
assign K7[41] = K[9];
assign K7[42] = K[1];
assign K7[43] = K[7];
assign K7[44] = K[38];
assign K7[45] = K[35];
assign K7[46] = K[23];
assign K7[47] = K[29];
assign K7[48] = K[50];
assign K8[1] = K[24];
assign K8[2] = K[20];
assign K8[3] = K[3];
assign K8[4] = K[12];
assign K8[5] = K[47];
assign K8[6] = K[18];
assign K8[7] = K[4];
assign K8[8] = K[40];
assign K8[9] = K[6];
assign K8[10] = K[25];
assign K8[11] = K[48];
assign K8[12] = K[53];
assign K8[13] = K[5];
assign K8[14] = K[34];
assign K8[15] = K[10];
assign K8[16] = K[11];
assign K8[17] = K[26];
assign K8[18] = K[39];
assign K8[19] = K[13];
assign K8[20] = K[32];
assign K8[21] = K[33];
assign K8[22] = K[41];
assign K8[23] = K[17];
assign K8[24] = K[54];
assign K8[25] = K[45];
assign K8[26] = K[8];
assign K8[27] = K[2];
assign K8[28] = K[44];
assign K8[29] = K[28];
assign K8[30] = K[29];
assign K8[31] = K[50];
assign K8[32] = K[38];
assign K8[33] = K[1];
assign K8[34] = K[14];
assign K8[35] = K[16];
assign K8[36] = K[35];
assign K8[37] = K[7];
assign K8[38] = K[42];
assign K8[39] = K[31];
assign K8[40] = K[36];
assign K8[41] = K[23];
assign K8[42] = K[15];
assign K8[43] = K[21];
assign K8[44] = K[52];
assign K8[45] = K[49];
assign K8[46] = K[37];
assign K8[47] = K[43];
assign K8[48] = K[9];
assign K9[1] = K[6];
assign K9[2] = K[27];
assign K9[3] = K[10];
assign K9[4] = K[19];
assign K9[5] = K[54];
assign K9[6] = K[25];
assign K9[7] = K[11];
assign K9[8] = K[47];
assign K9[9] = K[13];
assign K9[10] = K[32];
assign K9[11] = K[55];
assign K9[12] = K[3];
assign K9[13] = K[12];
assign K9[14] = K[41];
assign K9[15] = K[17];
assign K9[16] = K[18];
assign K9[17] = K[33];
assign K9[18] = K[46];
assign K9[19] = K[20];
assign K9[20] = K[39];
assign K9[21] = K[40];
assign K9[22] = K[48];
assign K9[23] = K[24];
assign K9[24] = K[4];
assign K9[25] = K[52];
assign K9[26] = K[15];
assign K9[27] = K[9];
assign K9[28] = K[51];
assign K9[29] = K[35];
assign K9[30] = K[36];
assign K9[31] = K[2];
assign K9[32] = K[45];
assign K9[33] = K[8];
assign K9[34] = K[21];
assign K9[35] = K[23];
assign K9[36] = K[42];
assign K9[37] = K[14];
assign K9[38] = K[49];
assign K9[39] = K[38];
assign K9[40] = K[43];
assign K9[41] = K[30];
assign K9[42] = K[22];
assign K9[43] = K[28];
assign K9[44] = K[0];
assign K9[45] = K[1];
assign K9[46] = K[44];
assign K9[47] = K[50];
assign K9[48] = K[16];
assign K10[1] = K[20];
assign K10[2] = K[41];
assign K10[3] = K[24];
assign K10[4] = K[33];
assign K10[5] = K[11];
assign K10[6] = K[39];
assign K10[7] = K[25];
assign K10[8] = K[4];
assign K10[9] = K[27];
assign K10[10] = K[46];
assign K10[11] = K[12];
assign K10[12] = K[17];
assign K10[13] = K[26];
assign K10[14] = K[55];
assign K10[15] = K[6];
assign K10[16] = K[32];
assign K10[17] = K[47];
assign K10[18] = K[3];
assign K10[19] = K[34];
assign K10[20] = K[53];
assign K10[21] = K[54];
assign K10[22] = K[5];
assign K10[23] = K[13];
assign K10[24] = K[18];
assign K10[25] = K[7];
assign K10[26] = K[29];
assign K10[27] = K[23];
assign K10[28] = K[38];
assign K10[29] = K[49];
assign K10[30] = K[50];
assign K10[31] = K[16];
assign K10[32] = K[0];
assign K10[33] = K[22];
assign K10[34] = K[35];
assign K10[35] = K[37];
assign K10[36] = K[1];
assign K10[37] = K[28];
assign K10[38] = K[8];
assign K10[39] = K[52];
assign K10[40] = K[2];
assign K10[41] = K[44];
assign K10[42] = K[36];
assign K10[43] = K[42];
assign K10[44] = K[14];
assign K10[45] = K[15];
assign K10[46] = K[31];
assign K10[47] = K[9];
assign K10[48] = K[30];
assign K11[1] = K[34];
assign K11[2] = K[55];
assign K11[3] = K[13];
assign K11[4] = K[47];
assign K11[5] = K[25];
assign K11[6] = K[53];
assign K11[7] = K[39];
assign K11[8] = K[18];
assign K11[9] = K[41];
assign K11[10] = K[3];
assign K11[11] = K[26];
assign K11[12] = K[6];
assign K11[13] = K[40];
assign K11[14] = K[12];
assign K11[15] = K[20];
assign K11[16] = K[46];
assign K11[17] = K[4];
assign K11[18] = K[17];
assign K11[19] = K[48];
assign K11[20] = K[10];
assign K11[21] = K[11];
assign K11[22] = K[19];
assign K11[23] = K[27];
assign K11[24] = K[32];
assign K11[25] = K[21];
assign K11[26] = K[43];
assign K11[27] = K[37];
assign K11[28] = K[52];
assign K11[29] = K[8];
assign K11[30] = K[9];
assign K11[31] = K[30];
assign K11[32] = K[14];
assign K11[33] = K[36];
assign K11[34] = K[49];
assign K11[35] = K[51];
assign K11[36] = K[15];
assign K11[37] = K[42];
assign K11[38] = K[22];
assign K11[39] = K[7];
assign K11[40] = K[16];
assign K11[41] = K[31];
assign K11[42] = K[50];
assign K11[43] = K[1];
assign K11[44] = K[28];
assign K11[45] = K[29];
assign K11[46] = K[45];
assign K11[47] = K[23];
assign K11[48] = K[44];
assign K12[1] = K[48];
assign K12[2] = K[12];
assign K12[3] = K[27];
assign K12[4] = K[4];
assign K12[5] = K[39];
assign K12[6] = K[10];
assign K12[7] = K[53];
assign K12[8] = K[32];
assign K12[9] = K[55];
assign K12[10] = K[17];
assign K12[11] = K[40];
assign K12[12] = K[20];
assign K12[13] = K[54];
assign K12[14] = K[26];
assign K12[15] = K[34];
assign K12[16] = K[3];
assign K12[17] = K[18];
assign K12[18] = K[6];
assign K12[19] = K[5];
assign K12[20] = K[24];
assign K12[21] = K[25];
assign K12[22] = K[33];
assign K12[23] = K[41];
assign K12[24] = K[46];
assign K12[25] = K[35];
assign K12[26] = K[2];
assign K12[27] = K[51];
assign K12[28] = K[7];
assign K12[29] = K[22];
assign K12[30] = K[23];
assign K12[31] = K[44];
assign K12[32] = K[28];
assign K12[33] = K[50];
assign K12[34] = K[8];
assign K12[35] = K[38];
assign K12[36] = K[29];
assign K12[37] = K[1];
assign K12[38] = K[36];
assign K12[39] = K[21];
assign K12[40] = K[30];
assign K12[41] = K[45];
assign K12[42] = K[9];
assign K12[43] = K[15];
assign K12[44] = K[42];
assign K12[45] = K[43];
assign K12[46] = K[0];
assign K12[47] = K[37];
assign K12[48] = K[31];
assign K13[1] = K[5];
assign K13[2] = K[26];
assign K13[3] = K[41];
assign K13[4] = K[18];
assign K13[5] = K[53];
assign K13[6] = K[24];
assign K13[7] = K[10];
assign K13[8] = K[46];
assign K13[9] = K[12];
assign K13[10] = K[6];
assign K13[11] = K[54];
assign K13[12] = K[34];
assign K13[13] = K[11];
assign K13[14] = K[40];
assign K13[15] = K[48];
assign K13[16] = K[17];
assign K13[17] = K[32];
assign K13[18] = K[20];
assign K13[19] = K[19];
assign K13[20] = K[13];
assign K13[21] = K[39];
assign K13[22] = K[47];
assign K13[23] = K[55];
assign K13[24] = K[3];
assign K13[25] = K[49];
assign K13[26] = K[16];
assign K13[27] = K[38];
assign K13[28] = K[21];
assign K13[29] = K[36];
assign K13[30] = K[37];
assign K13[31] = K[31];
assign K13[32] = K[42];
assign K13[33] = K[9];
assign K13[34] = K[22];
assign K13[35] = K[52];
assign K13[36] = K[43];
assign K13[37] = K[15];
assign K13[38] = K[50];
assign K13[39] = K[35];
assign K13[40] = K[44];
assign K13[41] = K[0];
assign K13[42] = K[23];
assign K13[43] = K[29];
assign K13[44] = K[1];
assign K13[45] = K[2];
assign K13[46] = K[14];
assign K13[47] = K[51];
assign K13[48] = K[45];
assign K14[1] = K[19];
assign K14[2] = K[40];
assign K14[3] = K[55];
assign K14[4] = K[32];
assign K14[5] = K[10];
assign K14[6] = K[13];
assign K14[7] = K[24];
assign K14[8] = K[3];
assign K14[9] = K[26];
assign K14[10] = K[20];
assign K14[11] = K[11];
assign K14[12] = K[48];
assign K14[13] = K[25];
assign K14[14] = K[54];
assign K14[15] = K[5];
assign K14[16] = K[6];
assign K14[17] = K[46];
assign K14[18] = K[34];
assign K14[19] = K[33];
assign K14[20] = K[27];
assign K14[21] = K[53];
assign K14[22] = K[4];
assign K14[23] = K[12];
assign K14[24] = K[17];
assign K14[25] = K[8];
assign K14[26] = K[30];
assign K14[27] = K[52];
assign K14[28] = K[35];
assign K14[29] = K[50];
assign K14[30] = K[51];
assign K14[31] = K[45];
assign K14[32] = K[1];
assign K14[33] = K[23];
assign K14[34] = K[36];
assign K14[35] = K[7];
assign K14[36] = K[2];
assign K14[37] = K[29];
assign K14[38] = K[9];
assign K14[39] = K[49];
assign K14[40] = K[31];
assign K14[41] = K[14];
assign K14[42] = K[37];
assign K14[43] = K[43];
assign K14[44] = K[15];
assign K14[45] = K[16];
assign K14[46] = K[28];
assign K14[47] = K[38];
assign K14[48] = K[0];
assign K15[1] = K[33];
assign K15[2] = K[54];
assign K15[3] = K[12];
assign K15[4] = K[46];
assign K15[5] = K[24];
assign K15[6] = K[27];
assign K15[7] = K[13];
assign K15[8] = K[17];
assign K15[9] = K[40];
assign K15[10] = K[34];
assign K15[11] = K[25];
assign K15[12] = K[5];
assign K15[13] = K[39];
assign K15[14] = K[11];
assign K15[15] = K[19];
assign K15[16] = K[20];
assign K15[17] = K[3];
assign K15[18] = K[48];
assign K15[19] = K[47];
assign K15[20] = K[41];
assign K15[21] = K[10];
assign K15[22] = K[18];
assign K15[23] = K[26];
assign K15[24] = K[6];
assign K15[25] = K[22];
assign K15[26] = K[44];
assign K15[27] = K[7];
assign K15[28] = K[49];
assign K15[29] = K[9];
assign K15[30] = K[38];
assign K15[31] = K[0];
assign K15[32] = K[15];
assign K15[33] = K[37];
assign K15[34] = K[50];
assign K15[35] = K[21];
assign K15[36] = K[16];
assign K15[37] = K[43];
assign K15[38] = K[23];
assign K15[39] = K[8];
assign K15[40] = K[45];
assign K15[41] = K[28];
assign K15[42] = K[51];
assign K15[43] = K[2];
assign K15[44] = K[29];
assign K15[45] = K[30];
assign K15[46] = K[42];
assign K15[47] = K[52];
assign K15[48] = K[14];
assign K16[1] = K[40];
assign K16[2] = K[4];
assign K16[3] = K[19];
assign K16[4] = K[53];
assign K16[5] = K[6];
assign K16[6] = K[34];
assign K16[7] = K[20];
assign K16[8] = K[24];
assign K16[9] = K[47];
assign K16[10] = K[41];
assign K16[11] = K[32];
assign K16[12] = K[12];
assign K16[13] = K[46];
assign K16[14] = K[18];
assign K16[15] = K[26];
assign K16[16] = K[27];
assign K16[17] = K[10];
assign K16[18] = K[55];
assign K16[19] = K[54];
assign K16[20] = K[48];
assign K16[21] = K[17];
assign K16[22] = K[25];
assign K16[23] = K[33];
assign K16[24] = K[13];
assign K16[25] = K[29];
assign K16[26] = K[51];
assign K16[27] = K[14];
assign K16[28] = K[1];
assign K16[29] = K[16];
assign K16[30] = K[45];
assign K16[31] = K[7];
assign K16[32] = K[22];
assign K16[33] = K[44];
assign K16[34] = K[2];
assign K16[35] = K[28];
assign K16[36] = K[23];
assign K16[37] = K[50];
assign K16[38] = K[30];
assign K16[39] = K[15];
assign K16[40] = K[52];
assign K16[41] = K[35];
assign K16[42] = K[31];
assign K16[43] = K[9];
assign K16[44] = K[36];
assign K16[45] = K[37];
assign K16[46] = K[49];
assign K16[47] = K[0];
assign K16[48] = K[21];


endmodule
