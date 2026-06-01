module PC(
input rst,
input clk,
input branch,
input [31:0]branch_data,
output reg [31:0]pc,
output [31:0]pc4
    );
    

wire px;

add add1(.a(pc),.b(32'd4),.cin(1'b0),.sum(pc4),.cout(px));


always @(posedge clk or posedge rst)begin
if(rst)begin
    pc<=32'b0;
end
else begin
    if(branch)begin
        pc<=branch_data;
    end
    else begin
        pc<=pc4;
    end
end
end
endmodule
