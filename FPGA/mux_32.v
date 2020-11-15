module mux_32 (outM32, selectM32, inM320, inM321, inM322, inM323, inM324, inM325, inM326, inM327, inM328, inM329, inM3210, inM3211, inM3212, inM3213, inM3214, inM3215, inM3216, inM3217, inM3218, inM3219, inM3220, inM3221, inM3222, inM3223, inM3224, inM3225, inM3226, inM3227, inM3228, inM3229, inM3230, inM3231);

	input [4:0] selectM32;
	input [31:0] inM320, inM321, inM322, inM323, inM324, inM325, inM326, inM327, inM328, inM329, inM3210, inM3211, inM3212, inM3213, inM3214, inM3215, inM3216, inM3217, inM3218, inM3219, inM3220, inM3221, inM3222, inM3223, inM3224, inM3225, inM3226, inM3227, inM3228, inM3229, inM3230, inM3231;
	output[31:0] outM32;
	wire [31:0] w1M32, w2M32, w3M32, w4M32;

	mux_8 first_one(w1M32, selectM32[2:0], inM320, inM321, inM322, inM323, inM324, inM325, inM326, inM327);
	mux_8 first_two(w2M32, selectM32[2:0], inM328, inM329, inM3210, inM3211, inM3212, inM3213, inM3214, inM3215);
	mux_8 first_three(w3M32, selectM32[2:0], inM3216, inM3217, inM3218, inM3219, inM3220, inM3221, inM3222, inM3223);
	mux_8 first_four(w4M32, selectM32[2:0], inM3224, inM3225, inM3226, inM3227, inM3228, inM3229, inM3230, inM3231);
	mux_4 second(outM32, selectM32[4:3], w1M32, w2M32, w3M32, w4M32);
endmodule
