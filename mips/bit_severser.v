
module bit_severser(
input [31:0]din,
output [31:0] dout
);
wire [31:0]s0,s1,s2,s3,s4;


//第一级
assign s0[0]=din[1];assign s0[1]=din[0];
assign s0[2]=din[3];assign s0[3]=din[2];
assign s0[4]=din[5];assign s0[5]=din[4];
assign s0[6]=din[7];assign s0[7]=din[6];
assign s0[8]=din[9];assign s0[9]=din[8];
assign s0[10]=din[11];assign s0[11]=din[10];
assign s0[12]=din[13];assign s0[13]=din[12];
assign s0[14]=din[15];assign s0[15]=din[14];
assign s0[16]=din[17];assign s0[17]=din[16];
assign s0[18]=din[19];assign s0[19]=din[18];
assign s0[20]=din[21];assign s0[21]=din[20];
assign s0[22]=din[23];assign s0[23]=din[22];
assign s0[24]=din[25];assign s0[25]=din[24];
assign s0[26]=din[27];assign s0[27]=din[26];
assign s0[28]=din[29];assign s0[29]=din[28];
assign s0[30]=din[31];assign s0[31]=din[30];

//第2级
assign s1[1:0]=s0[3:2];assign s1[3:2]=s0[1:0];
assign s1[5:4]=s0[7:6];assign s1[7:6]=s0[5:4];
assign s1[9:8]=s0[11:10];assign s1[11:10]=s0[9:8];
assign s1[13:12]=s0[15:14];assign s1[15:14]=s0[13:12];
assign s1[17:16]=s0[19:18];assign s1[19:18]=s0[17:16];
assign s1[21:20]=s0[23:22];assign s1[23:22]=s0[21:20];
assign s1[25:24]=s0[27:26];assign s1[27:26]=s0[25:24];
assign s1[29:28]=s0[31:30];assign s1[31:30]=s0[29:28];

//第3级

assign s2[3:0]=s1[7:4];assign s2[7:4]=s1[3:0];
assign s2[11:8]=s1[15:12];assign s2[15:12]=s1[11:8];
assign s2[19:16]=s1[23:20];assign s2[23:20]=s1[19:16];
assign s2[27:24]=s1[31:28];assign s2[31:28]=s1[27:24];

//第4级
assign s3[7:0]=s2[15:8];assign s3[15:8]=s2[7:0];
assign s3[23:16]=s2[31:24];assign s3[31:24]=s2[23:16];

//第5级
assign s4[15:0]=s3[31:16];assign s4[31:16]=s3[15:0];

assign dout=s4;


endmodule
