
module inst_reg(
input rst,
input clk,
input [31:0]addr,
output [31:0] inst
    );

reg [31:0] mem [0:255];


integer i;

initial begin
    for(i = 0; i < 256; i = i + 1) begin
        mem[i] = 32'b0;
    end
    $readmemh("D:/fpga/exercise/mips/mips.sim/sim_1/behav/xsim/inist.txt", mem);
end


assign inst = rst ? 32'b0 : mem[addr[9:2]];


endmodule