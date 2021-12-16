// convert 6 number from keypad to 6-digit number
module digit6 (
    input clk,
    input rst,
    input [4:0] key_pulse,
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    input [3:0] f,
    output [19:0] s
    );
    
reg [19:0] s;
reg [19:0] t;

always @(posedge clk, posedge rst) begin
    if (rst) s <= 19'b0;
    else if (key_pulse[4] == 1 && key_pulse[3:0] >= 10 && key_pulse[3:0] <= 13) begin
        if(a != 4'hF)
            t = a*100000 + b*10000 + c*1000 + d*100 + e*10 + f;
        else if(b != 4'hF)
            t = b*10000 + c*1000 + d*100 + e*10 + f;
        else if(c != 4'hF)
            t = c*1000 + d*100 + e*10 + f;
        else if(d != 4'hF)
            t = d*100 + e*10 + f;
        else if(e != 4'hF)
            t = e*10 + f;
        else
            t = f;
    end

end

endmodule