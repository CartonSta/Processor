module SX(in_sx, out_sx);
  input [16:0] in_sx;
  output [31:0] out_sx;
  
  assign out_sx[16:0] = in_sx;
  assign out_sx[31:17] = {in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16], in_sx[16]};
endmodule
