module reg_16(	input logic clk, reset, load, shift_en, shift_in
						input logic [15:0] din
						output logic shift_out
						output logic [15:0] dout);
	always_ff @ (posedge clk)
	begin
		if(reset)
			dout <= 16'h0000;
		else if (load)
			dout <= din;
		else if(shift_en)
			dout <= {shift_in, dout[15:1]};
	end

	always_comb
	begin
		shift_out = dout[0];
	end
endmodule