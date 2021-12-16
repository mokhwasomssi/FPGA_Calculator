module top (
    input clk, // 100mhz
    input rst,
    inout [7:0] key_io, // input, output 
    output [7:0] seg_data, 
    output [5:0] seg_com
    );
    
    wire clk_6mhz, clk_1khz;
    wire [4:0] key_tmp; // MSB : whether key is pressed, [3:0] : which key is pressed
    wire [4:0] key, key_pulse;
    wire [4:0] A[0:5]; // 세그먼트로 표현되는 숫자
    wire [6:0] dec_out[0:5];
    reg [5:0] seg_com;
    reg [7:0] seg_data;
    
    wire [19:0] x, y; // 2^20 = 1,048,576
    wire [19:0] seg_result; 
    wire [3:0] seg_cnt;
    wire [3:0] res_status; // inf=1, ovf=2, ok=3, zero=4, minus=5
    wire hex;

    clk_wiz_0 clk_inst (clk_6mhz, rst, , clk); // clk : input(100Mhz), clk_6mhz : output
    clk_divider #(.DIVISOR(6000)) clk_div_inst (clk_6mhz, clk_1khz);
    keypad keypad_inst (clk_6mhz, rst, key_io[7:4], key_io[3:0], key_tmp); 
    debounce debounce_inst (clk_6mhz, rst, key_tmp, key, key_pulse); // key : static signal, key_pulse : pulse signal for 1 clock cycle

    seg_display seg_display_inst (clk_6mhz, rst, key_pulse, x, y, res_status, seg_result, seg_cnt, hex, A[0], A[1], A[2], A[3], A[4], A[5]);
    calculate calculate_inst (clk_6mhz, rst, key_pulse, x, y, res_status, seg_result, seg_cnt, hex);

    // 키패드로 받은 숫자 값을 세그먼트 표현으로 디코딩
    dec7 dec7_inst_0 (A[0], dec_out[0]);
    dec7 dec7_inst_1 (A[1], dec_out[1]);
    dec7 dec7_inst_2 (A[2], dec_out[2]);
    dec7 dec7_inst_3 (A[3], dec_out[3]);
    dec7 dec7_inst_4 (A[4], dec_out[4]);
    dec7 dec7_inst_5 (A[5], dec_out[5]);
   
    // 세그먼트 하나식 업데이트
    always @ (posedge clk_1khz, posedge rst) 
    begin
      if(rst == 1)
          seg_com <= 6'b100000;
      else
          seg_com <= {seg_com[0], seg_com[5:1]};
    end
    
    // 세그 데이터 출력
    always @ (*) begin
        case(seg_com)
            6'b100000 : seg_data = {dec_out[0], 1'b0};
            6'b010000 : seg_data = {dec_out[1], 1'b0};
            6'b001000 : seg_data = {dec_out[2], 1'b0};
            6'b000100 : seg_data = {dec_out[3], 1'b0};
            6'b000010 : seg_data = {dec_out[4], 1'b0};
            6'b000001 : seg_data = {dec_out[5], 1'b0};
            default : seg_data = 8'b0;
        endcase
    end
    
endmodule