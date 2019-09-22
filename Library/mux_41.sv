module mux_41(input logic [1:0] sel, 
			  input logic [3:0] din
			  output logic out);
	always_comb
	begin
		unique case (sel)
			2'b00	:	out = din[0];
			2'b01	:	out = din[1];
			2'b10	:	out = din[2];
			2'b11	:	out = din[3];
		endcase
	end
endmodule 