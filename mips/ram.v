
module ram(
input clk,
input we,
input rst,
input [4:0] rs,
input [4:0] rt,
input [4:0] rd,
input [31:0] wd,

output [31:0] drs,
output [31:0] drt

);

reg [31:0] mem [0:31];

integer i;
always @(posedge clk or posedge rst) begin
    if (rst)begin
        for(i=0;i<32;i=i+1)begin
          mem[i]<=32'd0;
        end
    end 
else  if (we&&rd!=5'd0)begin
        mem[rd]<=wd;    
    end
end
assign drs=mem[rs];
assign drt=mem[rt];

endmodule
