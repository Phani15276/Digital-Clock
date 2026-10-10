`timescale 1ms / 1us

module stopwatch(
    input clk,start,pause,restart,
    output reg [31:0] count,
    output reg running
);

    initial begin
        count=0;
        running=0;
    end

    always @(posedge clk) begin
        if(restart) running<=0;
        else if(start) running<=1;
        else if(pause) running<=0;

        if(restart) count<=0;
        else if(running) count<=count+1;
    end
endmodule
