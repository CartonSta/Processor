module myMux5(in0_mux5, in1_mux5, sel_mux5, out_mux5);
  input [4:0] in0_mux5, in1_mux5;
  input sel_mux5;
  output [4:0] out_mux5;
  
  assign out_mux5 = sel_mux5 ? in1_mux5 : in0_mux5;
endmodule
