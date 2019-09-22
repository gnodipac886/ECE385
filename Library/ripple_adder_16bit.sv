module ripple_adder_16bit
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

logic C1, C2, C3;

four_bit_adder FOURA0(.A1(A[3:0]), .B1(B[3:0]), .CIN(0), .SUM1(Sum[3:0]), .COUT(C1));
four_bit_adder FOURA1(.A1(A[7:4]), .B1(B[7:4]), .CIN(C1), .SUM1(Sum[7:4]), .COUT(C2));
four_bit_adder FOURA2(.A1(A[11:8]), .B1(B[11:8]), .CIN(C2), .SUM1(Sum[11:8]), .COUT(C3));
four_bit_adder FOURA3(.A1(A[15:12]), .B1(B[15:12]), .CIN(C3), .SUM1(Sum[15:12]), .COUT(CO));

endmodule