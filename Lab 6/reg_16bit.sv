module reg_16bit(	
				input logic clk, reset, load,
				input logic [15:0] din,
				output logic [15:0] dout
			  );
	always_ff @ (posedge clk)
	begin
		if(reset)
			dout <= 16'h0000;
		else if (load)
			dout <= din;
	end
endmodule