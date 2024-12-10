module decoder#(
    parameter n = 2
)(
    input logic [n-1:0]in,
    output logic [(1 << n) - 1: 0]out
);

    always @(*)
    begin 
        case(in)           // Modified
        2'b00: out = 4'b0001;
        2'b01: out = 4'b0010;
        2'b10: out = 4'b0100;
        default: out = 4'b1000;
        endcase
    end

endmodule :decoder    // Modified 