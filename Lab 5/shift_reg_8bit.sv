module shift_reg_8bit(	input logic clk, reset, load, shift_en, shift_in,
						input logic [7:0] din,
						output logic shift_out,
						output logic [7:0] dout);
	always_ff @ (posedge clk)
	begin
		if(reset)
			dout <= 8'h00;
		else if (load)
			dout <= din;
		else if(shift_en)
			dout <= {shift_in, dout[7:1]};
	end

	always_comb
	begin
		shift_out = dout[0];
	end
endmodule