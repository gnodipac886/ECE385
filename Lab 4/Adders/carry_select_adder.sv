module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  logic C1, C2, C3;
	  four_bit_adder fba(.A1(A[3:0]), .B1(B[3:0]), .CIN(0), .SUM1(Sum[3:0]), .COUT(C1));
     csa4 cs1(.a(A[7:4]), .b(B[7:4]), .cin(C1), .sum(Sum[7:4]), .cout(C2));
	  csa4 cs2(.a(A[11:8]), .b(B[11:8]), .cin(C2), .sum(Sum[11:8]), .cout(C3));
	  csa4 cs3(.a(A[15:12]), .b(B[15:12]), .cin(C3), .sum(Sum[15:12]), .cout(CO));
endmodule

module csa4(input logic [3:0] a, b,
				input logic cin,
				output logic [3:0]sum, 
				output logic cout);
	logic [3:0] s0, s1;
	logic c0, c1;
	four_bit_adder fba0(.A1(a), .B1(b), .CIN(0), .SUM1(s0), .COUT(c0));
	four_bit_adder fba1(.A1(a), .B1(b), .CIN(1), .SUM1(s1), .COUT(c1));
	mux21 m0(.d0(s0[0]), .d1(s1[0]), .sel(cin), .out(sum[0]));
	mux21 m1(.d0(s0[1]), .d1(s1[1]), .sel(cin), .out(sum[1]));
	mux21 m2(.d0(s0[2]), .d1(s1[2]), .sel(cin), .out(sum[2]));
	mux21 m3(.d0(s0[3]), .d1(s1[3]), .sel(cin), .out(sum[3]));
	mux21 mC(.d0(c0), .d1(c1), .sel(cin), .out(cout));
endmodule 

module mux21(input logic d0, d1, sel,
				output logic out);
	always_comb
	begin
		if (sel == 1'b1)
			out = d1;
		else
			out = d0;
	end
endmodule 

//question: if input is array, how to declare with different logic