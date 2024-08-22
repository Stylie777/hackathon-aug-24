// Please put description here

module main_tb ();

// Internal Signal
reg  r1;
reg  r2;
reg  r3;
wire g1;
wire g2;
wire g3;
reg [1:0] truth;

// Module Instantiation
arbiter Arbiter_1 (
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .g1(g1),
    .g2(g2),
    .g3(g3)
);

// Signal clear
initial begin
    r1 = 0;
    r2 = 0;
    r3 = 0;
    truth = 0;
end

initial begin
    #10
    // Case r1
    r1 = 1;
    r2 = 0;
    r3 = 0;
    truth = 1;
    #10;
    // Case r2
    r1 = 0;
    r2 = 1;
    r3 = 0;
    truth = 2;
    #10
    // Case r3
    r1 = 0;
    r2 = 0;
    r3 = 1;
    truth = 3;
    #10
    // Case r1 vs r2
    r1 = 1;
    r2 = 1;
    r3 = 0;
    truth = 1;
    #10
    // Case r1 vs r3
    r1 = 1;
    r2 = 0;
    r3 = 1;
    truth = 1;
    #10
    // Case r2 vs r3
    r1 = 0;
    r2 = 1;
    r3 = 1;
    truth = 2;
    #10
    // Case r1 vs r2 vs r3
    r1 = 1;
    r2 = 1;
    r3 = 1;
    truth = 1;
    #10
    // Reset
    r1 = 0;
    r2 = 0;
    r3 = 0;
    truth = 0;
end

// GTKWave Dump
initial
begin
   $dumpfile("test.vcd");
   $dumpvars(0,main_tb);
end

endmodule