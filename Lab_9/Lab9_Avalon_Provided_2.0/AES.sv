/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input 	logic CLK,
	input  logic RESET,
	input  logic AES_START,
	output logic AES_DONE,
	input  logic [127:0] AES_KEY,
	input  logic [127:0] AES_MSG_ENC,
	output logic [127:0] AES_MSG_DEC
);
	logic [127:0] tempDec, next_tem;
	logic [31:0] mixColOut, word;
	logic [127:0] shiftRowsOut, addRoundKeyOut, InvSubBytes_out, this_round_key;
	logic [1407:0] myKeySchedule;
	logic [4:0] counter;
	logic [1:0] word_sel, ope_sel;
	logic LD_E;

	KeyExpansion myKeyExpansion(.clk(CLK), .Cipherkey(AES_KEY), .KeySchedule(myKeySchedule));
	always_comb begin
		this_round_key = myKeySchedule[127:0];
		unique case (counter)
			5'd10 : this_round_key = myKeySchedule[1407:1280];
			5'd9 : this_round_key = myKeySchedule[1279:1152];
			5'd8 : this_round_key = myKeySchedule[1151:1024];
			5'd7 : this_round_key = myKeySchedule[1023:896];
			5'd6 : this_round_key = myKeySchedule[895:768];
			5'd5 : this_round_key = myKeySchedule[767:640];
			5'd4 : this_round_key = myKeySchedule[639:512];
			5'd3 : this_round_key = myKeySchedule[511:384];
			5'd2 : this_round_key = myKeySchedule[383:256];
			5'd1 : this_round_key = myKeySchedule[255:128];
			5'd0 : this_round_key = myKeySchedule[127:0];
			
		endcase

	end

	always_comb begin
		word = tempDec[31:0];
		unique case (word_sel)
			2'b00: word = tempDec[31:0];
			2'b01: word = tempDec[63:32];
			2'b10: word = tempDec[95:64];
			2'b11: word = tempDec[127:96];
		endcase
	end

	always_comb begin
		next_tem = tempDec;
		unique case (ope_sel)
			2'b00: 	next_tem = addRoundKeyOut;
			2'b01: 	next_tem = shiftRowsOut;
			2'b10: 	next_tem = InvSubBytes_out;
			2'b11: 	begin
						unique case (word_sel)
							2'b00: next_tem[31:0] = mixColOut;
							2'b01: next_tem[63:32] = mixColOut;
							2'b10: next_tem[95:64] = mixColOut;
							2'b11: next_tem[127:96] = mixColOut;
						endcase
					end
		endcase
	end

	addRoundKey myaddRoundKey(.in(tempDec), .key(this_round_key), .out(addRoundKeyOut));
	InvMixColumns myInvMixColumns(.in(word), .out(mixColOut));	
	InvShiftRows myInvShiftRows(.data_in(tempDec), .data_out(shiftRowsOut));

	InvSubBytes sub0(.clk(CLK), .in(tempDec[7:0]), .out(InvSubBytes_out[7:0]));
	InvSubBytes sub1(.clk(CLK), .in(tempDec[15:8]), .out(InvSubBytes_out[15:8]));
	InvSubBytes sub2(.clk(CLK), .in(tempDec[23:16]), .out(InvSubBytes_out[23:16]));
	InvSubBytes sub3(.clk(CLK), .in(tempDec[31:24]), .out(InvSubBytes_out[31:24]));
	InvSubBytes sub4(.clk(CLK), .in(tempDec[39:32]), .out(InvSubBytes_out[39:32]));
	InvSubBytes sub5(.clk(CLK), .in(tempDec[47:40]), .out(InvSubBytes_out[47:40]));
	InvSubBytes sub6(.clk(CLK), .in(tempDec[55:48]), .out(InvSubBytes_out[55:48]));
	InvSubBytes sub7(.clk(CLK), .in(tempDec[63:56]), .out(InvSubBytes_out[63:56]));
	InvSubBytes sub8(.clk(CLK), .in(tempDec[71:64]), .out(InvSubBytes_out[71:64]));
	InvSubBytes sub9(.clk(CLK), .in(tempDec[79:72]), .out(InvSubBytes_out[79:72]));
	InvSubBytes sub10(.clk(CLK), .in(tempDec[87:80]), .out(InvSubBytes_out[87:80]));
	InvSubBytes sub11(.clk(CLK), .in(tempDec[95:88]), .out(InvSubBytes_out[95:88]));
	InvSubBytes sub12(.clk(CLK), .in(tempDec[103:96]), .out(InvSubBytes_out[103:96]));
	InvSubBytes sub13(.clk(CLK), .in(tempDec[111:104]), .out(InvSubBytes_out[111:104]));
	InvSubBytes sub14(.clk(CLK), .in(tempDec[119:112]), .out(InvSubBytes_out[119:112]));
	InvSubBytes sub15(.clk(CLK), .in(tempDec[127:120]), .out(InvSubBytes_out[127:120]));

	// always_ff @(posedge CLK) begin
	// 	if(RESET) begin
	// 		tempDec <=  128'd0;
	// 		LD_E <= 1'b0;
	// 	end 
	// 	else begin
	// 		if (AES_START && ~LD_E) begin
	// 			tempDec <= AES_MSG_ENC;
	// 			LD_E 	<= 1'b1;
	// 		end
	// 		else if (~AES_START) begin
	// 			LD_E 	<= 1'b0;
	// 		end
	// 		else begin 
	// 			tempDec <= next_tem;
	// 			AES_MSG_DEC <= next_tem;
	// 		end

	// 	end 
	// end 

	always_ff @(posedge CLK) begin
		if(RESET) begin
			tempDec <=  128'd0;
			LD_E <= 1'b1;
		end
		if(AES_START && LD_E) begin
			tempDec <= AES_MSG_ENC;
			LD_E <= 0;
		end
		if(AES_START && ~LD_E) begin
			tempDec <= next_tem;
			AES_MSG_DEC <= next_tem;
		end
		if(~AES_START && ~LD_E) begin
			LD_E <= 1;
			tempDec <= next_tem;
			AES_MSG_DEC <= next_tem;
		end
	end 

	AES_controller myController(.*);
	

endmodule


module AES_controller 	(
							input	logic CLK, RESET, AES_START,
							output 	logic AES_DONE,
							output 	logic [4:0]	counter,
							output 	logic [1:0]	word_sel, ope_sel
						);


	enum logic[3:0] {	
						HOLD, addRoundKeyS, InvShiftRowsS, InvSubBytesS, 
						InvMixColumnsS1, InvMixColumnsS2, 
						InvMixColumnsS3, InvMixColumnsS4, 
						DONE
					}curr, next;

	logic [4:0] 	next_counter;
	logic LD_E;

	always_ff @(posedge CLK) begin
		if(RESET) begin
			curr 	<= 	HOLD;
			counter <= 4'd0;
			LD_E <= 1'b1;
		end
		if(AES_START && LD_E) begin
			curr 	<=	next;
			counter <= 	next_counter;
			LD_E <= 0;
		end
		if(AES_START && ~LD_E) begin
			curr 	<=	next;
			counter <= 	next_counter;
		end
		if(~AES_START && ~LD_E) begin
			LD_E <= 1;
			curr 	<=	next;
			counter <= 	next_counter;
		end
	end

	always_comb begin
		
		next 		= 	curr;

		unique case (curr)
			HOLD 			: 	if(AES_START) begin
									next  	= 	addRoundKeyS;
								end 
								else begin
									next 	=	HOLD;
								end 

			addRoundKeyS 	: 	if(counter == 5'd0) begin
									next 	= 	InvShiftRowsS;
								end 
								else if(counter == 5'd10) begin
									next 	= 	DONE;
								end 
								else begin
									next 	= 	InvMixColumnsS1;
								end 

			InvShiftRowsS 	: 		next 	= 	InvSubBytesS;

			InvSubBytesS	: 		next 	= 	addRoundKeyS;

			InvMixColumnsS1 : 		next 	= 	InvMixColumnsS2;

			InvMixColumnsS2 : 		next 	= 	InvMixColumnsS3;

			InvMixColumnsS3 : 		next 	= 	InvMixColumnsS4;

			InvMixColumnsS4 : 		next 	= 	InvShiftRowsS;

			DONE 			: 	if(AES_START) begin
									next 	= 	DONE;
								end 	
								else begin
									next 	= 	HOLD;
								end 
		endcase
	end 

	always_comb begin

		AES_DONE 	= 	1'b0;
		next_counter= 	counter;
		word_sel 	= 	2'b00;
		ope_sel 	= 	2'b00;

		case (curr)
			HOLD 			: 	begin 
									AES_DONE 	= 	1'b0;
									next_counter= 	5'd0;
									word_sel 	= 	2'b00;
									ope_sel 	= 	2'b00;
								end 

			addRoundKeyS 	: 	begin
									if(counter != 10) begin
										next_counter= 	counter + 1;
									end
									ope_sel 	= 	2'b00;
								end 

			InvShiftRowsS 	: 	begin	
									ope_sel 	= 	2'b01;
								end 

			InvSubBytesS	: 	begin 
									ope_sel 	= 	2'b10;
								end 
			InvMixColumnsS1 : 	begin
									ope_sel 	= 	2'b11;
									word_sel	= 	2'b00;
								end 

			InvMixColumnsS2 : 	begin
									ope_sel 	= 	2'b11;
									word_sel	= 	2'b01;
								end 

			InvMixColumnsS3 : 	begin
									ope_sel 	= 	2'b11;
									word_sel	= 	2'b10;
								end 

			InvMixColumnsS4 : 	begin	
									ope_sel 	= 	2'b11;
									word_sel	= 	2'b11;
								end 

			DONE 			: 	begin
									AES_DONE 	= 	1'b1;
								end 
		endcase
	end 
endmodule