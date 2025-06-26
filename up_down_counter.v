module up_down_counter
	#(parameter N=3)
      (	input clk,
	input reset,
	input enable,	
	input up_en,
	input [7:0]in,
	output reg [7:0]out );
	
always @(posedge clk or negedge reset) begin
	if(!reset)
		out <=0;
	else if(enable==0)
		out <=in;
	else 
		out <= up_en ? (in + 1'b1) : (in - 1'b1);
end
endmodule

`timescale 1us/1ns
module tb_up_down_counter();
	parameter N=3;
	reg clk=0;
	reg enable;
	reg up_en;
	reg reset;
	reg [7:0]in;
	wire [7:0]out;

	up_down_counter 
	#(.N(N))
	count1 ( 
	.clk(clk),
	.reset(reset),
	.enable(enable),
	.up_en(up_en),
	.in(in[7:0]),
	.out(out[7:0])
	);
	always begin #0.5 clk = ~clk; end
	  
    initial begin	 
	    $monitor ($time, " load_en = %b, up_down = %b, counter_in = %d, counter_out = %d",
		               enable, up_en, in, out);
	    #1  ; reset = 0; enable = 0; in = 0;	up_en = 0; // count down
		#1.2; reset = 1;  
		@(posedge clk); 
		repeat(2) @(posedge clk); in = 3; enable = 1;
		@(posedge clk); enable = 0; up_en = 1;                    // count up
		
		wait (out == 0)  up_en = 0;                        // count down
	end

    initial begin
        #20 $stop;
    end  
endmodule