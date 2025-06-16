module mux_8x1( 
	input [7:0]in,
	input [2:0]sel,
	output reg out );

    always @(*) begin
        case (sel)
            3'b000: out = in[0];
            3'b001: out = in[1];
            3'b010: out = in[2];
            3'b011: out = in[3];
            3'b100: out = in[4];
            3'b101: out = in[5];
            3'b110: out = in[6];
            3'b111: out = in[7];
            default: out = 1'b0;
        endcase
    end
	// assign op= in[sel]
endmodule

module tb_8x1_mux ;
	reg [7:0]a;
	reg [2:0]sel;
	wire op;

	mux_8x1 m1( 	
			.in(a[7:0]),
			.sel(sel[2:0]),
			.out(op)
		);	
	initial begin
        a = 8'b10101011; 
        sel = 3'b000;  
        #10;
        $display("Selected input: %b", op);

        sel = 3'b010;
        #10;
        $display("Selected input: %b", op);
	end

endmodule
