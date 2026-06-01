`timescale 1ns / 1ps
module cla(
input [3:0] g,
input [3:0] p,
input cin,
output P,
output G,
output [2:0] c
    );


assign c[0]=g[0]|(p[0]&cin);
assign c[1]=g[1]|(p[1]&g[0])|(p[1]&p[0]&cin);
assign c[2]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&cin);

assign G=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0]);
assign P=p[3]&p[2]&p[1]&p[0];

endmodule
