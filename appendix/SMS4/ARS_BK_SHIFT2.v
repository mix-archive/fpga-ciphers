`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:03 12/10/2013 
// Design Name: 
// Module Name:    BK_SHIFT2 
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
module ARS_BK_SHIFT2 (b2_out,
                  b2_in
                  );

parameter BWIDTH=32;

output [0:BWIDTH-1] b2_out;
reg    [0:BWIDTH-1] b2_out;
input  [0:BWIDTH-1] b2_in; 
         
always @ (b2_in)
   begin : shift
     b2_out[0]=b2_in[23];
     b2_out[1]=b2_in[24];
     b2_out[2]=b2_in[25];
     b2_out[3]=b2_in[26];
     b2_out[4]=b2_in[27];
     b2_out[5]=b2_in[28];
     b2_out[6]=b2_in[29];
     b2_out[7]=b2_in[30];
     b2_out[8]=b2_in[31];
     b2_out[9]=b2_in[0];
     b2_out[10]=b2_in[1];
     b2_out[11]=b2_in[2];
     b2_out[12]=b2_in[3];
     b2_out[13]=b2_in[4];
     b2_out[14]=b2_in[5];
     b2_out[15]=b2_in[6];
     b2_out[16]=b2_in[7];
     b2_out[17]=b2_in[8];
     b2_out[18]=b2_in[9];
     b2_out[19]=b2_in[10];
     b2_out[20]=b2_in[11];
     b2_out[21]=b2_in[12];
     b2_out[22]=b2_in[13];
     b2_out[23]=b2_in[14];
     b2_out[24]=b2_in[15];
     b2_out[25]=b2_in[16];
     b2_out[26]=b2_in[17];
     b2_out[27]=b2_in[18];
     b2_out[28]=b2_in[19];
     b2_out[29]=b2_in[20];
     b2_out[30]=b2_in[21];
     b2_out[31]=b2_in[22]; 
   end 
endmodule