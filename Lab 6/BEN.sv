module BEN(
			input logic [15:0] data_in,
			input logic LD_CC, LD_BEN, clk, Reset,
			input logic [2:0] IR_in,
			output logic BEN_out
			);
	logic n, z, p, logic_out, n_out, z_out, p_out;

	always_ff @ (posedge clk) begin
		if(Reset)
			BEN_out <= 1'b0;
		else if(LD_BEN)
			BEN_out <= ((IR_in & {n_out, z_out, p_out}) != 3'b000);
		if(LD_CC) begin
			n_out <= n;
			z_out <= z;
			p_out <= p;
		end 
	end 
	
	
	always_comb begin
		if(data_in == 16'h0000) begin
			n = 1'b0;
			z = 1'b1;
			p = 1'b0;
		end 
		else if(data_in[15] == 1'b1) begin
			n = 1'b1;
			z = 1'b0;
			p = 1'b0;
		end 
		else if(data_in[15] == 1'b0 && data_in != 16'h0000) begin
			n = 1'b0;
			z = 1'b0;
			p = 1'b1;
		end 
		else begin
			n = 1'bZ;
			z = 1'bZ;
			p = 1'bZ;
		end 
	end 
endmodule 