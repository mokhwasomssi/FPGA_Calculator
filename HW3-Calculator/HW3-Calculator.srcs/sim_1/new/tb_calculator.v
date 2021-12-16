module tb_calculator;

reg [3:0] sel;
reg [3:0] seg_x[0:5];
reg [3:0] seg_y[0:5];
wire [19:0] result;

initial begin
    sel = 13;
    seg_x[0] = 6;
    seg_x[1] = 5;
    seg_x[2] = 4;
    seg_x[3] = 3;
    seg_x[4] = 2;
    seg_x[5] = 1;
    seg_y[0] = 6;
    seg_y[1] = 5;
    seg_y[2] = 4;
    seg_y[3] = 3;
    seg_y[4] = 2;
    seg_y[5] = 1;
    #100;

    $stop;
end

calculator cal_inst (sel, seg_x, seg_y, result);

endmodule