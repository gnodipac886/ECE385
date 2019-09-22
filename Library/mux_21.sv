module mux_21(input logic sel, 
			  input logic [1:0] din,
			  output logic out);
	always_comb
	begin
		unique case (sel)
			1'b0 	:	out = din[0];
			1'b1	:	out = din[1];
		endcase
	end
endmodule 