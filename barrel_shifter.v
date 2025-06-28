`timescale 1us/1ns
module barrel_shifter
    (   input [7:0]in,
        input [2:0]sel,
        output reg [7:0] out
    );

parameter lsl = 3'd1 ;
parameter lsr = 3'd2 ;
parameter asl = 3'd3 ;
parameter asr = 3'd4 ;
parameter rol = 3'd5 ;
parameter ror = 3'd6 ;
    always @(*) begin
        case(sel)
            lsl: out = in << 1;
            lsr: out = in >> 1;
            asl: out = in <<< 1;
            asr: out = in >>> 1;
            rol: out = {in[6:0], in[7]}; 
            ror: out = {in[0], in[7:1]}; 
            default: out=0;
        endcase
    end
endmodule

module tb_barrel_shifter();

reg [7:0] in;
reg [2:0]sel;
wire [7:0] out;

parameter lsl = 3'd1 ;
parameter lsr = 3'd2 ;
parameter asl = 3'd3 ;
parameter asr = 3'd4 ;
parameter rol = 3'd5 ;
parameter ror = 3'd6 ;
barrel_shifter s1 ( .in(in),
                    .sel(sel), 
                    .out(out)
                );
    initial begin
        $monitor($time,"in = %b, sel = %b, out = %b",in,sel,out);
        in = 8'd1; sel = lsl; #1;
        in = 8'd2; sel = lsr; #1;
        in = 8'd3; sel = asl; #1;
        in = 8'd4; sel = asr; #1;
        in = 8'd5; sel = rol; #1;
        in = 8'd6; sel = ror; #1;   
        $stop;
    end
endmodule