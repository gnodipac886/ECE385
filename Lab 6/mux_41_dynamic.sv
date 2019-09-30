module mux_41_dynamic
	#(parameter width = 16)
					(
						input logic [1:0] sel, 
						input logic [width - 1: 0] d0, d1, d2, d3,
						output logic[width - 1: 0] out
					);
	always_comb
	begin
		unique case (sel)
			2'b00	:	out = d0;
			2'b01	:	out = d1;
			2'b10	:	out = d2;
			2'b11	:	out = d3;
		endcase
	end
endmodule 