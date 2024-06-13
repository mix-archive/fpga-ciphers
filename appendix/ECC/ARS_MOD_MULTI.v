`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:59 12/04/2013 
// Design Name: 
// Module Name:    MOD_MULTI 
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
module ARS_MOD_MULTI(
                      CLK,
                      RST_N,
                      DIN1,
                      DIN2,
                      IN_VALID,
                      DOUT,
							 cnt,
                      OUT_VALID
                  );



//-------------------------------------------------------------------
// parameter list
//-------------------------------------------------------------------
parameter  DELAY_CYC = 8'hE9; //233

//parameter  

//-------------------------------------------------------------------
// port list
//-------------------------------------------------------------------
//input
input             CLK;
input             RST_N;
input   [232:0]   DIN1;
input   [232:0]   DIN2;
input             IN_VALID;

// output
output  [232:0]   DOUT;
output            OUT_VALID;
output  [7:0]     cnt;


//-------------------------------------------------------------------
// type definition
//-------------------------------------------------------------------
reg     OUT_VALID;
reg     OUT_VALID_TMP;
reg     [7:0]     cnt;


reg     [232:0]   data_in1;
reg     [232:0]   data_in2;

reg     [232:0]   data_in2_bak;

reg     [232:0]   data_tmp;

reg     [232:0]   DOUT;


//-------------------------------------------------------------------
// function description
//------------------------------------------------------------------- 
always @(posedge CLK) begin
	 if(!RST_N) begin
	 	  data_in1[232:0] <= {233{1'b0}};
	    data_in2[232:0] <= {233{1'b0}};
	 end
	 else if(IN_VALID) begin
	 	  data_in1[232:0] <= DIN1[232:0];
      data_in2[232:0] <= DIN2[232:0];
   end
   else begin
	
      data_in1[232:0] <= {1'b0,{data_in1[232:1]}};
		
		data_in2[232:0] <= {{data_in2[231:0]},1'b0};			
		
		if(data_in2[231] == 1'b1) begin
			data_in2[1]  <= data_in2[1] ^ 1'b1;
			data_in2[75] <= data_in2[75] ^ 1'b1;
		end
   end
end




always @(posedge CLK) begin
	 if(IN_VALID) begin
      if(DIN1[0] == 1'b1)
         data_tmp <= DIN2; 
      else
         data_tmp <= {233{1'b0}};
   end      
   else begin	
   	  if(data_in1[1] == 1'b1)
   	     data_tmp <= data_tmp ^ {{data_in2[231:0]},1'b0};	//modify----
   	  else
   	     data_tmp <= data_tmp;		  
   end
end



always @(posedge CLK) begin
	 if(!RST_N)
	 	cnt <= 8'h00;
   else if(IN_VALID)
      cnt <= 8'h00;
   else
      cnt <= cnt + 1;
end



always @(posedge CLK)  //增加一级缓存输出
 if(!RST_N) begin
    OUT_VALID<=0;
	 OUT_VALID_TMP<=0;
	 DOUT <= {233{1'b0}};
 end
 else if(cnt == 8'hE9) begin
    OUT_VALID_TMP <= 1'b1;
//	 OUT_VALID<=OUT_VALID_TMP;
	 OUT_VALID<=1'b1;
	 DOUT <= DOUT ^ 233'h18F3815FE60E05D23DEEC41670ECDA4DE035D6EEE6D88723F7FA7983F98;
	 
 end
 else begin
    OUT_VALID_TMP <= 1'b0;
//	 OUT_VALID<=OUT_VALID_TMP;
	 OUT_VALID<=1'b0;
	 DOUT <= data_tmp;
 end



endmodule