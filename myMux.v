module myMux (in0_mux, in1_mux, sel_mux, out_mux);
  input [31:0] in0_mux, in1_mux;
  input sel_mux;
  output [31:0] out_mux;
  
  assign out_mux = sel_mux ? in1_mux : in0_mux;
endmodule
