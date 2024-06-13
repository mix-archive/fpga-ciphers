`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:27:47 02/11/2014 
// Design Name: 
// Module Name:    modmult2 
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
module ARS_modmult2(mpand, mplier, modulus, product, clk, ds, reset, ready);
   parameter          MPWID = 32;
   input [MPWID-1:0]  mpand;
   input [MPWID-1:0]  mplier;
   input [MPWID-1:0]  modulus;
   output [MPWID-1:0] product;
   input              clk;
   input              ds;
   input              reset;
   output             ready;
   
   reg [MPWID-1:0]    mpreg;
   reg [MPWID+1:0]    mcreg;
   wire [MPWID+1:0]   mcreg1;
   wire [MPWID+1:0]   mcreg2;
   reg [MPWID+1:0]    modreg1;
   reg [MPWID+1:0]    modreg2;
   reg [MPWID+1:0]    prodreg;
   wire [MPWID+1:0]   prodreg1;
   wire [MPWID+1:0]   prodreg2;
   wire [MPWID+1:0]   prodreg3;
   wire [MPWID+1:0]   prodreg4;
   
   wire [1:0]         modstate;
   reg                first;
   
   assign product = prodreg4[MPWID - 1:0];
   
   assign prodreg1 = (mpreg[0] == 1'b1) ? prodreg + mcreg : 
                     prodreg;
   assign prodreg2 = prodreg1 - modreg1;
   assign prodreg3 = prodreg1 - modreg2;
   
   assign modstate = {prodreg3[MPWID + 1], prodreg2[MPWID + 1]};
   
   assign prodreg4 = (modstate == 2'b11) ? prodreg1 : 
                     (modstate == 2'b10) ? prodreg2 : 
                     prodreg3;
   assign mcreg1 = mcreg - modreg1;
   
   assign mcreg2 = (mcreg1[MPWID] == 1'b1) ? mcreg : 
                   mcreg1;
   assign ready = first;
   
   
   always @(posedge clk )
   begin: combine
      
      if (reset == 1'b1)
         first <= 1'b1;
      else 
      begin
         if (first == 1'b1)
         begin
            if (ds == 1'b1)
            begin
               mpreg <= mplier;
               mcreg <= {2'b00, mpand};
               modreg1 <= {2'b00, modulus};
               modreg2 <= {1'b0, modulus, 1'b0};
               prodreg <= {MPWID+2{1'b0}};
               first <= 1'b0;
            end
         end
         else
            if (mpreg == 0)
               first <= 1'b1;
            else
            begin
               mcreg <= {mcreg2[MPWID:0], 1'b0};
               mpreg <= {1'b0, mpreg[MPWID - 1:1]};
               prodreg <= prodreg4;
            end
      end
      
   end
   
endmodule