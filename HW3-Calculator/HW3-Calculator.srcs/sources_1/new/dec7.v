module dec7(
    input [4:0] dec_in, // 4비트에서 5비트로 크기 확장 - 알바벳 추가
    output [6:0] dec_out
    );
    
reg [6:0] dec_out; 
    
always @ (dec_in) begin
        case (dec_in)
            0 : dec_out = 7'b1111110;
            1 : dec_out = 7'b0110000;
            2 : dec_out = 7'b1101101;
            3 : dec_out = 7'b1111001;
            4 : dec_out = 7'b0110011;
            5 : dec_out = 7'b1011011;
            6 : dec_out = 7'b1011111;
            7 : dec_out = 7'b1110010;
            8 : dec_out = 7'b1111111;
            9 : dec_out = 7'b1111011;
            10 : dec_out = 7'b1110111; // A
            11 : dec_out = 7'b0011111; // B
            12 : dec_out = 7'b0001101; // C
            13 : dec_out = 7'b0111101; // D
            14 : dec_out = 7'b1001111; // E
            15 : dec_out = 7'b1000111; // F
            16 : dec_out = 7'b0000001; // minus
            17 : dec_out = 7'b0000110; // I
            18 : dec_out = 7'b0010101; // N
            19 : dec_out = 7'b0011101; // O
            20 : dec_out = 7'b0011100; // V
            default: dec_out = 7'b0000000; 
        endcase
end
  
endmodule
