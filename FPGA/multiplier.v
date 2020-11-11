module multiplier(mc, mp, start, reset, clk, prod, overflow, done);
	input [31:0] mc, mp;
	input start, reset, clk;
	
	output [31:0] prod;
	output overflow, done;

	reg [64:0] A, S, P;
	reg [5:0] count;
	wire P1, P0;
	assign P1 = P[1];
	assign P0 = P[0];
	
	wire [63:0] mc_extend, mp_extend;
	assign mc_extend = {mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31],
	                    mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31],
	                    mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31],
	                    mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc};
	
	assign mp_extend = {mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31],
	                    mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31],
	                    mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31],
	                    mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp};
	
	reg [63:0] real_prod;
	
	reg busy, done;
	
	initial begin
		busy = 0;
		done = 0;
		count = 0;
	end
	
	always @(posedge clk) begin
		if (reset && busy) begin
			busy = 0;
			count <= 0;
		end
		
		if (start) begin
			busy = 1;
			
			A[64:33] <= mc;
			A[32:0] <= 33'b0;
			
			S[64:33] <= -mc;
			S[32:0] <= 33'b0;
			
			P[64:33] <= 32'b0;
			P[32:1] <= mp;
			P[0] = 1'b0;
			
			real_prod <= mc_extend*mp_extend;
			
			count <= 6'b0;
		end else if (busy) begin
			case ({P1, P0})
				2'b0_1 : P <= (P + A) >>> 1;
				2'b1_0 : P <= (P + S) >>> 1;
				default: P <= P >>> 1;
			endcase
			count <= count + 1'b1;
		end
		
		if (done) begin
			done = 0;
		end
		
		if (count == 31) begin
			busy = 0;
			done = 1;
		end
		
	
		
	end
	
	wire n_overflow, o_overflow;
	
	nand (n_overflow, real_prod[31], real_prod[32], real_prod[33], real_prod[34], real_prod[35], real_prod[36], real_prod[37], real_prod[38], real_prod[39],
                     real_prod[40], real_prod[41], real_prod[42], real_prod[43], real_prod[44], real_prod[45], real_prod[46], real_prod[47],
							real_prod[48], real_prod[49], real_prod[50], real_prod[51], real_prod[52], real_prod[53], real_prod[54], real_prod[55],
							real_prod[56], real_prod[57], real_prod[58], real_prod[59], real_prod[60], real_prod[61], real_prod[62], real_prod[63]);
	
	or (o_overflow, real_prod[31], real_prod[32], real_prod[33], real_prod[34], real_prod[35], real_prod[36], real_prod[37], real_prod[38], real_prod[39],
                   real_prod[40], real_prod[41], real_prod[42], real_prod[43], real_prod[44], real_prod[45], real_prod[46], real_prod[47],
						 real_prod[48], real_prod[49], real_prod[50], real_prod[51], real_prod[52], real_prod[53], real_prod[54], real_prod[55],
						 real_prod[56], real_prod[57], real_prod[58], real_prod[59], real_prod[60], real_prod[61], real_prod[62], real_prod[63]);
	
	assign prod = P[32:1];
	and (overflow, n_overflow, o_overflow);
endmodule