module myDivider2(in_div2, out_div2);
  input in_div2;
  output reg out_div2;
  
  initial begin
    out_div2 <= 1'b0;
  end
   
  always @(posedge in_div2) begin
    out_div2 <= ~out_div2;
  end
endmodule
