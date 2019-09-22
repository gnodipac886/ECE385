module control(input logic clearA_loadB, reset, execute, clk, bout,
				output logic shift, clearA, clearB, loadA, loadB);
	enum logic [1:0] {start, add, shift, sub} state, next;

	logic [2:0] count;

	always_ff @(posedge clk) begin
		if(reset) begin
			state <= start;
		else
			state <= next;
	end

	always_comb begin
		case (state)
			next = state;
			count = 3'b000;

			start : begin
				count = 3'b000;
				if(clearA_loadB == 1) begin
					clearA = 1;
					loadB = 1;
				end
				else if (reset == 1) begin
					clearA = 1;
					clearB = 1;
				end
				else if (execute == 1) begin
					if(bout == 1)
						next = add;
					else
						next = shift;
				end
			end

			add : begin
				//@@add code here
			end

			shift : begin
				//@@add code here
			end

			sub : begin
				//@@add code here
			end

			default: ;
		endcase
	end


endmodule