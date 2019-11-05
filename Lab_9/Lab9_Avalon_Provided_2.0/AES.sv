/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input	 logic CLK,
	input  logic RESET,
	input  logic AES_START,
	output logic AES_DONE,
	input  logic [127:0] AES_KEY,
	input  logic [127:0] AES_MSG_ENC,
	output logic [127:0] AES_MSG_DEC
);
	logic [127:0] tempDec;
	logic [31:0] mixColIn, mixColOut;
	logic [127:0] shiftRowsIn, shiftRowsOut, addRoundKeyIn, addRoundKeyKey, addRoundKeyOut;
	logic [1407:0] myKeySchedule;

	addRoundKey myaddRoundKey(.in(addRoundKeyIn), .key(addRoundKeyKey), .out(addRoundKeyOut));

	KeyExpansion myKeyExpansion(.clk(CLK), .Cipherkey(AES_KEY), .KeySchedule(myKeySchedule));

	InvMixColumns myInvMixColumns(.in(mixColIn), .out(mixColOut));
	
	InvShiftRows myInvShiftRows(.data_in(shiftRowsIn), .data_out(shiftRowsOut));

	InvSubBytes myInvSubBytes[15:0](.clk(CLK), .in(), .out())


	enum logic[2:0] {HOLD, addRoundKeyS, InvShiftRowsS, InvSubBytesS, InvMixColumnsS, DONE} curr, next;

	always_ff @(posedge CLK or posedge RESET) begin
		if(RESET) begin
			tempDec <=  128'd0;
			curr 	<= 	HOLD;
		end 
		else begin
			curr 	<= 	next;
		end 
	end 

	always_comb begin

	end 

endmodule
