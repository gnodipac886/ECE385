module addRoundKey(	input logic [127:0] in, key,
					output logic [127:0] out);
	always_comb begin
		out 	= 	in 	^ 	key;	
	end 
endmodule 
/*
module AddRoundKey (    
    input logic [127:0] in,
    input logic [1407:0] keys,
    input logic [3:0] select,
    output logic [127:0] out
);

always_comb begin
    unique case (select)
        4'd10 :
            out = in ^ keys[127:0];
        4'd9 :
            out = in ^ keys[255:128];
        4'd8 :
            out = in ^ keys[383:256];
        4'd7 :
            out = in ^ keys[511:384];
        4'd6 :
            out = in ^ keys[639:512];
        4'd5 :
            out = in ^ keys[767:640];
        4'd4 :
            out = in ^ keys[895:768];
        4'd3 :
            out = in ^ keys[1023:896];
        4'd2 :
            out = in ^ keys[1151:1024];
        4'd1 :
            out = in ^ keys[1279:1152];
        4'd0 :
            out = in ^ keys[1407:1280];
        default :
            out = 128'd0;
    endcase

end

endmodule*/