module ripple_adder
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
four_bit_adder FOURA3(.A1(A[15:9]), .B1(B[15:9]), .CIN(C3), .SUM1(Sum[15:9]), .COUT(CO));

endmodule
    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
module full_adder(input a, b, cin, output sum, cout);
always_comb
begin
	sum = a ^ b ^ cin;
	cout = (a & b) | (b & cin) | (a & cin);
end
endmodule

module four_bit_adder(input [3:0]	A1,B1, 
							input CIN, 
							output [3:0]	SUM1, 
							output COUT);
logic c1, c2, c3;
full_adder FA0(.a(A1[0]), .b(B1[0]), .cin(CIN), .sum(SUM1[0]), .cout(c1));
full_adder FA1(.a(A1[1]), .b(B1[1]), .cin(c1), .sum(SUM1[1]), .cout(c2));
full_adder FA2(.a(A1[2]), .b(B1[2]), .cin(c2), .sum(SUM1[2]), .cout(c3));
full_adder FA3(.a(A1[3]), .b(B1[3]), .cin(c3), .sum(SUM1[3]), .cout(COUT));
endmodule
