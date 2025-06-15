module eight_bit_adder(
    input  [7:0] a,
    input  [7:0] b,
    input        cin,
    output [7:0] sum,
    output       cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module sixteen_bit_adder(
    input  [15:0] a,
    input  [15:0] b,
    input         cin,
    output [15:0] sum,
    output        cout
);
    wire c1; 
 
    // Lower 8 bits
    eight_bit_adder a1 (
        .a(a[7:0]),
        .b(b[7:0]),
        .cin(cin),
        .sum(sum[7:0]),
        .cout(c1)
    );

    // Upper 8 bits
    eight_bit_adder a2 (
        .a(a[15:8]),
        .b(b[15:8]),
        .cin(c1),
        .sum(sum[15:8]),
        .cout(cout)
    );
endmodule

module tb_sixteen_bit_adder;
    reg  [15:0] a, b;
    reg         cin;
    wire [15:0] sum;
    wire        cout;

    sixteen_bit_adder adder16 (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $display("A\tB\tCIN\tSUM\tSUM\tCOUT");

        a = 16'h00FF; b = 16'h0001; cin = 0; #10;
        $display("%h\t%h\t%b\t%h\t%d\t%b", a, b, cin, sum, sum, cout);

        a = 16'h00FF; b = 16'h0011; cin = 0; #10;
        $display("%h\t%h\t%b\t%h\t%d\t%b", a, b, cin, sum, sum, cout);

        a = 16'h00FF; b = 16'h0111; cin = 1; #10;
        $display("%h\t%h\t%b\t%h\t%d\t%b", a, b, cin, sum, sum, cout);
    end
endmodule

