module decoder3x8 (
    input  [2:0] in,
    output reg [7:0] out
);
    always @(*) begin
        out = 8'b00000000;  
        out[in] = 1'b1;     
    end
endmodule

module tb_decoder3x8;
    reg [2:0] in;
    wire [7:0] out;

    decoder3to8 uut (
        .in(in),
        .out(out)
    );
    integer i;

    initial begin
        $display("Input | Output");
        $monitor("%b    | %b", in, out);
        
        for (i = 0; i < 8; i = i + 1) begin
            in = i[2:0];
            #10;
        end
    end
endmodule
