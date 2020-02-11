module myDecoder(in, en, out);
  input [4:0] in;
  input en;
  output [31:0] out;
  wire [4:0] Nin;


  not(Nin[0], in[0]);
  not(Nin[1], in[1]);
  not(Nin[2], in[2]);
  not(Nin[3], in[3]);
  not(Nin[4], in[4]);
  
  and(out[0], Nin[0], Nin[1], Nin[2], Nin[3], Nin[4], en);
  and(out[1], in[0], Nin[1], Nin[2], Nin[3], Nin[4], en);
  and(out[2], Nin[0], in[1], Nin[2], Nin[3], Nin[4], en);
  and(out[3], in[0], in[1], Nin[2], Nin[3], Nin[4], en);
  and(out[4], Nin[0], Nin[1], in[2], Nin[3], Nin[4], en);
  and(out[5], in[0], Nin[1], in[2], Nin[3], Nin[4], en);
  and(out[6], Nin[0], in[1], in[2], Nin[3], Nin[4], en);
  and(out[7], in[0], in[1], in[2], Nin[3], Nin[4], en);
  and(out[8], Nin[0], Nin[1], Nin[2], in[3], Nin[4], en);
  and(out[9], in[0], Nin[1], Nin[2], in[3], Nin[4], en);
  and(out[10], Nin[0], in[1], Nin[2], in[3], Nin[4], en);
  and(out[11], in[0], in[1], Nin[2], in[3], Nin[4], en);
  and(out[12], Nin[0], Nin[1], in[2], in[3], Nin[4], en);
  and(out[13], in[0], Nin[1], in[2], in[3], Nin[4],en);
  and(out[14], Nin[0], in[1], in[2], in[3], Nin[4], en);
  and(out[15], in[0], in[1], in[2], in[3], Nin[4], en);
  and(out[16], Nin[0], Nin[1], Nin[2], Nin[3], in[4], en);
  and(out[17], in[0], Nin[1], Nin[2], Nin[3], in[4], en);
  and(out[18], Nin[0], in[1], Nin[2], Nin[3], in[4], en);
  and(out[19], in[0], in[1], Nin[2], Nin[3], in[4], en);
  and(out[20], Nin[0], Nin[1], in[2], Nin[3], in[4], en);
  and(out[21], in[0], Nin[1], in[2], Nin[3], in[4], en);
  and(out[22], Nin[0], in[1], in[2], Nin[3], in[4], en);
  and(out[23], in[0], in[1], in[2], Nin[3], in[4], en);
  and(out[24], Nin[0], Nin[1], Nin[2], in[3], in[4], en);
  and(out[25], in[0], Nin[1], Nin[2], in[3], in[4], en);
  and(out[26], Nin[0], in[1], Nin[2], in[3], in[4], en);
  and(out[27], in[0], in[1], Nin[2], in[3], in[4], en);
  and(out[28], Nin[0], Nin[1], in[2], in[3], in[4], en);
  and(out[29], in[0], Nin[1], in[2], in[3], in[4], en);
  and(out[30], Nin[0], in[1], in[2], in[3], in[4], en);
  and(out[31], in[0], in[1], in[2],in[3],in[4], en);
endmodule
