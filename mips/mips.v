
module mips(
input rst,
input clk
    );
    
wire [31:0]pc,pc4,branchdata,inst;
wire [5:0]op,funct;
wire [4:0]rs,rt,rd,shamt;
wire [15:0]imm;
wire branch ;  
wire [25:0]jaddr; 
//取指

PC pc_inist(.rst(rst),.clk(clk),.branch(branch),.branch_data(branchdata),.pc(pc),.pc4(pc4));    
    
inst_reg inst_reg_inist(.rst(rst),.clk(clk),.addr(pc),.inst(inst));    
 
assign op=inst[31:26];
assign rs=inst[25:21];
assign rt=inst[20:16];
assign rd=inst[15:11];
assign shamt=inst[10:6];
assign funct=inst[5:0];
assign imm=inst[15:0];
assign jaddr = inst[25:0];
//解码 
wire regwirte,immsign,signext,rbranch,ibranch,jbranch,memread,memwrite;
wire [2:0]aluop;
wire [1:0]shif_en; 
wire [4:0]rd_in;
wire [31:0] drs,drt,wd_in;
wire ofx,bne;

cu cu_inist(.op(op),.funct(funct),
.aluop(aluop),.of_en(ofx),.shif_en(shif_en),
.imm(immsign),.signext(signext),
.rw(regwirte),.memread(memread),.memwrite(memwrite),.bne(bne),
.rbranch(rbranch),.ibranch(ibranch),.jbranch(jbranch));


assign rd_in=immsign?rt:rd;
//寄存器堆
ram ram1 (.clk(clk),.we(regwirte),.rst(rst),.rs(rs),.rt(rt),.rd(rd_in),.wd(wd_in),.drs(drs),.drt(drt));

wire [31:0]alua,alub,immext,shamtin;

//数据扩展
ext ext0(.data(imm),.sel(signext),.dout(immext));
assign shamtin={{27{1'b0}},shamt};

assign alua=drs;
//数据选择reg还是imm
assign alub=immsign?immext:drt;
//计算
wire zero,overx;
wire [31:0]res;

alu alu_inist(.a(alua),.b(alub),.shamt(shamtin),
.aluop(aluop),.shif_en(shif_en),.of_en(ofx),
.dout(res),.zero(zero),.overf(overx));

//
wire [31:0]mdout;
data_reg dreg(.clk(clk),.rst(rst),
.we(memwrite),.re(memread),
.addr(res),.wd(drt),.rd(mdout));

assign wd_in=memread?mdout:res;

//转跳
wire ibranchin,ibranchout;
assign ibranchin=bne?(~zero):zero;
assign ibranchout=ibranchin&ibranch;
assign branch=rbranch|jbranch|ibranchout;    

wire [31:0]ibdin,ibdout;
wire [27:0]jaddrin;
wire [31:0]jaddrout;
wire cxx;
wire [31:0]bd0,bd1;
assign ibdin={immext[29:0],2'b00};
add add2(.a(pc4),.b(ibdin),.cin(1'b0),.sum(ibdout),.cout(cxx));
assign bd0=ibranchout?ibdout:drs;

assign jaddrin={jaddr,2'b0};
assign jaddrout={pc4[31:28],jaddrin};
assign bd1=jbranch?jaddrout:bd0;
assign branchdata=bd1;
endmodule
