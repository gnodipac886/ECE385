module carry_lookahead_adder_16bit
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);
	logic C1, C2, C3;
	logic [3:0] P, G;
	
	lad4 la0(.a4(A[3:0]), .b4(B[3:0]), .C0(0), .sum4(Sum[3:0]), .p4(P[0]), .g4(G[0]));
	lad4 la1(.a4(A[7:4]), .b4(B[7:4]), .C0(C1), .sum4(Sum[7:4]), .p4(P[1]), .g4(G[1]));
	lad4 la2(.a4(A[11:8]), .b4(B[11:8]), .C0(C2), .sum4(Sum[11:8]), .p4(P[2]), .g4(G[2]));
	lad4 la3(.a4(A[15:12]), .b4(B[15:12]), .C0(C3), .sum4(Sum[15:12]), .p4(P[3]), .g4(G[3]));
	
	always_comb
	begin
		C1 = (0 & P[0]) | (G[0]);
		C2 = (0 & P[0] & P[1]) | (G[0] & P[1]) | (G[1]);
		C3 = (0 & P[0] & P[1] & P[2]) | (G[0] & P[1] & P[2]) | (G[1] & P[2]) | (G[2]);
		CO = (0 & P[0] & P[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[2] & P[3]) | (G[3]);
	end
	
endmodule

module lad4(input logic [3:0] a4, b4, 
				input C0,
				output logic [3:0]sum4, 
				output logic p4, g4);
	logic c1, c2, c3;
	logic [3:0] p, g;
	always_comb
	begin
		p = a4 ^ b4;
		g = a4 & b4;
		c1 = (C0 & p[0]) | g[0];
		c2 = (C0 & p[0] & p[1]) | (p[1] & g[0]) | (g[1]);
		c3 = (C0 & p[0] & p[1] & p[2]) | (p[1] & p[2] & g[0]) | (p[2] & g[1]) | (g[2]);
		p4 = p[0] & p[1] & p[2] & p[3];
		g4 = (g[3]) | (g[2] & p[3]) | (g[1] & p[3] & p[2]) | (g[0] & p[3] & p[2] & p[1]);
	end
	
	full_adder FA0(.a(a4[0]), .b(b4[0]), .cin(C0), .sum(sum4[0]));
	full_adder FA1(.a(a4[1]), .b(b4[1]), .cin(c1), .sum(sum4[1]));
	full_adder FA2(.a(a4[2]), .b(b4[2]), .cin(c2), .sum(sum4[2]));
	full_adder FA3(.a(a4[3]), .b(b4[3]), .cin(c3), .sum(sum4[3]));
	
endmodule
