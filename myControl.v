module myControl(opcode, func, isNotEqual, isLessThan, overflow, Rwe, Rdt, JAL, ALUinB, isR, wren, Rwd, BR, JP, CR, BEX, SETX, JR, SETR, data_rstatus);

  input isNotEqual, isLessThan, overflow;
  input [4:0] opcode, func;
  
  output Rwe, Rdt, JAL, ALUinB, isR, wren, Rwd, BR, JP, CR, BEX, SETX, JR, SETR;
  output [31:0] data_rstatus;
  
  wire [31:0] op, fd, out_mux0;
  wire sel0, sel1;
  
  myDecoder dec0(.in(opcode), .en(1'b1), .out(op));
  myDecoder dec1(.in(func), .en(1'b1), .out(fd));
  
  assign Rwe = op[0] || op[5] || op[8] || op[3] || op[21];
  assign Rdt = op[7] || op[2] || op[4] || op[6];
  assign JAL = op[3];
  assign ALUinB = op[5] || op[7] || op[8];
  assign wren = op[7];
  assign Rwd = op[8];
  assign SETX = op[21];
  assign BR = (op[2] && isNotEqual) || (op[6] && isNotEqual && ~isLessThan);
  assign JP = op[1] || op[3] || (op[22] && isNotEqual);
  assign CR = overflow && ((op[0] && fd[0]) || (op[0] && fd[1]) || op[5]);
  assign BEX = op[22];
  assign JR = op[4];
  assign SETR = CR || SETX;
  assign isR = op[0];
  
  myMux mux0(.in0_mux(32'b1), .in1_mux(32'b10), .sel_mux(sel0), .out_mux(out_mux0));
  myMux mux1(.in0_mux(out_mux0), .in1_mux(32'b11), .sel_mux(sel1), .out_mux(data_rstatus));
  
  assign sel0 = op[5];
  assign sel1 = op[0] && fd[1];
  
endmodule
