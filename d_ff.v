`timescale 1us/1ns
module d_ff(
	input clk,
	input d_in,
	input reset,
	output d_out,
	output d_outn );
reg d_ff;
	
always @(posedge clk or negedge reset) begin
	if(!reset)
		d_ff<= 1'b0;
	else
		d_ff <= d_in;
	end
	
assign d_out= d_ff;
assign d_outn= ~d_ff;

endmodule


module tb_d_ff();
	reg clk=0;
	reg d_in;
	reg reset;
	wire d_out;
	wire d_outn;
d_ff dff1( 
	.clk(clk),
	.d_in(d_in),
	.reset(reset),
	.d_out(d_out),
	.d_outn(d_outn) );
always begin #0.5 clk= ~clk; end

initial begin 
	$monitor("Reset=%d Input=%d Output=%d",reset,d_in,d_out);
	#1; reset=0; 
	#1; reset=1; d_in=1;
	#1; d_in=0;
	#1; d_in=1; 
	#1; reset=0; d_in=0;

	#10; $stop;
end
endmodule

	