// Please put description here

// Stretch goal:
// 1: Recovery on corrupted state

module fsm_to_test (
    input   wire        clk,
    input   wire        resetn, // Active low, synchronous reset
    input   wire [3:1]  r,      // Request
    output  reg  [3:1]  g       // Grant
);

// Internal Signal
reg [1:0]  STATE;

// State List
localparam A = 0;   // A: Idle
localparam B = 1;   // B: r1 active
localparam C = 2;   // C: r2 active
localparam D = 3;   // D: r3 active

// State Floppers and Output Driver, combinatorial
always @(*) begin
    case(STATE)
    A       :  g = 3'b000;  // Open
    B       :  g = 3'b001;  // g1
    C       :  g = 3'b010;  // g2
    D       :  g = 3'b100;  // g3
    default :  g = 3'b000;  // Keep open if unknown state
    endcase
end

// State Table + Reset Logic, sequential
// Schedule state change depending on input, synchronous
// Priority: r1 > r2 > r3
always @(posedge clk) begin
    if(!resetn)
        STATE = A;
    else begin
        if(r[1])
            STATE   =   B;
        else if(r[2] & ~r[1])
            STATE   =   C;
        else if(r[3] & (~r[2] & ~r[1]))
            STATE   =   D;
        else
            STATE   =   A;
    end
end

endmodule