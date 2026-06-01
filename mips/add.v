
module add(
input [31:0] a,
input [31:0] b,
input cin,
output [31:0] sum,
output cout
    );

wire c_x;    
wire [31:0]p;
wire [31:0]g;
wire [31:0]c;

wire [9:0]P;
wire [9:0]G;

assign c[0]=cin;
assign p[31:0]=a^b;
assign g[31:0]=a&b;

cla u00(.g(g[3:0]),.p(p[3:0]),.cin(c[0]),.P(P[0]),.G(G[0]),.c(c[3:1]));
cla u01(.g(g[7:4]),.p(p[7:4]),.cin(c[4]),.P(P[1]),.G(G[1]),.c(c[7:5]));
cla u02(.g(g[11:8]),.p(p[11:8]),.cin(c[8]),.P(P[2]),.G(G[2]),.c(c[11:9]));
cla u03(.g(g[15:12]),.p(p[15:12]),.cin(c[12]),.P(P[3]),.G(G[3]),.c(c[15:13]));
cla u04(.g(G[3:0]),.p(P[3:0]),.cin(c[0]),.P(P[8]),.G(G[8]),.c({c[12],c[8],c[4]}));

cla u10(.g(g[19:16]),.p(p[19:16]),.cin(c[16]),.P(P[4]),.G(G[4]),.c(c[19:17]));
cla u11(.g(g[23:20]),.p(p[23:20]),.cin(c[20]),.P(P[5]),.G(G[5]),.c(c[23:21]));
cla u12(.g(g[27:24]),.p(p[27:24]),.cin(c[24]),.P(P[6]),.G(G[6]),.c(c[27:25]));
cla u13(.g(g[31:28]),.p(p[31:28]),.cin(c[28]),.P(P[7]),.G(G[7]),.c(c[31:29]));
cla u14(.g(G[7:4]),.p(P[7:4]),.cin(c[16]),.P(P[9]),.G(G[9]),.c({c[28],c[24],c[20]}));

cla u2(.g({2'b00,G[9:8]}),.p({2'b00,P[9:8]}),.cin(c[0]),.P(),.G(),.c({c_x,cout,c[16]}));
//assign cout=c[31];
assign sum[31:0]=c^p; 
endmodule

