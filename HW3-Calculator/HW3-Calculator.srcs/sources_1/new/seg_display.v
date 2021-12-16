module seg_display (clk, rst, key_pulse, x, y, res_status, seg_result, seg_cnt, hex, A0, A1, A2, A3, A4, A5);
input clk, rst;
input [4:0] key_pulse;
input [19:0] x, y;
input [3:0] res_status; // inf=1, ovf=2, ok=3, zero=4, minus=5
input [19:0] seg_result; 
input [3:0] seg_cnt;
input hex;
output [4:0] A0, A1, A2, A3, A4, A5;

reg [4:0] A0, A1, A2, A3, A4, A5;

always @(posedge clk, posedge rst)
begin
    if(rst == 1 || (key_pulse[4] == 1 && key_pulse[3:0] == 15)) begin // 리셋 또는 초기화키 입력
        A0 <= 5'h0;
        A1 <= 5'h1F;
        A2 <= 5'h1F;
        A3 <= 5'h1F;
        A4 <= 5'h1F;  
        A5 <= 5'h1F;
    end
    else if(key_pulse[4] == 1 && key_pulse[3:0] <= 9) begin // 숫자키 입력
        if(A0 == 5'h0 && A1 == 5'h1F) // 좌항의 첫번째 숫자 입력
            A0 <= key_pulse[3:0];
        else if (x == 0 && y != 0) begin // 우항의 첫번째 숫자 입력
            A0 <= key_pulse[3:0];
            A1 <= 5'h1F;
            A2 <= 5'h1F;
            A3 <= 5'h1F;
            A4 <= 5'h1F;  
            A5 <= 5'h1F;
        end
        else begin // 나머지 숫자 입력
        A0 <= key_pulse[3:0];
        A1 <= A0;
        A2 <= A1;
        A3 <= A2;
        A4 <= A3;
        A5 <= A4;
        end
    end
    else if (key_pulse[4] == 1 && key_pulse[3:0] == 14) begin // 등호 입력
            A0 <= 5'h1F; // 결과 출력 전에 A 초기화
            A1 <= 5'h1F;
            A2 <= 5'h1F;
            A3 <= 5'h1F;
            A4 <= 5'h1F;  
            A5 <= 5'h1F;          
    end
    else if (res_status == 1) begin // inf
        A0 <= 15; // F
        A1 <= 18; // N
        A2 <= 17; // I
        A3 <= 5'h1F;
        A4 <= 5'h1F;  
        A5 <= 5'h1F;  
    end
    else if (res_status == 2) begin // ovf
        A0 <= 15; // F
        A1 <= 20; // V
        A2 <= 19; // O
        A3 <= 5'h1F;
        A4 <= 5'h1F;  
        A5 <= 5'h1F;  
    end
    else if (res_status == 3 && seg_cnt > 0 && hex == 0) begin // ok. 10진수 결과 표시
        if (seg_result != 0) A5 <= seg_result % 10;
        else A5 <= 5'h1F;
        A4 <= A5;
        A3 <= A4;
        A2 <= A3;
        A1 <= A2;
        A0 <= A1;
    end
    else if (res_status == 3 && seg_cnt > 0 && hex == 1) begin // ok. 16진수 결과 표시
        if(seg_result != 0 ) A5 <= seg_result[3:0];
        else A5 <= 5'h1F;
        A4 <= A5;
        A3 <= A4;
        A2 <= A3;
        A1 <= A2;
        A0 <= A1;
    end
    else if (res_status == 4) begin // zero
        A0 <= 5'h0;
        A1 <= 5'h1F;
        A2 <= 5'h1F;
        A3 <= 5'h1F;
        A4 <= 5'h1F;  
        A5 <= 5'h1F;
    end
    else if (res_status == 5 && seg_cnt > 0) begin // minus
        if (seg_result != 0) A5 <= seg_result % 10;
        else if (A5 >= 0 && A5 <= 9) A5 <= 16; // 16 is minus sign
        else A5 <= 5'h1F;
        A4 <= A5;
        A3 <= A4;
        A2 <= A3;
        A1 <= A2;
        A0 <= A1;
    end
end
    
endmodule