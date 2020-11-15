module divider (dividend, divisor, start, reset, clk, quotient, exception, done);
	input [31:0] dividend, divisor;
	input start, reset, clk;
	
	output [31:0] quotient;
	output exception, done;
	
	reg [31:0] Q, quotient;
   reg [63:0] dividend_copy, divisor_copy, diff;
   wire [31:0] remainder = dividend_copy[31:0];

   reg [5:0] count;
	
	reg busy, done, exception;
	reg dividend_neg, divisor_neg;
	
	wire divisor_zero = ~(divisor[0 ] || divisor[1 ] || divisor[2 ] || divisor[3 ] ||
	                      divisor[4 ] || divisor[5 ] || divisor[6 ] || divisor[7 ] ||
								 divisor[8 ] || divisor[9 ] || divisor[10] || divisor[11] ||
								 divisor[12] || divisor[13] || divisor[14] || divisor[15] ||
								 divisor[16] || divisor[17] || divisor[18] || divisor[19] ||
								 divisor[20] || divisor[21] || divisor[22] || divisor[23] ||
								 divisor[24] || divisor[25] || divisor[26] || divisor[27] ||
								 divisor[28] || divisor[29] || divisor[30] || divisor[31]);

   initial begin 
		count = 32;
		busy = 0;
		done = 0;
		exception = 0;
		divisor_neg = 0;
		dividend_neg = 0;
	end

	always @(posedge clk) begin
		if (reset && busy) begin
			busy = 0;
			count = 32;
		end
	
		if (done) begin
			count = 32;
			done = 0;
			exception = 0;
		end
	
		if (start) begin
			if (divisor_zero) begin
				busy = 1;
				count = 2;
				exception = 1;
			end else begin
				busy = 1;
				count = 6'd32;
				Q = 64'b0;
				
				if (dividend[31]) begin
					dividend_copy = {32'b0, -dividend};
					dividend_neg = 1;
				end else begin
					dividend_copy = {32'b0, dividend};
					dividend_neg = 0;
				end
				
				if (divisor[31]) begin
					divisor_copy = {1'b0, -divisor, 31'b0};
					divisor_neg = 1;
				end else begin
					divisor_copy = {1'b0, divisor, 31'b0};
					divisor_neg = 0;
				end
			end
     end else if (busy) begin
        diff = dividend_copy - divisor_copy;
        Q = {Q[30:0], ~diff[63] };
		  if (divisor_neg ^ dividend_neg) begin
				quotient = -Q;
			end else begin
				quotient = Q;
			end
        divisor_copy = {1'b0, divisor_copy[63:1] };
        if (!diff[63]) dividend_copy = diff;
        count = count - 1;
     end
	  
	  if (count == 0) begin
			busy = 0;
			divisor_neg = 0;
			dividend_neg = 0;
			done = 1;
		end
	end
	
endmodule