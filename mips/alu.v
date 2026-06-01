
module alu( 
input [31:0]a,
input [31:0]b,
input [31:0]shamt,
input [2:0]aluop,
input [1:0]shif_en,
input of_en,
output reg [31:0]dout,
output zero,
output  overf
);


    
wire [31:0] sub;
wire [31:0] sum;
wire [31:0] and_n,or_n,xor_n,nor_n;
wire [31:0] slt,sltu;
wire cout,slt0;
wire cof;

//add,sub,slt,sltu
assign sub=aluop[2]?(~b):b;

add32 add01(.a(a),.b(sub),.cin(aluop[2]),.sum(sum),.cout(cout),.cof(cof));   

assign slt0=(a[31]^b[31])?a[31]:(~cout);
assign slt={31'b0,slt0};
assign sltu={31'b0,~cout};

//逻辑运算
assign and_n=a&b;
assign or_n=a|b;
assign xor_n=a^b;
assign nor_n=~(a|b);
//位移
wire [31:0]din,shf,shfout,shfin;
wire [31:0]llout0,llout1;
wire [31:0]lui;
wire [1:0]sel;
wire [31:0]sout;


assign sel={1'b0,aluop[0]};
assign shf=(aluop[2])?a:shamt;
assign shfin=shf[4:0];  

bit_severser b01(.din(b),.dout(llout0));

assign din=(aluop[1])?b:llout0;

shift shf1(.din(din),.shift(shfin),.sel(sel),.dout(shfout));

bit_severser b02(.din(shfout),.dout(llout1));

assign sout=(aluop[1])?shfout:llout1;
//lui
assign lui={b[15:0],{16{1'b0}}};


reg [31:0] res;
always @(*) begin


case(aluop)
    3'b000: res=and_n;   //and
    3'b001: res=or_n;    //or
    3'b010: res=sum;     //ADD
    3'b011: res=xor_n;   //XOR 
    3'b100: res=nor_n;   //nor
    3'b110: res=sum;     //SUB
    3'b101: res=sltu;    //sltu
    3'b111: res=slt;     //slt 
    default: res=32'd0;
endcase

end


always@(*)begin
case(shif_en)
    2'b00:dout=res;
    2'b01:dout=sout;
    2'b10:dout=lui;
    default:dout=res;   
endcase
end

assign zero=(dout==32'b0);

wire addover;
assign addover= cof^cout;
assign overf=of_en?addover:1'b0;

endmodule
