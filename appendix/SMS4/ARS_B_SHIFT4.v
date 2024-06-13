`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:42 12/10/2013 
// Design Name: 
// Module Name:    B_SHIFT4 
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
module ARS_B_SHIFT4 (b4_out,
                 b4_in
                 );
                 
parameter BWIDTH=32;

output [0:BWIDTH-1] b4_out;
reg    [0:BWIDTH-1] b4_out;
input  [0:BWIDTH-1] b4_in;
   
always @ (b4_in)
   begin : shift
     b4_out[0]=b4_in[24];
     b4_out[1]=b4_in[25];
     b4_out[2]=b4_in[26];
     b4_out[3]=b4_in[27];
     b4_out[4]=b4_in[28];
     b4_out[5]=b4_in[29];
     b4_out[6]=b4_in[30];
     b4_out[7]=b4_in[31];
     b4_out[8]=b4_in[0];
     b4_out[9]=b4_in[1];
     b4_out[10]=b4_in[2];
     b4_out[11]=b4_in[3];
     b4_out[12]=b4_in[4];
     b4_out[13]=b4_in[5];
     b4_out[14]=b4_in[6];
     b4_out[15]=b4_in[7];
     b4_out[16]=b4_in[8];
     b4_out[17]=b4_in[9];
     b4_out[18]=b4_in[10];
     b4_out[19]=b4_in[11];
     b4_out[20]=b4_in[12];
     b4_out[21]=b4_in[13];
     b4_out[22]=b4_in[14];
     b4_out[23]=b4_in[15];
     b4_out[24]=b4_in[16];
     b4_out[25]=b4_in[17];
     b4_out[26]=b4_in[18];
     b4_out[27]=b4_in[19];
     b4_out[28]=b4_in[20];
     b4_out[29]=b4_in[21];
     b4_out[30]=b4_in[22];
     b4_out[31]=b4_in[23];
   end
endmodule