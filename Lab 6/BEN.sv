module BEN(
			input logic [15:0] data_in,
			input logic LD_CC, LD_BEN, clk, Reset,
			input logic [2:0] IR_in,
			output logic BEN_out
			);
	logic n, z, p, logic_out;

	always_ff @ (posedge clk) begin
		if(Reset)
			BEN_out <= 1'b0;
		else if(LD_BEN)
			BEN_out <= ((IR_in & {n, z, p}) != 3'b000);
	end 
	always_comb begin
		if(LD_CC) begin
			if(data_in == 16'h0000) begin
				n <= 1'b0;
				z <= 1'b1;
				p <= 1'b0;
			end 
			else if(data_in[15] == 1'b1) begin
				n <= 1'b1;
				z <= 1'b0;
				p <= 1'b0;
			end 
			else if(data_in[15] == 1'b0 && data_in != 16'h0000) begin
				n <= 1'b0;
				z <= 1'b0;
				p <= 1'b1;
			end 
		end
	end 
endmodule 