module control(input logic clearA_loadB, reset, execute, clk, bout,
				output logic Shift_en, Sub_en, clr_ld);
	enum logic [2:0] {start, add, shift, sub, done} state, next;

	logic [2:0] count;

	always_ff @(posedge clk or posedge reset) begin
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
					Shift_en <= 1'b0;
					Sub_en <= 1'b0;
					clr_ld <= 1'b1;
				end
				else if (execute == 1) begin
					Shift_en <= 1'b0;
					Sub_en <= 1'b0;
					clr_ld <= 1'b0;
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
				Shift_en <= 1'b1;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				count = count + 1;
				if(bout == 1 && count == 3'b111)
					next = sub;
				else if (bout == 1 && count != 3'b111)
					next = add;
				else if (bout == 0 && count == 3'b111)
					next = done;
				else
					next = shift;
			end

			sub : begin
				//@@add code here
				//can use XOR/XNOR to flip the bits
			end

			done : begin
				Shift_en <= 1'b1;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				next = start;
			end

			default: ;
		endcase
	end
endmodule 
