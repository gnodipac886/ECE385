module flip_flop_mod(input logic clk, din, load, reset
					output logic dout);

	logic real_din;
	always_ff @ (posedge clk)
	begin
		dout = real_din;
	end

	always_comb begin
		if(reset)
			real_din = 1'b0;
		else if(load)
			real_din = din;
		else
			real_din = dout;
	end 

endmodule