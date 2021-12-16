module clk_divider (
    input clk_in, 
    output clk_out
);

reg[31:0] o=32'd0;
reg clk_out=1'b0; 
parameter DIVISOR = 32'd6000000;

// clk_out = clk_in / DIVISOR

always @(posedge clk_in) begin
   
   if(o == DIVISOR/2-1) begin
       o <= 0; 
       clk_out <= ~clk_out; 
   end 
   else o <= o + 1; 
end

endmodule
