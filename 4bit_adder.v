module four_bit_adder(
	input [3:0]a,
	input [3:0]b,
	input cin,
	output [3:0]sum,
	output cout  );

	assign {cout,sum}=a+b+cin;
endmodule
 
module tb_4bit_adder;
    // Testbench variables
    reg  [3:0] a, b;
    reg  cin;
    wire [3:0] sum;
    wire cout;

    // Instantiation 
    four_bit_adder add1 (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $display("A     B     CIN | SUM   COUT");

        a = 4'd10; b = 4'd2; cin = 0; #10;
        $display("%b  %b   %b   | %d	%b   %b", a, b, cin, sum, sum, cout);

        a = 4'd10; b = 4'd4; cin = 0; #10;
        $display("%b  %b   %b   | %d	%b   %b", a, b, cin, sum, sum, cout);

        a = 4'd10; b = 4'd6; cin = 0; #10;
        $display("%b  %b   %b   | %d	%b   %b", a, b, cin, sum, sum, cout);

        a = 4'd10; b = 4'd8; cin = 1; #10;
        $display("%b  %b   %b   | %d	%b   %b", a, b, cin, sum, sum, cout);

    end
endmodule
