`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:38 12/10/2013 
// Design Name: 
// Module Name:    CK 
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
module ARS_CK (ck,
           counter);

output [0:31] ck;
input  [0:4] counter;

reg    [0:31] ck;
reg    [0:6] cou_3,cou_2,cou_1,cou_0;
reg    [0:9] ck_3,ck_2,ck_1,ck_0;
reg    [0:7] mod_3,mod_2,mod_1,mod_0;

always @ (counter)
  begin
    cou_0={counter,2'b0};
    cou_1=cou_0;
    cou_2=cou_0;
    cou_3=cou_0;
  end

always @ (cou_0 or cou_1 or cou_2 or cou_3)
  begin
    ck_0=({(cou_0+0),3'b0})-(cou_3+0);
    ck_1=({(cou_1+1),3'b0})-(cou_3+1);
    ck_2=({(cou_2+2),3'b0})-(cou_3+2);
    ck_3=({(cou_3+3),3'b0})-(cou_3+3);
  end
  
always @ (ck_3 or ck_2 or ck_1 or ck_0)
  begin
    mod_0=ck_0[2:9];
    mod_1=ck_1[2:9];
    mod_2=ck_2[2:9];
    mod_3=ck_3[2:9];
  end
  
always @ (mod_3 or mod_2 or mod_1 or mod_0)
  ck={mod_0,mod_1,mod_2,mod_3};

endmodule