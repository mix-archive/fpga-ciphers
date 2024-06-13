`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:47 12/10/2013 
// Design Name: 
// Module Name:    B_SHIFT3 
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
module ARS_B_SHIFT3 (b3_out,
                 b3_in
                 );
                 
parameter BWIDTH=32;

output [0:BWIDTH-1] b3_out;
reg    [0:BWIDTH-1] b3_out;
input  [0:BWIDTH-1] b3_in;

always @ (b3_in)
   begin : shift
     b3_out[0]=b3_in[18];
     b3_out[1]=b3_in[19];
     b3_out[2]=b3_in[20];
     b3_out[3]=b3_in[21];
     b3_out[4]=b3_in[22];
     b3_out[5]=b3_in[23];
     b3_out[6]=b3_in[24];
     b3_out[7]=b3_in[25];
     b3_out[8]=b3_in[26];
     b3_out[9]=b3_in[27];
     b3_out[10]=b3_in[28];
     b3_out[11]=b3_in[29];
     b3_out[12]=b3_in[30];
     b3_out[13]=b3_in[31];
     b3_out[14]=b3_in[0];
     b3_out[15]=b3_in[1];
     b3_out[16]=b3_in[2];
     b3_out[17]=b3_in[3];
     b3_out[18]=b3_in[4];
     b3_out[19]=b3_in[5];
     b3_out[20]=b3_in[6];
     b3_out[21]=b3_in[7];
     b3_out[22]=b3_in[8];
     b3_out[23]=b3_in[9];
     b3_out[24]=b3_in[10];
     b3_out[25]=b3_in[11];
     b3_out[26]=b3_in[12];
     b3_out[27]=b3_in[13];
     b3_out[28]=b3_in[14];
     b3_out[29]=b3_in[15];
     b3_out[30]=b3_in[16];
     b3_out[31]=b3_in[17];
   end
endmodule
