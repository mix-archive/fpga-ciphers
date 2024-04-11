module test;

  reg clk;
  reg reset;

  reg load1;
  reg load2;
  reg enc;
  reg [127:0] pt;
  reg [127:0] ct;
  reg [127:0] key;

  wire ready1;
  wire ready2;
  wire [127:0] dout;
  wire [127:0] dout2;


  initial begin
    clk = 0;
    reset = 0;
    load1 = 1;
    load2 = 1;
    enc = 0;
    pt = hf34481ec3cc627bacd5dc3fb08f273e6;
    ct = h0336763e966d92595a567cc9ce537f5e;
    key = h00000000000000000000000000000000;

    #10;
    reset = 1;

    while (!ready1 || !ready2) @(posedge clk);

  end
  always #2 clk = (ready1 & ready2) | ~clk;


  ARS_aes aes_enc (
      .clk  (clk),
      .reset(reset),
      .load (load1),
      .enc  (1'b0),    // encryption
      .din  (pt),
      .key  (key),
      .ready(ready1),
      .dout (dout)
  );


  ARS_aes aes_dec (
      .clk  (clk),
      .reset(reset),
      .load (load2),
      .enc  (1'b1),    // decryption
      .din  (ct),
      .key  (key),
      .ready(ready2),
      .dout (dout2)
  );
endmodule
