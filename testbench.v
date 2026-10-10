`timescale 1ms / 1us

module testbench();
    reg clk,r,s,hour_24;
    reg [3:0] a,b,c,d,e,f;
    reg a_set,a_enable,a_reset;
    reg [3:0] ain1,ain2,ain3,ain4;
    reg start,pause,restart;

    wire [3:0] h1,h0,m1,m0,s1,s0;
    wire am,pm,a_out,stopwatch_active;
    wire [31:0] count;

    de uut(
        .clk(clk), .r(r), .s(s), .hour_24(hour_24),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f),
        .a_set(a_set), .a_enable(a_enable), .a_reset(a_reset),
        .ain1(ain1), .ain2(ain2), .ain3(ain3), .ain4(ain4),
        .start(start), .pause(pause), .restart(restart),
        .h1(h1), .h0(h0), .m1(m1), .m0(m0), .s1(s1), .s0(s0),
        .am(am), .pm(pm), .a_out(a_out),
        .count(count), .stopwatch_active(stopwatch_active)
    );

    initial begin
        r=0; s=0; hour_24=1;
        a=0; b=0; c=0; d=0; e=0; f=0;
        a_set=0; a_enable=0; a_reset=0;
        ain1=0; ain2=0; ain3=0; ain4=0;
        start=0; pause=0; restart=0;

        #100;
        a=2; b=3; c=5; d=9; e=5; f=8;
        s=1; #1 s=0;
        #4000;

        hour_24=0;
        a=1; b=1; c=5; d=9; e=5; f=8;
        s=1; #1 s=0;
        #4000;

        r=1; #1 r=0;
        #3000;

        hour_24=1;
        ain1=0; ain2=7; ain3=3; ain4=0;
        a_set=1; a_enable=1;
        a=0; b=7; c=2; d=9; e=5; f=7;
        s=1; #1 s=0;
        #70000;
        a_enable=0;

        start=1; #1000 start=0;
        #5000;
        pause=1; #1000 pause=0;
        #3000;
        restart=1; #1000 restart=0;
        #2000;

        $finish;
    end

    initial begin
        $monitor("%0d%0d:%0d%0d:%0d%0d am=%b pm=%b a_out=%b count=%0d", h1,h0,m1,m0,s1,s0,am,pm,a_out,count);
    end

    initial begin
        clk=0;
        forever #500 clk=~clk;
    end
endmodule
