`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:12 12/10/2013 
// Design Name: 
// Module Name:    BK_SHIFT1 
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
module ARS_BK_SHIFT1 (b1_out,
                  b1_in
                  );

parameter BWIDTH=32;

output [0:BWIDTH-1] b1_out;
reg    [0:BWIDTH-1] b1_out;
input  [0:BWIDTH-1] b1_in;

always @ (b1_in)
   begin : shift
     b1_out[0]=b1_in[13];
     b1_out[1]=b1_in[14];
     b1_out[2]=b1_in[15];
     b1_out[3]=b1_in[16];
     b1_out[4]=b1_in[17];
     b1_out[5]=b1_in[18];
     b1_out[6]=b1_in[19];
     b1_out[7]=b1_in[20];
     b1_out[8]=b1_in[21];
     b1_out[9]=b1_in[22];
     b1_out[10]=b1_in[23];
     b1_out[11]=b1_in[24];
     b1_out[12]=b1_in[25];
     b1_out[13]=b1_in[26];
     b1_out[14]=b1_in[27];
     b1_out[15]=b1_in[28];
     b1_out[16]=b1_in[29];
     b1_out[17]=b1_in[30];
     b1_out[18]=b1_in[31];
     b1_out[19]=b1_in[0];
     b1_out[20]=b1_in[1];
     b1_out[21]=b1_in[2];
     b1_out[22]=b1_in[3];
     b1_out[23]=b1_in[4];
     b1_out[24]=b1_in[5];
     b1_out[25]=b1_in[6];
     b1_out[26]=b1_in[7];
     b1_out[27]=b1_in[8];
     b1_out[28]=b1_in[9];
     b1_out[29]=b1_in[10];
     b1_out[30]=b1_in[11];
     b1_out[31]=b1_in[12]; 
   end 
endmodule
