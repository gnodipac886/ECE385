module ALU(
			input logic 	[15:0]	A, B, 
			input logic 	[1:0]	aluk,
			output logic 	[15:0] 	ans
		   );
	/*
		0	: 	+
		1	: 	&
		2	: 	~
		3	: 	pass through
	*/

	always_comb begin
		case(aluk) 
			2'b00	:	ans = A + B;
			2'b01	:	ans = A & B;
			2'b10	:	ans = ~A;
			2'b11	:	ans = A;
		endcase
	end 
endmodule 