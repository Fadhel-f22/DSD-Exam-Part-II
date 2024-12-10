`timescale 1ns / 1ps


module tb_K2;


    logic clk; 
    logic resetn;
    
core K2 (
    .clk(clk),
    .resetn(resetn)); 

always #5 clk = ~clk;

initial begin
#5
    clk = 1'b0;
    resetn = 1'b1;
#10
    resetn = 1'b0;
#10
    resetn = 1'b1;        
    
#3000   
$finish; 
end       
endmodule
