/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

	 wire Rdt, JAL, ALUinB, isR, wren, Rwd, IFEQ, BR, JP, CR, BEX, SETX, JR, SETR, out_not0, isNotEqual, isLessThan, overflow;
	 wire [4:0] out_mux0, out_mux7, out_mux1, ALUop;
	 wire [31:0] out_sx, inB_alu, out_alu, out_adder1, out_mux3, out_mux4, out_mux5, out_mux6, out_mux8, nextPC, PCplus, out_pc, data_rstatus;
	 
	 myMux5 mux1(.in0_mux5(q_imem[26:22]), .in1_mux5(5'b11111), .sel_mux5(JAL), .out_mux5(out_mux1));
	 myMux5 mux7(.in0_mux5(q_imem[16:12]), .in1_mux5(q_imem[26:22]), .sel_mux5(Rdt), .out_mux5(out_mux7));
	 myMux5 mux9(.in0_mux5(q_imem[21:17]), .in1_mux5(5'b11110), .sel_mux5(BEX), .out_mux5(ctrl_readRegA));
	 myMux5 mux10(.in0_mux5(out_mux7), .in1_mux5(5'b00000), .sel_mux5(BEX), .out_mux5(ctrl_readRegB));
	 myMux5 mux11(.in0_mux5(out_mux1), .in1_mux5(5'b11110), .sel_mux5(SETX), .out_mux5(ctrl_writeReg));
	 
	 SX sx0(.in_sx(q_imem[16:0]), .out_sx(out_sx));
	 myMux mux2(.in0_mux(data_readRegB), .in1_mux(out_sx), .sel_mux(ALUinB), .out_mux(inB_alu));
	 myMux5 mux14(.in0_mux5(5'b00000), .in1_mux5(q_imem[6:2]), .sel_mux5(isR), .out_mux5(ALUop));
	 alu alu0(.data_operandA(data_readRegA), .data_operandB(inB_alu), .ctrl_ALUopcode(ALUop), .ctrl_shiftamt(q_imem[11:7]), .data_result(out_alu), .isNotEqual(isNotEqual), .isLessThan(isLessThan), .overflow(overflow));
	 
	 assign address_dmem = out_alu[11:0];
	 assign data = data_readRegB;
	 
	 myMux mux3(.in0_mux(out_alu), .in1_mux(q_dmem), .sel_mux(Rwd), .out_mux(out_mux3));
	 myMux mux6(.in0_mux(out_mux3), .in1_mux(PCplus), .sel_mux(JAL), .out_mux(out_mux6));
	 myMux mux8(.in0_mux(out_mux6), .in1_mux({out_pc[31:27], q_imem[26:0]}), .sel_mux(SETX), .out_mux(out_mux8));
	 myMux mux12(.in0_mux(out_mux8), .in1_mux(data_rstatus), .sel_mux(CR), .out_mux(data_writeReg));
	 
	 myMux mux5(.in0_mux(out_mux4), .in1_mux({out_pc[31:27], q_imem[26:0]}), .sel_mux(JP), .out_mux(out_mux5));
	 ALUadder adder1(.inA_adder(PCplus), .inB_adder(out_sx), .out_adder(out_adder1));
	 myMux mux4(.in0_mux(PCplus), .in1_mux(out_adder1), .sel_mux(BR), .out_mux(out_mux4));
	 
	 myDFFE pc0(.q(out_pc), .d(nextPC), .clk(clock), .en(1'b1), .clr(reset));
	 ALUadder adder0(.inA_adder(out_pc), .inB_adder(32'b1), .out_adder(PCplus));
	 
	 assign address_imem = out_pc[11:0];
	 
	 myMux mux13(.in0_mux(out_mux5), .in1_mux(data_readRegB), .sel_mux(JR), .out_mux(nextPC));
	 
	 myControl ctrl0(.opcode(q_imem[31:27]), .func(q_imem[6:2]), .isNotEqual(isNotEqual), .isLessThan(isLessThan), .overflow(overflow), .Rwe(ctrl_writeEnable), .Rdt(Rdt), .JAL(JAL), .ALUinB(ALUinB), .isR(isR), .wren(wren), .Rwd(Rwd), .BR(BR), .JP(JP), .CR(CR), .BEX(BEX), .SETX(SETX), .JR(JR), .SETR(SETR), .data_rstatus(data_rstatus));
	 
endmodule
