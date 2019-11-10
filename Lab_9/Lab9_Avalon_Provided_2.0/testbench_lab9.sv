module testbench_lab9();

timeunit 10ns;

timeprecision 1ns;

logic CLK = 0;
logic RESET;
logic AES_START;
logic AES_DONE;
logic [127:0] AES_KEY;
logic [127:0] AES_MSG_ENC;
logic [127:0] AES_MSG_DEC;


AES aes0(.*);

always begin : CLOCK_GENERATION

#1 CLK = ~CLK;
end

initial begin : CLOCK_INITIALIZATION

   CLK = 0;
	
	end
	
initial begin : TEST_VECTORS

    AES_START = 0;
    AES_KEY = 128'h000102030405060708090a0b0c0d0e0f;
    AES_MSG_ENC = 128'hdaec3055df058e1c39e814ea76f6747e;

    RESET = 1;

    #2 RESET = 0;
	 
	 

    #20 AES_START = 1;
	 #4	AES_START = 0;
	 

 

 end
 
endmodule 


