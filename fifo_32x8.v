module sync_fifo
    #( parameter fifo_elements=8, parameter no_bits= 32)
    (
     input clk,
     input reset,
     input cs,
     input wr_en,
     input rd_en,
     input [no_bits-1:0] d_in,
     output reg [no_bits-1:0] d_out,
     output empty,
     output full 
    );
    //To access the address of 8 loc
    localparam address= $clog2(fifo_elements);
    //fifo register
    reg [no_bits-1:0] fifo[0:fifo_elements-1];

    reg [address:0]write_pointer;
    reg [address:0]read_pointer;

    always @(posedge clk or negedge reset) begin
        if(!reset)
            write_pointer <=0;
        else if( cs && wr_en && !full)
            write_pointer <= write_pointer + 1'b1;
    end

    always @(posedge clk or negedge reset) begin
        if(!reset)
            read_pointer <=0;
        else if( cs && rd_en && !empty)
            read_pointer <= read_pointer + 1'b1;
    end

    assign empty = ( read_pointer== write_pointer);
    assign full= (read_pointer == {~write_pointer[address],write_pointer[address-1:0]});

    always @ (posedge clk or negedge reset) begin
        if(!reset)
            d_out <= 0;
        else if( cs && rd_en && !empty)
            d_out <= fifo[read_pointer[address-1:0]];
    end
    endmodule
`timescale 1us/1ns
module tb_sync_fifo();
    parameter fifo_elements=8;
    parameter no_bits=32;
    reg clk;
    reg reset;
    reg cs;
    reg wr_en;
    reg rd_en;
    reg [no_bits-1:0] d_in;
    wire [no_bits-1:0] d_out;
    wire empty;
    wire full ;

    integer i;
    sync_fifo 
        #(.fifo_elements(fifo_elements),
        .no_bits(no_bits))
        fifo1
        (.clk(clk),
        .reset(reset),
        .cs(cs),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .d_in(d_in),
        .d_out(d_out),
        .empty(empty),
        .full(full));

        task write_data(input[no_bits-1:0] data_in);
            begin
                @(posedge clk);
                cs=1; wr_en=1;
                d_in= data_in;
                $display($time, " Data in = %0d", d_in);
                @(posedge clk);
                cs=1;wr_en=0;
            end
        endtask

        task read_data();
            begin
                @(posedge clk);
                cs=1; rd_en=1;
                @(posedge clk);
                $display($time, " Data out = %0d", d_out);
                cs=1;rd_en=0;
            end
        endtask

	always begin #0.5 clk = ~clk; end
        initial begin
	    #1; 
		reset = 0; rd_en = 0; wr_en = 0;
		
		#1; 
		reset= 1;
		$display($time, "\n SCENARIO 1");
		write_data(1);
		write_data(10);
		write_data(100);
		read_data();
		read_data();
		read_data();
		read_data();
		
        $display($time, "\n SCENARIO 2");
		for (i=0; i<fifo_elements; i=i+1) begin
		    write_data(2**i);
			read_data();        
		end

        $display($time, "\n SCENARIO 3");		
		for (i=0; i<=fifo_elements; i=i+1) begin
		    write_data(2**i);
		end
		
		for (i=0; i<fifo_elements; i=i+1) begin
			read_data();
		end
		
	    #40 $stop;
	end
endmodule
	
