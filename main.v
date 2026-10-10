`timescale 1ms / 1us

module de(
    input clk,r,s,hour_24,
    input [3:0] a,b,c,d,e,f,
    input a_set,a_enable,a_reset,
    input [3:0] ain1,ain2,ain3,ain4,
    input start,pause,restart,

    output [3:0] h1,h0,m1,m0,s1,s0,
    output am,pm,a_out,
    output [31:0] count,
    output stopwatch_active
);

    wire [3:0] a1,a2,a3,a4,a5,a6;

    clock_core clock_inst(
        .clk(clk), .r(r), .s(s), .hour_24(hour_24),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f),
        .h1(h1), .h0(h0), .m1(m1), .m0(m0), .s1(s1), .s0(s0),
        .am(am), .pm(pm),
        .a1(a1), .a2(a2), .a3(a3), .a4(a4), .a5(a5), .a6(a6)
    );

    alarm alarm_inst(
        .clk(clk), .a_set(a_set), .a_enable(a_enable), .a_reset(a_reset),
        .ain1(ain1), .ain2(ain2), .ain3(ain3), .ain4(ain4),
        .a1(a1), .a2(a2), .a3(a3), .a4(a4),
        .a_out(a_out)
    );

    stopwatch sw_inst(
        .clk(clk), .start(start), .pause(pause), .restart(restart),
        .count(count), .running(stopwatch_active)
    );
endmodule
