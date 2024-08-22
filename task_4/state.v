// Please put description here

// Stretch goal:
// 1: Recovery on corrupted state

module main (
    input   wire r1,
    input   wire r2,
    input   wire r3,
    output  wire g1,
    output  wire g2,
    output  wire g3
);

// Internal Signal
reg [1:0]  STATE;
reg [3:0]  output_sel;

// State List
localparam A = 1;   // A: Idle
localparam B = 2;   // B: r1 active
localparam C = 3;   // C: r2 active
localparam D = 4;   // D: r3 active

// State Floppers
always @(*) begin
    case(STATE)
    A       :  output_sel = 4'b0000;  // Open unused
    B       :  output_sel = 4'b0010;
    C       :  output_sel = 4'b0100;
    D       :  output_sel = 4'b1000;
    default :  output_sel = 4'bxxxx;
    endcase
end

// State Table
// Schedule state change depending on input
// Priority: r1 > r2 > r3
always @(*) begin
    if(r1)
        STATE   =   B;
    else if(r2 & ~r1)
        STATE   =   C;
    else if(r3 & ~r2 & ~r1)
        STATE   =   D;
    else
        STATE   =   A;
end

// Output Driver
assign g1 = output_sel[1];
assign g2 = output_sel[2];
assign g3 = output_sel[3];

endmodule