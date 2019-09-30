module full_adder(input logic a, b, cin, 
				  output logic  sum, cout);

always_comb
begin
	sum = a ^ b ^ cin;
	cout = (a & b) | (b & cin) | (a & cin);
end
endmodule