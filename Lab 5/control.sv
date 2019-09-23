module control(input logic clearA_loadB, reset, execute, Clk, bout,
				input logic [8:0] mand
				output logic Shift_en, resetA, resetB, loadA, loadB);
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
					Shift_en = 1'b0;
					resetA = 1'b1;
					resetB = 1'b0;
					loadA = 1'b0;
					loadB = 1'b1;
				end
				else if (reset == 1) begin
					Shift_en = 1'b0;
					resetA = 1'b1;
					resetB = 1'b1;
					loadA = 1'b0;
					loadB = 1'b0;
				end
				else if (execute == 1) begin
					Shift_en = 1'b0;
					resetA = 1'b0;
					resetB = 1'b0;
					loadA = 1'b0;
					loadB = 1'b1;
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
				count = count + 1;
				Shift_en = 1'b1;
				resetA = 1'b0;
				resetB = 1'b0;
				loadA = 1'b0;
				loadB = 1'b0;
				if(bout == 1 && count == 3'b111)
					next = sub;
				else if (bout == 1 && count != 3'b111)
					next = add;
				else if (bout == 0 && count == 3'b111)
					next = start;
				else
					next = shift;
			end

			sub : begin
				//@@add code here
				//can use XOR/XNOR to flip the bits
			end

			default: ;
		endcase
	end
endmodule 


module multiplier();
	logic shoutA;
	logic [8:0] doutA, sumA;
	logic [7:0] doutB;

	carry_select_adder_9bit adder1(.A(mand), 
								   .B(), 
								   .Sum(.sumA), 
								   .CO());

	shift_reg_9bit regA(
						.clk(Clk), 
						.reset(resetA), 
						.load(loadA), 
						.shift_en(Shift_en), 
						.shift_in(), 
						.din(sumA), 
						.shift_out(shoutA), 
						.dout(doutA)
						); 
						//what do we do with this empty connection?

	shift_reg_8bit regB(
						.clk(Clk), 
						.reset(resetB), 
						.load(loadB), 
						.shift_en(Shift_en), 
						.shift_in(shoutA), 
						.din(), 
						.shift_out(bout), 
						.dout(doutB)
						); //^^^^^^

endmodule