module ALUadder(inA_adder, inB_adder, out_adder);
  input [31:0] inA_adder, inB_adder;
  output [31:0] out_adder;
  
  alu d0(.data_operandA(inA_adder), .data_operandB(inB_adder), .ctrl_ALUopcode(5'b0), .ctrl_shiftamt(5'b0), .data_result(out_adder), .isNotEqual(), .isLessThan(), .overflow());
endmodule
