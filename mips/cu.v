
module cu(
input [5:0]op,
input [5:0]funct,

output reg [2:0]aluop,

output of_en,//溢出检测
output reg [1:0]shif_en,//位移使能 00运算 01位移 10lui
output reg imm,
output reg signext,//有符号扩展0有符号 1无符号
output reg rw,//寄存器组写入使能
output memread,
output memwrite,
output bne,
output rbranch,
output ibranch,
output jbranch
 
 );
 /*  
initial begin
 
end  
*/

//aluop
always @ (*)begin
//初始化
aluop=3'b000;
shif_en=2'b00;
rw=1'b0;
imm=1'b0;
signext=1'b0;

if(op==6'b000000)
    begin
        case (funct)
        6'b100000,6'b100001://add addu,
        begin
        rw=1'b1;
        aluop=3'b010;
        end
        6'b100010,6'b100011://sub subu
        begin
        rw=1'b1;
        aluop=3'b110;
        end
        6'b100100://and
        begin
        rw=1'b1;
        aluop=3'b000;
        end
        6'b100101://or
        begin
        rw=1'b1;
        aluop=3'b001;
        end
        6'b100110://xor
        begin
        rw=1'b1;
        aluop=3'b011;
        end
        6'b100111://nor
        begin
        rw=1'b1;
        aluop=3'b100;
        end
        6'b101010://slt
        begin
        rw=1'b1;
        aluop=3'b111;
        end
        6'b101011://sltu
        begin
        rw=1'b1;
        aluop=3'b101;
        end
        
        6'b000000://sll
        begin
        rw=1'b1;
        shif_en=2'b01;
        aluop=3'b000;
        end
        6'b000010://srl
        begin
        rw=1'b1;
        shif_en=2'b01;
        aluop=3'b010;
        end
        6'b000011://sra
        begin
        rw=1'b1;
        shif_en=2'b01;
        aluop=3'b011;
        end
        6'b000100://sllv
        begin
        rw=1'b1;
        shif_en=2'b01;
        aluop=3'b100;
        end
        6'b000110://srlv
        begin
        rw=1'b1;
        shif_en=2'b01;
        aluop=3'b110;
        end
        6'b000111://srav
        begin
        rw=1'b1;
        shif_en=2'b01;
        aluop=3'b111;
        end
        default: 
        begin
        aluop=3'b000;
        shif_en=2'b00;
        rw=1'b0;
        imm=1'b0;    
        end   
        endcase    
     end
     else begin
     case(op)
    6'b001000,6'b001001://addi,addiu
        begin
        rw=1'b1;
        imm=1'b1;
        aluop=3'b010;
        end
    6'b001100://andi 
        begin
        rw=1'b1;
        imm=1'b1;      
        aluop=3'b000;   
        signext=1'b1; 
        end
    6'b001101://ori
        begin
        rw=1'b1;
        imm=1'b1;
        aluop=3'b001;
        signext=1'b1; 
        end
    6'b001110://xori
        begin
        rw=1'b1;
        imm=1'b1;
        aluop=3'b011;
        signext=1'b1; 
        end
    6'b001010://slti
        begin
        rw=1'b1;
        imm=1'b1;
        aluop=3'b111;
        end
    6'b001011://sltiu
        begin
        rw=1'b1;
        imm=1'b1;
        aluop=3'b101;
        end
    6'b101011://sw
        begin
        imm=1'b1;
        aluop=3'b010; 
        end
    6'b100011://lw
        begin
        rw=1'b1;
        imm=1'b1;
        aluop=3'b010;  
        end
    6'b000100,6'b000101://beq,bne
        begin
        imm=1'b1;
        aluop=3'b110;  
        end 
    6'b001111://lui
        begin
        imm=1'b1;
        shif_en=2'b10;
        rw=1'b1;   
        end   
    default:
        begin
        aluop=3'b000;
        shif_en=2'b00;
        rw=1'b0;
        imm=1'b0;
        signext=1'b1;     
        end 

endcase
end
end    

assign of_en=(op==6'b001000)||((op==6'b000000)&&((funct==6'b100000)||(funct==6'b100010)));

assign memread=(op==6'b100011);
assign memwrite=(op==6'b101011);

assign rbranch=(op==6'b000000&&funct==6'b001000);
assign ibranch=(op==6'b000100||op==6'b000101);
assign bne=(op==6'b000101);
assign jbranch=(op==6'b000010);
   
endmodule
