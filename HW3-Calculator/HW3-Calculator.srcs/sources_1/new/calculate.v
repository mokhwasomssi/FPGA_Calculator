module calculate(clk, rst, key_pulse, x, y, res_status, seg_result, seg_cnt, hex);
input clk, rst;
input [4:0] key_pulse;
output [19:0] x, y;
output [3:0] res_status;
output [19:0] seg_result;
output [3:0] seg_cnt;
output hex;

reg [19:0] x, y;
reg [4:0] operator;
reg [23:0] result;
reg [19:0] seg_result; 
reg [3:0] digit_cnt, seg_cnt;
reg [3:0] res_status;
reg [1:0] equal;
reg hex;

// 계산
always @(posedge clk, posedge rst) begin
    if(rst == 1 || (key_pulse[4] == 1 && key_pulse[3:0] == 15)) begin // 리셋 또는 초기화키 입력
        x <= 0; y <= 0;
        operator <= 0;
        result <= 0; seg_result <= 0;
        digit_cnt <= 0; seg_cnt <= 0;
        res_status <= 0;
        equal <= 0;
        hex <= 1;
    end
    else if(key_pulse[4] == 1 && key_pulse[3:0] <= 9) begin // 숫자키 입력
        x <= x*10 + key_pulse[3:0];
        digit_cnt <= digit_cnt + 1;
    end
    else if (key_pulse[4] == 1 && key_pulse[3:0] >= 10 && key_pulse[3:0] <= 13) begin // 연산자 입력
        if (res_status == 3) y <= result;
        else y <= x; // 좌항 저장
        x <= 0; // 우항을 저장하기 위해 기존 값을 초기화
        operator <= key_pulse[3:0]; // 연산자 저장
        hex <= 1;
    end
    else if (key_pulse[4] == 1 && key_pulse[3:0] == 14) begin // 등호 입력
        if (operator == 13)
            result <= y + x;
        else if (operator == 12)
            if(y > x) result <= y - x;
            else result <= x - y;
        else if (operator == 11)
                result <= y * x;
        else // operator == 10
            result <= y / x;
        equal <= 1;
        
    end
    else if (equal == 1) begin
        if (operator == 13 && result > 999999) res_status <= 2;
        else if (operator == 11 && digit_cnt == 7 && result > 999999) res_status <= 2;
        else if (operator == 11 && digit_cnt >= 8) res_status <= 2;
        else if (operator == 10 && x == 0 ) res_status <= 1;
        else if (operator == 12 && x == y) res_status <= 4;
        else if (operator == 12 && x > y) begin
            res_status <= 5;
            seg_cnt <= 6;
            seg_result <= result;
        end
        else begin
            res_status <= 3;
            seg_cnt <= 6;  
            seg_result <= result;
        end
        equal <= 0;
        digit_cnt <= 0;
                    
        if(hex == 0) hex <= 1; //10진수-16진수 출력 변환 플래그
        else hex <= 0;
    end
    
    else if (hex == 0 && seg_cnt > 0) begin // 10진수 표시 
        seg_result <= seg_result / 10;
        digit_cnt <= ((seg_result % 10) != 0) ? (digit_cnt+1) : digit_cnt;
        seg_cnt <= seg_cnt - 1;
    end
    else if (hex == 1 && seg_cnt > 0) begin // 16진수 표시
        seg_result <= seg_result >> 4;
        seg_cnt <= seg_cnt - 1; 
    end
    
end 

endmodule
