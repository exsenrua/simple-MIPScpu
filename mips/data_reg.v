
module data_reg(
input clk,
input rst,
input we,
input re,
input [31:0]addr,
input [31:0]wd,
output reg [31:0]rd
    );
    
reg [31:0]mem[0:255];
integer i;

initial begin
    for(i = 0; i < 256; i = i + 1) begin
        mem[i] = 32'b0;
    end
    $readmemh("D:/fpga/exercise/mips/mips.sim/sim_1/behav/xsim/data.txt", mem);
end
always @(posedge clk or posedge rst) begin
    if(rst) begin
        for(i = 0; i < 256; i = i + 1) begin
            mem[i] <= 32'b0;
        end
    end else begin
        if(we) begin
            mem[addr[9:2]] <= wd;
        end
    end
end

always @(*) begin
    if(re) begin
        rd = mem[addr[9:2]];
    end else begin
        rd = 32'b0;
    end
end
endmodule
