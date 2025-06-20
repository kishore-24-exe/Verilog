module shift_reg_siso(
    input sin,
    input reset,
    input clk,
    output sout
);

reg [3:0] siso;

always @(posedge clk or negedge reset) begin
    if (!reset) 
        siso <= 4'b0;
    else 
        siso[3:0] <= {siso[2:0],sin};
end

assign sout=siso[3];
endmodule

`timescale 1us/1ns
module tb_shift_reg_siso();
    reg sin, clk=0, reset;
    wire sout;
    shift_reg_siso siso1(
        .sin(sin),
        .reset(reset),
        .clk(clk),
        .sout(sout)
    );

    always begin #0.5 clk= ~clk; end

initial begin
    reset = 0; sin = 0;
    #1;
    reset = 0;  
    #2;
    @(posedge clk); reset = 1; sin = 1;   
    @(posedge clk); sin = 0;              
    @(posedge clk); sin = 1;              
    @(posedge clk); sin = 0;              
    repeat (5) @(posedge clk);            
end

    initial begin 
        #50; $stop;
    end

endmodule