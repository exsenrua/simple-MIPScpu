module shift(
input [31:0]din,
input [4:0]shift,
input [1:0]sel,
output reg [31:0] dout
);

reg [31:0]s1,s2,s4,s8,s16;
wire sign=din[31];

always @(*)begin

if(shift[0])begin
case (sel)
    2'b00: s1={1'b0,din[31:1]};
    2'b01: s1={sign,din[31:1]};
    2'b10: s1={din[0],din[31:1]};
    default: s1=din;
endcase
end else begin 
s1=din;  
end 

if(shift[1])begin
case (sel)
    2'b00: s2={{2{1'b0}},s1[31:2]};
    2'b01: s2={{2{sign}},s1[31:2]};
    2'b10: s2={{2{s1[0]}},s1[31:2]};
    default: s2=s1;
endcase
end else begin 
s2=s1;  
end 

if(shift[2])begin
case (sel)
    2'b00: s4={{4{1'b0}},s2[31:4]};
    2'b01: s4={{4{sign}},s2[31:4]};
    2'b10: s4={{4{s2[0]}},s2[31:4]};
    default: s4=s2;
endcase
end else begin 
s4=s2;  
end 

if(shift[3])begin
case (sel)
    2'b00: s8={{8{1'b0}},s4[31:8]};
    2'b01: s8={{8{sign}},s4[31:8]};
    2'b10: s8={{8{s1[0]}},s4[31:8]};
    default: s8=s4;
endcase
end else begin 
s8=s4;  
end 

if(shift[4])begin
case (sel)
    2'b00: s16={{16{1'b0}},s8[31:16]};
    2'b01: s16={{16{sign}},s8[31:16]};
    2'b10: s16={{16{s8[0]}},s8[31:16]};
    default: s16=s8;
endcase
end else begin 
s16=s8;  
end 

dout=s16;

end
endmodule
