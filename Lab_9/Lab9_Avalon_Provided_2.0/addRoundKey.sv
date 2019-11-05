module addRoundKey(	input logic [127:0] in, key,
					output logic [127:0] out);
	always_comb begin
		out 	= 	in 	^ 	key;	
	end 
endmodule 