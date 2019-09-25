module five_bit_adder(input logic [4:0]	A1,B1, 
							input logic CIN, 
							output logic [4:0]	SUM1, 
							output logic COUT);
	logic c1, c2, c3, c4;

	full_adder FA0(.a(A1[0]), .b(B1[0]), .cin(CIN), .sum(SUM1[0]), .cout(c1));
	full_adder FA1(.a(A1[1]), .b(B1[1]), .cin(c1), .sum(SUM1[1]), .cout(c2));
	full_adder FA2(.a(A1[2]), .b(B1[2]), .cin(c2), .sum(SUM1[2]), .cout(c3));
	full_adder FA3(.a(A1[3]), .b(B1[3]), .cin(c3), .sum(SUM1[3]), .cout(c4));
	full_adder FA4(.a(A1[4]), .b(B1[4]), .cin(c4), .sum(SUM1[4]), .cout(COUT));

endmodule
