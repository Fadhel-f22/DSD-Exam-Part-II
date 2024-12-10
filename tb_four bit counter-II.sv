`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb_4bits_counter_II;

    logic clk;
     logic reset_n;
     logic load;
     logic [3:0] load_data;
     logic [3:0] count;

counter_4bit C (
    .clk(clk),
    .reset_n(reset_n),
    .load(load),
    .load_data(load_data),
    .count(count));

     
always #5 clk = ~clk;
initial begin 
#5
    clk = 1'b0;
    reset_n = 1'b1;
    load = 1'b0;
    load_data = 3'b011;
#10
    reset_n = 1'b0;
    load = 1'b0;
    load_data = 3'b011;
#10
    reset_n = 1'b1;    
#50
    load = 1'b1;
#20
    load = 1'b0;          
      
#1000 
$finish;
end    
endmodule
