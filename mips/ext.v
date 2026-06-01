
module ext(
input [15:0]data,
input sel,
output [31:0] dout
    );
assign dout=sel?{{16{1'b0}},data}:{{16{data[15]}},data};  
    
endmodule
