module shift_reg_piso(
    input [3:0] pin,
    input reset,
    input clk,
    input load,
    output sout
);
    reg [3:0] piso;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            piso <= 4'b0000;
        end else if (load) begin
            piso <= pin;
        end else begin
            piso <= {piso[2:0], 1'b0};
        end
    end

    assign sout = piso[3];
endmodule

`timescale 1us/1ns

module tb_shift_reg_piso();
    reg [3:0] pin;
    reg clk = 0;
    reg reset;
    reg load;
    wire sout;

    shift_reg_piso piso1 (
        .clk(clk),
        .pin(pin),
        .reset(reset),
        .load(load),
        .sout(sout)
    );

    always #0.5 clk = ~clk;

    initial begin
        reset = 0; load = 0; pin = 4'b0000;
        #1 reset = 1;
        load = 1;
        pin = 4'b1010;
        @(posedge clk);
        load = 0;
        repeat (5) @(posedge clk);
    end

    initial begin 
        #50 $stop;
    end
endmodule
