module d_latch_asyn_rstn(
    input logic clk,
    input logic D,
    input logic reset_n,
    output logic Q, 
    output logic Qn 
);
    logic S, R;
    logic Q1;   // Modified
    
    
    assign S = D;
    assign R = ~D;    //   Modified

    logic nand1_o, nand2_o;
    nand (nand1_o, S, clk);
    nand (nand2_o, R, clk);

    nand (Q1, nand1_o, Qn);    //  Modified
    and (Q, reset_n, Q1);      // Modified
    nand (Qn, nand2_o, Q);    //  Modified
 
endmodule                                                                                                                                                            