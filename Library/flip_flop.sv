module flip_flop(input logic clk, din
					output logic d, dnot);
	always_ff @ (posedge clk)
	begin
		d = din;
	end

	always_comb
	begin
		dnot = ~d;
	end

endmodule