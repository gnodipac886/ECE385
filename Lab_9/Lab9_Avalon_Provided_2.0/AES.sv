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
	logic [127:0] shiftRowsIn, shiftRowsOut, addRoundKeyIn, addRoundKeyKey, addRoundKeyOut, ;
	logic [1407:0] myKeySchedule;

	KeyExpansion myKeyExpansion(.clk(CLK), .Cipherkey(AES_KEY), .KeySchedule(myKeySchedule));

	/*
	MUX layout
		0	:	InvShiftRows
		1 	:	InvSubBytes
		2 	: 	addRoundKey
		3 	: 	InvMixColumns
	*/

	addRoundKey myaddRoundKey(.in(addRoundKeyIn), .key(addRoundKeyKey), .out(addRoundKeyOut));
	InvMixColumns myInvMixColumns(.in(mixColIn), .out(mixColOut));	
	InvShiftRows myInvShiftRows(.data_in(shiftRowsIn), .data_out(shiftRowsOut));

	InvSubBytes sub0(.clk(CLK), .in(tempDec[7:0]), .out());

	mux41_128bit mymux41_128bit(
								.in0(shiftRowsOut),
								.in1(),
								.in2(addRoundKeyOut), 
								.in3(),
								.sel(),
								.out()
								);

	enum logic[2:0] {HOLD, addRoundKeyS, InvShiftRowsS, InvSubBytesS, InvMixColumnsS1, InvMixColumnsS2, InvMixColumnsS3, InvMixColumnsS4, DONE} curr, next;

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
