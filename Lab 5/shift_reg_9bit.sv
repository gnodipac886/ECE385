module shift_reg_9bit(	input logic clk, reset, load, shift_en, shift_in
						input logic [8:0] din
						output logic shift_out
						output logic [8:0] dout);
	always_ff @ (posedge clk)
	begin
		if(reset)
			dout <= 9'b000000000;
		else if (load)
			dout <= din;
		else if(shift_en)
			dout <= {shift_in, dout[8:1]};
	end

	always_comb
	begin
		shift_out = dout[0];
	end
endmodule