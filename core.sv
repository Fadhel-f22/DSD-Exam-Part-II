module core(
    input logic clk, 
    input logic resetn
);

// Instruction Fetching
logic [2:0] imm;
logic [3:0] pc;
logic J;
logic carry;
logic C;
logic [1:0] D;
logic Sreg;
logic S;

assign J = inst[7];
assign C = inst[6];
assign D = inst[5:4];  // Modified
assign Sreg = inst[3];
assign S = inst[2];
assign imm = inst[2:0];

// jump logic 
logic pc_load;
logic w1;
assign pc_load = J | (C & carry);

counter_n_bit pc_inst(
    .clk(clk),
    .resetn(resetn),
    .load_data({1'b0,imm}),
    .load(pc_load),
    .en(1'b1),   
    .count(pc)
);


// Instruction memory
logic [7:0] inst;
imem imem_inst(
    .addr(pc),
    .inst(inst)
);

// Decoding instruction 




// Generating enables for register O, A and B
logic enA, enB, enO;
decoder decoder_inst(
    .in(D),
    .out({enO,enB,enA})    // Modified
);

// registers 
logic [3:0] regIn;
logic [3:0] regA, regB, regO;

logic [3:0] AluOut;   // Modified

// Mux for selecting inputs for register (regIn)
mux_2x1 mux1(
    .in1({1'b0,imm}),  // Modified
    .in2(AluOut),  // Modified
    .sel(Sreg),
    .out(regIn)
);

// Register RA (regA)
register reg_A(
    .clk(clk),
    .resetn(resetn),
    .wen(enA),
    .D(regIn),
    .Q(regA)
);

// Register RB (regB)
register reg_B(
    .clk(clk),
    .resetn(resetn),
    .wen(enB),  // Modified
    .D(regIn),
    .Q(regB)
);



// Register RO (regO)
register reg_O(
    .clk(clk),  // Modified 
    .resetn(resetn),
    .wen(enO),
    .D(regA),
    .Q(regO)
);



// ALU


alu alu_inst(
    .clk(coreclk),
    .opcode(S),
    .a(regA),
    .b(regB),
    .out(AluOut),
    .carry(w1)
);

// Register carry   //added
register carry1(
    .clk(clk),
    .resetn(resetn),
    .wen(1'b1),  
    .D(carry),
    .Q(carry)
);

endmodule : core