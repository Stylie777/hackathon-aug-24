// Please put description here

module fsm_tb ();

// Internal Signal
reg  [3:1]  r;
wire [3:1]  g;

reg         clk;
reg         reset;
reg  [1:0]  truth;

// Module Instantiation
fsm_to_test Arbiter_1 (
    .clk(clk),
    .resetn(reset),
    .r(r),
    .g(g)
);

// Clock Generation
always #5 clk=~clk;

// Signal clear
initial begin
    clk = 0;
    r = 3'b000;
    reset = 0;
    truth = 0;
end

// Testbench
initial #1000 $finish;

// Test cases
initial begin
    #20
    reset = 1;  // Release reset
    // Case r1
    r = 3'b001;
    truth = 1;
    #10
    // Case r2
    r = 3'b010;
    truth = 2;
    #10
    // Case r3
    r = 3'b100;
    truth = 3;
    #10
    // Case r1 vs r2
    r = 3'b011;
    truth = 1;
    #10
    // Case r1 vs r3
    r = 3'b101;
    truth = 1;
    #10
    // Case r2 vs r3
    r = 3'b110;
    truth = 2;
    #10
    // Case r1 vs r2 vs r3
    r = 3'b111;
    truth = 1;
    #10
    // Case rubbish value
    r = 3'b1x0;
    truth = 1'bx;
    #20
    // Reset
    reset = 0;
    truth = 0;
end

// GTKWave Dump
initial
begin
   $dumpfile("test.vcd");
   $dumpvars(0,fsm_tb);
end

endmodule