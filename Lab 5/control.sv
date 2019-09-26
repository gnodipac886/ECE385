	module control(input logic clearA_loadB, reset, execute, clk, bout,
				output logic Shift_en, Sub_en, clr_ld, addsub, clearA);
	enum logic [4:0] {start, load,
					  add1, shift1,
					  add2, shift2,
					  add3, shift3,
					  add4, shift4,
					  add5, shift5,
					  add6, shift6,
					  add7, shift7,
					  add8, shift8,
					  restart, clear
					  } state, next;

	always_ff @(posedge clk or posedge reset) begin
		if(reset)
			state <= start;
		else
			state <= next;
	end

	always_comb begin
		next = state;

		unique case (state)
			start 	: 	if(clearA_loadB)
							next = load;
						else if(execute)
							next = add1;

			load 	: 	next = start;

			add1	: 	next = shift1;
			shift1 	: 	next = add2;

			add2	: 	next = shift2;
			shift2 	: 	next = add3;
			
			add3	: 	next = shift3;
			shift3 	: 	next = add4;
			
			add4	: 	next = shift4;
			shift4 	: 	next = add5;
			
			add5	: 	next = shift5;
			shift5 	: 	next = add6;
			
			add6	: 	next = shift6;
			shift6 	: 	next = add7;
			
			add7	: 	next = shift7;
			shift7 	: 	next = add8;
			
			add8	: 	next = shift8;
			shift8 	: 	next = restart;

			restart : 	if(execute)
							next = clear;

			clear 	: 	next = add1;
		endcase
	end 

	always_comb begin
		case(state)
			start: begin
				Shift_en <= 1'b0;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				addsub <= 1'b0;
				clearA <= 1'b0;
			end 

			load: begin
				Shift_en <= 1'b0;
				Sub_en <= 1'b0;
				clr_ld <= 1'b1;
				addsub <= 1'b0;
				clearA <= 1'b0;
			end 

			add1,
			add2,
			add3,
			add4,
			add5,
			add6,
			add7 : begin
				Shift_en <= 1'b0;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				clearA <= 1'b0;
				if(bout)
					addsub <= 1'b1;
				else
					addsub <= 1'b0;
			end 

			add8 : begin
				Shift_en <= 1'b0;
				clr_ld <= 1'b0;
				clearA <= 1'b0;
				if (bout) begin
					addsub <= 1'b1;
					Sub_en <= 1'b1;
				end 
				else begin
					addsub <= 1'b0;
					Sub_en <= 1'b0;
				end
			end

			shift1,
			shift2,
			shift3,
			shift4,
			shift5,
			shift6,
			shift7,
			shift8 : begin
				Shift_en <= 1'b1;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				addsub <= 1'b0;
				clearA <= 1'b0;
			end
			restart : begin
				Shift_en <= 1'b0;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				addsub <= 1'b0;
				clearA <= 1'b0;
			end

			clear : begin
				Shift_en <= 1'b0;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				addsub <= 1'b0;
				clearA <= 1'b1;

			end

		endcase 
	end

	endmodule 

	/*count = 3'b000;

		unique case (state)
			

			start : begin
				count = 3'b000;
				if(clearA_loadB == 1) begin
					Shift_en <= 1'b0;
					Sub_en <= 1'b0;
					clr_ld <= 1'b1;
					addsub <= 1'b0;
				end
				else if (execute == 1) begin
					Shift_en <= 1'b0;
					Sub_en <= 1'b0;
					clr_ld <= 1'b0;
					addsub <= 1'b0;
					if(bout == 1)
						next = add;
					else
						next = shift;
				end
			end

			add : begin
				//@@add code here
				Shift_en <= 1'b0;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				addsub <= 1'b1;
			end

			shift : begin
				//@@add code here
				Shift_en <= 1'b1;
				Sub_en <= 1'b0;
				clr_ld <= 1'b0;
				addsub <= 1'b0;
				count = count + 1;
				if(bout == 1 && count == 3'b111)
					next = sub;
				else if (bout == 1 && count != 3'b111)
					next = add;
				else if (count == 3'b000)
					next = restart;
				else
					next = shift;
			end

			sub : begin
				//@@add code here
				Shift_en <= 1'b0;
				Sub_en <= 1'b1;
				clr_ld <= 1'b0;
				addsub <= 1'b1;
			end

			restart : begin
				count = 3'b000;
				if(clearA_loadB == 1) begin
					Shift_en <= 1'b0;
					Sub_en <= 1'b0;
					clr_ld <= 1'b1;
					addsub <= 1'b0;
				end
				else if (execute == 1) begin
					Shift_en <= 1'b0;
					Sub_en <= 1'b0;
					clr_ld <= 1'b1;
					addsub <= 1'b0;
					if(bout == 1)
						next = add;
					else
						next = shift;
				end
			end

		endcase */
