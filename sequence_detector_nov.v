`timescale 1us/1ns
module sequence_detector_nov (
    input clk,
    input rst,
    input in,
    output reg detected,
    output [1:0] state_out
);

parameter [1:0] s1= 2'd0,
                s2= 2'd1,
                s3= 2'd2,
                s4= 2'd3;

reg [1:0] next_state;
reg [1:0] state;

always @(*) begin
    detected=1'b0;
    case(state)
        s1: begin
            if(in==1)
                next_state=s2;
            else
                next_state=s1;
        end
        s2: begin
            if(in==1)
                next_state=s3;
            else
                next_state=s1;
        end
        s3: begin
            if(in==0)
                next_state=s4;
            else
                next_state=s3;
        end
        s4: begin
            if(in==1) begin
                detected=1'b1;
                next_state=s1;
            end
            else
                next_state=s1;
        end
        default: next_state=s1;
    endcase
end

always @(posedge clk or negedge rst) begin
    if(!rst)
        state <= s1;
    else
        state <= next_state;
end

assign state_out = state;

endmodule

module tb_sequence_detector_nov();
    reg clk=0, rst, in;
    wire detected;
    wire [1:0] state_out;

    reg [0:15] vector= 16'b1101_1010_1101_1101;
    integer i;

    sequence_detector_nov det1(
        .clk(clk),
        .rst(rst),
        .in(in),
        .detected(detected),
        .state_out(state_out)
    );

    always #0.5 clk = ~clk;
    
    always @(posedge clk) begin
        $display($time,"In= %b, Detected = %b",in,detected);
    end
    
    initial begin 
        rst=0;
        #1 rst=1;
        repeat(2) @(posedge clk);

        for(i=0; i<16; i=i+1) begin
		    in = vector[i];
            @(posedge clk);
		end
        #1 $stop;
    end
    
endmodule