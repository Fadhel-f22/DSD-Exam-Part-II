// This counter is designed using register, adder and a multiplexer. 
// Normally we don't use this appraoch as this requires more hardware there a simple counter 
// that adds constant value "1'b1".

module counter_4bit#(
)(
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic [3:0] load_data,
    output logic [3:0] count
);

    logic [3:0] next_count;     // Modified
    assign next_count = load ? (load_data) : (count + 1);   // Modified


    always @(posedge clk, negedge reset_n)
    begin 
        if(!reset_n)              //Modified
            count <= 3'b000;
        else 
            count <= next_count;
    end

endmodule