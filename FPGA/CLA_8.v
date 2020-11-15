module CLA_8(S8, X8, Y8, Cin8, G, P);
	input [7:0] X8, Y8;
	input Cin8;
	output [7:0] S8;
	output P, G;
	wire gw0, gw1, gw2, gw3, gw4, gw5, gw6, G, P;
	wire [7:0] g, p;

	wire c1w;
	wire c1;

	wire [1:0] c2w;
	wire c2;

	wire [2:0] c3w;
	wire c3;

	wire [3:0] c4w;
	wire c4;

	wire [4:0] c5w;
	wire c5;

	wire [5:0] c6w;
	wire c6;

	wire [6:0] c7w;
	wire c7;


	// Calulate little g's
	and a(g[0], X8[0], Y8[0]);
	and b(g[1], X8[1], Y8[1]);
	and c(g[2], X8[2], Y8[2]);
	and d(g[3], X8[3], Y8[3]);
	and e(g[4], X8[4], Y8[4]);
	and f(g[5], X8[5], Y8[5]);
	and gggg(g[6], X8[6], Y8[6]);
	and h(g[7], X8[7], Y8[7]);

	// Calulate little p's
	or i(p[0], X8[0], Y8[0]);
	or j(p[1], X8[1], Y8[1]);
	or k(p[2], X8[2], Y8[2]);
	or l(p[3], X8[3], Y8[3]);
	or m(p[4], X8[4], Y8[4]);
	or n(p[5], X8[5], Y8[5]);
	or o(p[6], X8[6], Y8[6]);
	or pppp(p[7], X8[7], Y8[7]);

	// Calulate c1
	and q(c1w, Cin8, p[0]);
	or r(c1, c1w, g[0]);

	// Calulate c2
	and s(c2w[0], Cin8, p[0], p[1]);
	and t(c2w[1], g[0], p[1]);
	or u(c2, c2w[0], c2w[1], g[1]);

	// Calulate c3
	and v(c3w[0], Cin8, p[0], p[1], p[2]);
	and w(c3w[1], g[0], p[1], p[2]);
	and x(c3w[2], g[1], p[2]);
	or y(c3, c3w[0], c3w[1], c3w[2], g[2]);

	// Calulate c4
	and z(c4w[0], Cin8, p[0], p[1], p[2], p[3]);
	and aa(c4w[1], g[0], p[1], p[2], p[3]);
	and bb(c4w[2], g[1], p[2], p[3]);
	and cc(c4w[3], g[2], p[3]);
	or dd(c4, c4w[0], c4w[1], c4w[2], c4w[3], g[3]);

	// Calulate c5
	and ee(c5w[0], Cin8, p[0], p[1], p[2], p[3], p[4]);
	and ff(c5w[1], g[0], p[1], p[2], p[3], p[4]);
	and gg(c5w[2], g[1], p[2], p[3], p[4]);
	and hh(c5w[3], g[2], p[3], p[4]);
	and ii(c5w[4], g[3], p[4]);
	or jj(c5, c5w[0], c5w[1], c5w[2], c5w[3], c5w[4], g[4]);

	// Calulate c6
	and kk(c6w[0], Cin8, p[0], p[1], p[2], p[3], p[4], p[5]);
	and ll(c6w[1], g[0], p[1], p[2], p[3], p[4], p[5]);
	and mm(c6w[2], g[1], p[2], p[3], p[4], p[5]);
	and nn(c6w[3], g[2], p[3], p[4], p[5]);
	and oo(c6w[4], g[3], p[4], p[5]);
	and pp(c6w[5], g[4], p[5]);
	or qq(c6, c6w[0], c6w[1], c6w[2], c6w[3], c6w[4], c6w[5], g[5]);

	// Calulate c7
	and rr(c7w[0], Cin8, p[0], p[1], p[2], p[3], p[4], p[5], p[6]);
	and ss(c7w[1], g[0], p[1], p[2], p[3], p[4], p[5], p[6]);
	and tt(c7w[2], g[1], p[2], p[3], p[4], p[5], p[6]);
	and uu(c7w[3], g[2], p[3], p[4], p[5], p[6]);
	and vv(c7w[4], g[3], p[4], p[5], p[6]);
	and ww(c7w[5], g[4], p[5], p[6]);
	and xx(c7w[6], g[5], p[6]);
	or yy(c7, c7w[0], c7w[1], c7w[2], c7w[3], c7w[4], c7w[5], c7w[6], g[6]);

	// Calculate P
	and zz(P, p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);

	// Calculate G	
	and aaa(gw0, g[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
	and bbb(gw1, g[1], p[2], p[3], p[4], p[5], p[6], p[7]);
	and ccc(gw2, g[2], p[3], p[4], p[5], p[6], p[7]);
	and ddd(gw3, g[3], p[4], p[5], p[6], p[7]);
	and eee(gw4, g[4], p[5], p[6], p[7]);
	and fff(gw5, g[5], p[6], p[7]);
	and ggg(gw6, g[6], p[7]);
	or hhh(G, g[7], gw6, gw5, gw4, gw3, gw2, gw1, gw0);

	// Calculate S8ums8
	xor iii(S8[0], Cin8, X8[0], Y8[0]);
	xor jjj(S8[1], c1, X8[1], Y8[1]);
	xor lll(S8[2], c2, X8[2], Y8[2]);
	xor mmm(S8[3], c3, X8[3], Y8[3]);
	xor nnn(S8[4], c4, X8[4], Y8[4]);
	xor ooo(S8[5], c5, X8[5], Y8[5]);
	xor ppp(S8[6], c6, X8[6], Y8[6]);
	xor qqq(S8[7], c7, X8[7], Y8[7]);

	// // Calculate Cout8
	// and rrr(w1C8, P, Cin8);
	// or sss(Cout8, w1C8, G);


endmodule
