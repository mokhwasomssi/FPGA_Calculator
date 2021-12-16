# FPGA_Calculator

[디지털 시스템] 전공수업 과제 - 계산기 만들기

---

## 개발 환경
- Vivado 2018.2
- ZedBoard Zynq Evaluation and Development Kit

## 작동 영상
- [링크](https://youtu.be/oIDSvTSgZKw)


## 직접 작성한 코드
- [calculate.v](https://github.com/mokhwasomssi/FPGA_Calculator/blob/main/HW3-Calculator/HW3-Calculator.srcs/sources_1/new/calculate.v)
- [seg_display.v](https://github.com/mokhwasomssi/FPGA_Calculator/blob/main/HW3-Calculator/HW3-Calculator.srcs/sources_1/new/seg_display.v)


## 약간 수정한 코드
- [top.v](https://github.com/mokhwasomssi/FPGA_Calculator/blob/main/HW3-Calculator/HW3-Calculator.srcs/sources_1/new/top.v)
- [dec7.v](https://github.com/mokhwasomssi/FPGA_Calculator/blob/main/HW3-Calculator/HW3-Calculator.srcs/sources_1/new/dec7.v)
  - 16진수 표현을 위해 케이스 문에 알파벳을 추가함

## 구현 기능
- 덧셈
- 덧셈 오버플로우
- 뺄셈
- 뺄셈 결과 음수
- 곱셈
- 곱셈 오버플로우
- 나눗셈
- 나눗셈 인피니트 (0으로 나눴을 때)
- 연속된 계산 (예1)
- 10/16진수 변환