`timescale 1ms / 1us

module clock_core(
    input clk,r,s,hour_24,
    input [3:0] a,b,c,d,e,f,
    output reg [3:0] h1,h0,
    output [3:0] m1,m0,s1,s0,
    output reg am,pm,
    output reg [3:0] a1,a2,a3,a4,a5,a6
);

    reg m=0,n=0,mr=0,nr=0;

    initial begin
        a1=0;a2=0;a3=0;a4=0;a5=0;a6=0;
    end

    always @(posedge r) m <= ~m;
    always @(posedge s) n <= ~n;

    always @(posedge clk) begin
        mr <= m;
        nr <= n;
        if(r==1 || m!=mr) begin
            a1<=0;a2<=0;a3<=0;a4<=0;a5<=0;a6<=0;
        end
        else if(s==1 || n!=nr) begin
            a1<=a;a2<=b;a3<=c;a4<=d;a5<=e;a6<=f;
        end
        else begin
            if(a6==9) begin
                a6<=0;
                if(a5==5) begin
                    a5<=0;
                    if(a4==9) begin
                        a4<=0;
                        if(a3==5) begin
                            a3<=0;
                            if(a1==2 && a2==3) begin a1<=0; a2<=0; end
                            else if(a2==9) begin a2<=0; a1<=a1+1; end
                            else a2<=a2+1;
                        end
                        else a3<=a3+1;
                    end
                    else a4<=a4+1;
                end
                else a5<=a5+1;
            end
            else a6<=a6+1;
        end
    end

    assign m1=a3;
    assign m0=a4;
    assign s1=a5;
    assign s0=a6;

    always @(*) begin
        if(hour_24==1) begin
            h1=a1; h0=a2; am=0; pm=0;
        end
        else if(a1==0 && a2==0) begin
            h1=1; h0=2; am=1; pm=0;
        end
        else if(a1==0 || (a1==1 && a2<2)) begin
            h1=a1; h0=a2; am=1; pm=0;
        end
        else if(a1==1 && a2==2) begin
            h1=1; h0=2; am=0; pm=1;
        end
        else if(a1==1) begin
            h1=0; h0=a2-2; am=0; pm=1;
        end
        else if(a2<2) begin
            h1=0; h0=a2+8; am=0; pm=1;
        end
        else begin
            h1=1; h0=a2-2; am=0; pm=1;
        end
    end
endmodule
