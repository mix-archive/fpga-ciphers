`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:19 12/10/2013 
// Design Name: 
// Module Name:    sbox 
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
module ARS_sbox(sout,sin);

output [0:7] sout;
input  [0:7] sin;
reg    [0:7] sout;

always @(sin)
 case({sin[4:7],sin[0:3]})
   8'h00:  sout= 8'hd6;
   8'h10:  sout= 8'h90;
   8'h20:  sout= 8'he9;
   8'h30:  sout= 8'hfe;
   8'h40:  sout= 8'hcc;
   8'h50:  sout= 8'he1;
   8'h60:  sout= 8'h3d;
   8'h70:  sout= 8'hb7;
   8'h80:  sout= 8'h16;
   8'h90:  sout= 8'hb6;
   8'ha0:  sout= 8'h14;
   8'hb0:  sout= 8'hc2;
   8'hc0:  sout= 8'h28;
   8'hd0:  sout= 8'hfd;
   8'he0:  sout= 8'h2c;
   8'hf0:  sout= 8'h05;
    
   8'h01:  sout= 8'h2b;
   8'h11:  sout= 8'h67;
   8'h21:  sout= 8'h9a;
   8'h31:  sout= 8'h76;
   8'h41:  sout= 8'h2a;
   8'h51:  sout= 8'hbe;
   8'h61:  sout= 8'h04;
   8'h71:  sout= 8'hc3;
   8'h81:  sout= 8'haa;
   8'h91:  sout= 8'h44;
   8'ha1:  sout= 8'h13;
   8'hb1:  sout= 8'h26;
   8'hc1:  sout= 8'h49;
   8'hd1:  sout= 8'h86;
   8'he1:  sout= 8'h06;
   8'hf1:  sout= 8'h99;
    
   8'h02:  sout= 8'h9c;
   8'h12:  sout= 8'h42;
   8'h22:  sout= 8'h50;
   8'h32:  sout= 8'hf4;
   8'h42:  sout= 8'h91;
   8'h52:  sout= 8'hef;
   8'h62:  sout= 8'h98;
   8'h72:  sout= 8'h7a;
   8'h82:  sout= 8'h33;
   8'h92:  sout= 8'h54;
   8'ha2:  sout= 8'h0b;
   8'hb2:  sout= 8'h43;
   8'hc2:  sout= 8'hed;
   8'hd2:  sout= 8'hcf;
   8'he2:  sout= 8'hac;
   8'hf2:  sout= 8'h62;
    
   8'h03:  sout= 8'he4;
   8'h13:  sout= 8'hb3;
   8'h23:  sout= 8'h1c;
   8'h33:  sout= 8'ha9;
   8'h43:  sout= 8'hc9;
   8'h53:  sout= 8'h08;
   8'h63:  sout= 8'he8;
   8'h73:  sout= 8'h95;
   8'h83:  sout= 8'h80;
   8'h93:  sout= 8'hdf;
   8'ha3:  sout= 8'h94;
   8'hb3:  sout= 8'hfa;
   8'hc3:  sout= 8'h75;
   8'hd3:  sout= 8'h8f;
   8'he3:  sout= 8'h3f;
   8'hf3:  sout= 8'ha6;
    
   8'h04:  sout= 8'h47;
   8'h14:  sout= 8'h07;
   8'h24:  sout= 8'ha7;
   8'h34:  sout= 8'hfc;
   8'h44:  sout= 8'hf3;
   8'h54:  sout= 8'h73;
   8'h64:  sout= 8'h17;
   8'h74:  sout= 8'hba;
   8'h84:  sout= 8'h83;
   8'h94:  sout= 8'h59;
   8'ha4:  sout= 8'h3c;
   8'hb4:  sout= 8'h19;
   8'hc4:  sout= 8'he6;
   8'hd4:  sout= 8'h85;
   8'he4:  sout= 8'h4f;
   8'hf4:  sout= 8'ha8;
    
   8'h05:  sout= 8'h68;
   8'h15:  sout= 8'h6b;
   8'h25:  sout= 8'h81;
   8'h35:  sout= 8'hb2;
   8'h45:  sout= 8'h71;
   8'h55:  sout= 8'h64;
   8'h65:  sout= 8'hda;
   8'h75:  sout= 8'h8b;
   8'h85:  sout= 8'hf8;
   8'h95:  sout= 8'heb;
   8'ha5:  sout= 8'h0f;
   8'hb5:  sout= 8'h4b;
   8'hc5:  sout= 8'h70;
   8'hd5:  sout= 8'h56;
   8'he5:  sout= 8'h9d;
   8'hf5:  sout= 8'h35;
    
   8'h06:  sout= 8'h1e;
   8'h16:  sout= 8'h24;
   8'h26:  sout= 8'h0e;
   8'h36:  sout= 8'h5e;
   8'h46:  sout= 8'h63;
   8'h56:  sout= 8'h58;
   8'h66:  sout= 8'hd1;
   8'h76:  sout= 8'ha2;
   8'h86:  sout= 8'h25;
   8'h96:  sout= 8'h22;
   8'ha6:  sout= 8'h7c;
   8'hb6:  sout= 8'h3b;
   8'hc6:  sout= 8'h01;
   8'hd6:  sout= 8'h21;
   8'he6:  sout= 8'h78;
   8'hf6:  sout= 8'h87;
    
   8'h07:  sout= 8'hd4;
   8'h17:  sout= 8'h00;
   8'h27:  sout= 8'h46;
   8'h37:  sout= 8'h57;
   8'h47:  sout= 8'h9f;
   8'h57:  sout= 8'hd3;
   8'h67:  sout= 8'h27;
   8'h77:  sout= 8'h52;
   8'h87:  sout= 8'h4c;
   8'h97:  sout= 8'h36;
   8'ha7:  sout= 8'h02;
   8'hb7:  sout= 8'he7;
   8'hc7:  sout= 8'ha0;
   8'hd7:  sout= 8'hc4;
   8'he7:  sout= 8'hc8;
   8'hf7:  sout= 8'h9e;
    
   8'h08:  sout= 8'hea;
   8'h18:  sout= 8'hbf;
   8'h28:  sout= 8'h8a;
   8'h38:  sout= 8'hd2;
   8'h48:  sout= 8'h40;
   8'h58:  sout= 8'hc7;
   8'h68:  sout= 8'h38;
   8'h78:  sout= 8'hb5;
   8'h88:  sout= 8'ha3;
   8'h98:  sout= 8'hf7;
   8'ha8:  sout= 8'hf2;
   8'hb8:  sout= 8'hce;
   8'hc8:  sout= 8'hf9;
   8'hd8:  sout= 8'h61;
   8'he8:  sout= 8'h15;
   8'hf8:  sout= 8'ha1;
    
   8'h09:  sout= 8'he0;
   8'h19:  sout= 8'hae;
   8'h29:  sout= 8'h5d;
   8'h39:  sout= 8'ha4;
   8'h49:  sout= 8'h9b;
   8'h59:  sout= 8'h34;
   8'h69:  sout= 8'h1a;
   8'h79:  sout= 8'h55;
   8'h89:  sout= 8'had;
   8'h99:  sout= 8'h93;
   8'ha9:  sout= 8'h32;
   8'hb9:  sout= 8'h30;
   8'hc9:  sout= 8'hf5;
   8'hd9:  sout= 8'h8c;
   8'he9:  sout= 8'hb1;
   8'hf9:  sout= 8'he3;
    
   8'h0a:  sout= 8'h1d;
   8'h1a:  sout= 8'hf6;
   8'h2a:  sout= 8'he2;
   8'h3a:  sout= 8'h2e;
   8'h4a:  sout= 8'h82;
   8'h5a:  sout= 8'h66;
   8'h6a:  sout= 8'hca;
   8'h7a:  sout= 8'h60;
   8'h8a:  sout= 8'hc0;
   8'h9a:  sout= 8'h29;
   8'haa:  sout= 8'h23;
   8'hba:  sout= 8'hab;
   8'hca:  sout= 8'h0d;
   8'hda:  sout= 8'h53;
   8'hea:  sout= 8'h4e;
   8'hfa:  sout= 8'h6f;
    
   8'h0b:  sout= 8'hd5;
   8'h1b:  sout= 8'hdb;
   8'h2b:  sout= 8'h37;
   8'h3b:  sout= 8'h45;
   8'h4b:  sout= 8'hde;
   8'h5b:  sout= 8'hfd;
   8'h6b:  sout= 8'h8e;
   8'h7b:  sout= 8'h2f;
   8'h8b:  sout= 8'h03;
   8'h9b:  sout= 8'hff;
   8'hab:  sout= 8'h6a;
   8'hbb:  sout= 8'h72;
   8'hcb:  sout= 8'h6d;
   8'hdb:  sout= 8'h6c;
   8'heb:  sout= 8'h5b;
   8'hfb:  sout= 8'h51;
    
   8'h0c:  sout= 8'h8d;
   8'h1c:  sout= 8'h1b;
   8'h2c:  sout= 8'haf;
   8'h3c:  sout= 8'h92;
   8'h4c:  sout= 8'hbb;
   8'h5c:  sout= 8'hdd;
   8'h6c:  sout= 8'hbc;
   8'h7c:  sout= 8'h7f;
   8'h8c:  sout= 8'h11;
   8'h9c:  sout= 8'hd9;
   8'hac:  sout= 8'h5c;
   8'hbc:  sout= 8'h41;
   8'hcc:  sout= 8'h1f;
   8'hdc:  sout= 8'h10;
   8'hec:  sout= 8'h5a;
   8'hfc:  sout= 8'hd8;
    
   8'h0d:  sout= 8'h0a;
   8'h1d:  sout= 8'hc1;
   8'h2d:  sout= 8'h31;
   8'h3d:  sout= 8'h88;
   8'h4d:  sout= 8'ha5;
   8'h5d:  sout= 8'hcd;
   8'h6d:  sout= 8'h7b;
   8'h7d:  sout= 8'hbd;
   8'h8d:  sout= 8'h2d;
   8'h9d:  sout= 8'h74;
   8'had:  sout= 8'hd0;
   8'hbd:  sout= 8'h12;
   8'hcd:  sout= 8'hb8;
   8'hdd:  sout= 8'he5;
   8'hed:  sout= 8'hb4;
   8'hfd:  sout= 8'hb0;
    
   8'h0e:  sout= 8'h89;
   8'h1e:  sout= 8'h69;
   8'h2e:  sout= 8'h97;
   8'h3e:  sout= 8'h4a;
   8'h4e:  sout= 8'h0c;
   8'h5e:  sout= 8'h96;
   8'h6e:  sout= 8'h77;
   8'h7e:  sout= 8'h7e;
   8'h8e:  sout= 8'h65;
   8'h9e:  sout= 8'hb9;
   8'hae:  sout= 8'hf1;
   8'hbe:  sout= 8'h09;
   8'hce:  sout= 8'hc5;
   8'hde:  sout= 8'h6e;
   8'hee:  sout= 8'hc6;
   8'hfe:  sout= 8'h84;
    
   8'h0f:  sout= 8'h18;
   8'h1f:  sout= 8'hf0;
   8'h2f:  sout= 8'h7d;
   8'h3f:  sout= 8'hec;
   8'h4f:  sout= 8'h3a;
   8'h5f:  sout= 8'hdc;
   8'h6f:  sout= 8'h4d;
   8'h7f:  sout= 8'h20;
   8'h8f:  sout= 8'h79;
   8'h9f:  sout= 8'hee;
   8'haf:  sout= 8'h5f;
   8'hbf:  sout= 8'h3e;
   8'hcf:  sout= 8'hd7;
   8'hdf:  sout= 8'hcb;
   8'hef:  sout= 8'h39;
   8'hff:  sout= 8'h48;
  default:  sout= 8'h00;   
 endcase
endmodule 
