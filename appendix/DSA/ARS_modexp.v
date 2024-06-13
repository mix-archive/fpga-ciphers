`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:56 02/11/2014 
// Design Name: 
// Module Name:    modexp 
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
module ARS_modexp(indata, inExp, inMod, cypher, clk, ds, reset, ready);
   parameter            KEYSIZE = 32;
   input [KEYSIZE-1:0]  indata;
   input [KEYSIZE-1:0]  inExp;
   input [KEYSIZE-1:0]  inMod;
   output [KEYSIZE-1:0] cypher;
   reg [KEYSIZE-1:0]    cypher;
   input                clk;
   input                ds;
   input                reset;
   output               ready;
   
   
   reg [KEYSIZE-1:0]    modreg;
   reg [KEYSIZE-1:0]    root;
   wire [KEYSIZE-1:0]   square;
   reg [KEYSIZE-1:0]    sqrin;
   reg [KEYSIZE-1:0]    tempin;
   wire [KEYSIZE-1:0]   tempout;
   reg [KEYSIZE-1:0]    count;
   
   wire                 multrdy;
   wire                 sqrrdy;
   wire                 bothrdy;
   reg                  multgo;
   wire                 sqrgo;
   reg                  done;
   
   assign ready = done;
   assign bothrdy = multrdy & sqrrdy;
   
   
   ARS_modmult2 #(KEYSIZE) modmultiply(.mpand(tempin), .mplier(sqrin), .modulus(modreg), .product(tempout), .clk(clk), .ds(multgo), .reset(reset), .ready(multrdy));
   
   
   ARS_modmult2 #(KEYSIZE) modsqr(.mpand(root), .mplier(root), .modulus(modreg), .product(square), .clk(clk), .ds(multgo), .reset(reset), .ready(sqrrdy));
   
   
   always @(posedge clk)
   begin
      
      if (reset == 1'b1)
      begin
         count <= {KEYSIZE{1'b0}};
         done <= 1'b1;
      end
      else 
      begin
         if (done == 1'b1)
         begin
            if (ds == 1'b1)
            begin
               count <= {1'b0, inExp[KEYSIZE - 1:1]};
               done <= 1'b0;
            end
         end
         else if (count == 0)
         begin
            if (bothrdy == 1'b1 & multgo == 1'b0)
            begin
               cypher <= tempout;
               done <= 1'b1;
            end
         end
         else if (bothrdy == 1'b1)
         begin
            if (multgo == 1'b0)
               count <= {1'b0, count[KEYSIZE - 1:1]};
         end
      end
      
   end
   
   
   always @(posedge clk )
   begin
      
      if (reset == 1'b1)
      begin
         root <= {KEYSIZE{1'b0}};
         modreg <= {KEYSIZE{1'b0}};
      end
      else 
      begin
         if (done == 1'b1)
         begin
            if (ds == 1'b1)
            begin
               modreg <= inMod;
               root <= indata;
            end
         end
         else
            root <= square;
      end
      
   end
   
   
   always @(posedge clk )
   begin
      
      if (reset == 1'b1)
      begin
         tempin <= {KEYSIZE{1'b0}};
         sqrin <= {KEYSIZE{1'b0}};
         modreg <= {KEYSIZE{1'b0}};
      end
      else 
      begin
         if (done == 1'b1)
         begin
            if (ds == 1'b1)
            begin
               if (inExp[0] == 1'b1)
                  tempin <= indata;
               else
               begin
                  tempin[KEYSIZE - 1:1] <= {31{1'b0}};
                  tempin[0] <= 1'b1;
               end
               modreg <= inMod;
               sqrin[KEYSIZE - 1:1] <= {31{1'b0}};
               sqrin[0] <= 1'b1;
            end
         end
         else
         begin
            tempin <= tempout;
            if (count[0] == 1'b1)
               sqrin <= square;
            else
            begin
               sqrin[KEYSIZE - 1:1] <= {31{1'b0}};
               sqrin[0] <= 1'b1;
            end
         end
      end
      
   end
   
   
   always @(posedge clk )
   begin 
      
      if (reset == 1'b1)
         multgo <= 1'b0;
      else 
      begin
         if (done == 1'b1)
         begin
            if (ds == 1'b1)
               multgo <= 1'b1;
         end
         else if (count != 0)
         begin
            if (bothrdy == 1'b1)
               multgo <= 1'b1;
         end
         if (multgo == 1'b1)
            multgo <= 1'b0;
      end
      
   end
   
endmodule
