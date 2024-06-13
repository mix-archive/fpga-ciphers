`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:22 02/11/2014 
// Design Name: 
// Module Name:    DSASign 
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
module ARS_DSASign(clk,en,p,q,Hm,x,g,k,r,s,r1,s1,s2,s3);
input [511:0] p,q,x;
input [511:0] g,k,Hm;
input clk,en;
output [511:0] r,s;
reg [511:0] r;
reg ds1,ds2,ds3;
reg reset1,reset2,reset3;
reg enb1,enb2;
wire [512:0] m;
output [511:0] r1,s1,s2,s3;
wire  ready1,ready2,ready3,ready4,ready5;
always @(posedge clk)
begin
 if(en==0)
   begin
   ds1 <=0;
   reset1 <=1;
   end
   else
    begin
	   ds1 <=1;
   reset1 <=0; 
    end
end
always @(posedge clk)
begin
 if(r1>q)
   r<=r1-q;
   else
   r<=r1;
  end
always @(posedge clk)
begin
 if(en==0)
   begin
   ds2 <=0;
   reset2 <=1;
   end
   else
    begin
	   ds2 <=1;
   reset2 <=0; 
    end
end  

always @(posedge clk)
begin
 if(en==0)
   begin
  enb2 <=0;
   end
   else
	    enb2 <=1; 
end
always @(posedge clk)
begin
 if(en==0)
   begin
   ds3 <=0;
   reset3 <=1;
   end
   else
    begin
	   ds3 <=1;
   reset3 <=0; 
    end
end 
assign m=s1+Hm;
assign s2=m>q?m-q:m;
ARS_modexp  #(512) modexp(.indata(g),.inExp(k),.inMod(p), .cypher(r1), .clk(clk), .ds(ds1), .reset(reset1), .ready(ready1));
ARS_modmult1 #(512) modmult1(.mpand(r), .mplier(x), .modulus(q), .product(s1), .clk(clk), .ds(ds2), .reset(reset2), .ready(ready2));
//modadd  #(512)  modadd(.a(Hm),.b(s1), .p(q),.clk(clk), .en(enb1), .rdy(ready3), .c(s2));
ARS_modinv #(512)  modinv(.a(k), .p(q),.clk(clk), .en(enb2), .rdy(ready4), .b(s3));
ARS_modmult1 #(512) modmult2(.mpand(s2), .mplier(s3), .modulus(q), .product(s), .clk(clk), .ds(ds3), .reset(reset3), .ready(ready5));
endmodule