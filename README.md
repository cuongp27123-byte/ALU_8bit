Thiết kế ALU 8-bit có khả năng thực hiện các phép toán: ADD, SUB, SL, SR và đáp ứng yêu cầu:
- Ngõ vào: 
  A[7:0]: toán hạng 1. 
  B[7:0]: toán hạng 2. 
  ALU_Sel[2:0]: mã chọn phép toán . 
  clk, reset: nếu muốn đồng bộ hóa kết quả 
- Ngõ ra: 
  Result[7:0]: kết quả phép toán.
  Zero: cờ bằng 0 (Result == 0).
  Carry: cờ nhớ (khi cộng/trừ vượt quá 8 bit).
  Overflow: cờ tràn số có dấu (ADD/SUB).
  Negative: cờ báo số âm (bit MSB của Result).
