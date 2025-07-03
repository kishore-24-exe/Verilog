`timescale 1us/1ns
module counter_nbit 
# (parameter  l= 4)
(
    input clk,
    input rst,
    output reg [l-1:0] data
);

always @(posedge clk or negedge rst) begin
    if(!rst)
        data <= 0; 
    else
        data <= data + 1'b1;
end
endmodule

module tb_counter_nbit();
    parameter l=4;
    reg clk=0;
    reg reset=0;
    wire [3:0]data;

    counter_nbit 
    #( .l(l) )
    count1 ( 
        .clk(clk),
        .rst(reset),
        .data(data)
        );

    always begin
        #0.5 clk=~clk;
    end
    
    initial begin 
        $monitor($time,"Counter = %d",data);
        #1; reset=0;
        #1; reset=1;
    end
    initial begin
         #20; $stop;
    end
    
endmodule
