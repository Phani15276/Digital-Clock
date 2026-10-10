`timescale 1ms / 1us

module alarm(
    input clk,a_set,a_enable,a_reset,
    input [3:0] ain1,ain2,ain3,ain4,
    input [3:0] a1,a2,a3,a4,
    output reg a_out
);

    parameter a_timer=60;
    reg [7:0] a_c=0;
    reg w=0;

    initial a_out=0;

    always @(posedge clk) begin
        if(a_set==1 && a_enable==1 && a_reset==0 && ((a1==ain1 && a2==ain2 && a3==ain3 && a4==ain4) || w==1)) begin
            a_out<=1; w<=1;
            if(a_c<a_timer) a_c<=a_c+1;
            else begin
                a_c<=0; w<=0;
            end
        end
        else begin
            a_out<=0; a_c<=0; w<=0;
        end
    end
endmodule
