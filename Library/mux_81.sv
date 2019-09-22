module mux_81(input logic [2:0] sel, 
			  input logic [7:0] din
			  output logic out);
	always_comb
	begin
		unique case (sel)
			3'b000	:	out = din[0];
			3'b001	:	out = din[1];
			3'b010	:	out = din[2];
			3'b011	:	out = din[3];
			3'b100	:	out = din[4];
			3'b101	:	out = din[5];
			3'b110	:	out = din[6];
			3'b111	:	out = din[7];
		endcase
	end
endmodule 