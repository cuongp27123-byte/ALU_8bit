CHƯƠNG 1: CƠ SỞ LÝ THUYẾT 
Giới thiệu đề tài
	ALU (Arithmetic Logic Unit) là khối xử lý cốt lõi trong CPU, đảm nhiệm các phép toán số học và logic. ALU nhận dữ liệu đầu vào từ bộ nhớ hoặc các thanh ghi, xử lý theo yêu cầu và trả kết quả cho các bộ phận khác của CPU.
	Bộ ALU thường được cấu thành từ ba bus dữ liệu song song, bao gồm:
Toán hạng đầu vào A
Toán hạng đầu vào B 
Đầu ra kết quả Y. 

Hình 1.1: ALU

	Trong đề tài này, nhóm thực hiện thiết kế một ALU 8-bit có khả năng thực hiện các phép toán cơ bản và hoạt động theo kiến trúc CU–DP (Control Unit – Datapath) được mô phỏng trên phần mềm QuestaSim.
Mục tiêu đề tài

Hình 1.2: ALU 8-bit thực hiện các phép toán

	Thiết kế ALU 8-bit có khả năng thực hiện các phép toán: ADD, SUB, SL, SR và đáp ứng yêu cầu:
Ngõ vào: 
A[7:0]: toán hạng 1. 
B[7:0]: toán hạng 2. 
ALU_Sel[2:0]: mã chọn phép toán . 
clk, reset: nếu muốn đồng bộ hóa kết quả 
Ngõ ra: 
Result[7:0]: kết quả phép toán.
Zero: cờ bằng 0 (Result == 0).
Carry: cờ nhớ (khi cộng/trừ vượt quá 8 bit).
Overflow: cờ tràn số có dấu (ADD/SUB).
Negative: cờ báo số âm (bit MSB của Result).
Mục tiêu thiết kế
Thiết kế ALU 8-bit đồng bộ, tránh latch.
Sử dụng mô hình CU–DP:
CU là FSM điều khiển các trạng thái: reset, load, start, compute, done.
DP điều khiển các thanh ghi đầu vào, thanh ghi kết quả và các cờ trạng thái.
Viết RTL code bằng Verilog, có cấu trúc module rõ ràng, dễ tái sử dụng.
Tạo testbench để mô phỏng các trường hợp.
Phân tích Timing cơ bản.
Kiểm thử nâng cao.
Nội dung lý thuyết liên quan
	a. Phép dịch: Các phép dịch bit là một nhóm toán tử quan trọng trong xử lý 	tín hiệu số, mã hóa, giải mã, nhân/chia nhanh, và trong các kiến trúc CPU vì 	tốc độ xử lý dịch bit nhanh hơn phép toán số học.
Phép dịch trái (SL - Shift Left Logical): Dịch toàn bộ các bit sang trái 1 vị trí. Bit MSB bị đẩy ra ngoài, bit LSB mới chèn vào được đặt là 0. 

Hình 1.3: Dịch trái 8-bit
Phép dịch phải (SR - Shift Right Logical): Dịch toàn bộ các bit sang phải 1 vị trí. Bit LSB bị đẩy ra ngoài, bit MSB mới chèn vào được đặt là 0. 


Hình 1.4: Dịch phải 8-bit

	b. Phép cộng: Thực hiện phép cộng giữa 2 số nhị phân
Mạch cộng bán phần (Half Adder): thực hiện phép cộng bán phần giữa 2 số nhị phân 1 bit.


Hình 1.5: Bộ cộng HA 1-bit
Mạch cộng toàn phần (Full Adder): thực hiện phép cộng toàn phần giữa 2 số nhị phân 1 bit. 
Mạch FA có thể xây dựng từ 2 bộ HA kết nối với 1 cổng OR.


Hình 1.6: Bộ cộng FA 1-bit
Bộ cộng Full Adder n-bit: thực hiện phép cộng toàn phần giữa 2 số nhị phân n-bit, có thể xây dựng từ n bộ FA 1-bit. 
Vd: Xây dựng bộ cộng 8-bit từ 8 bộ FA.

Hình 1.7: Bộ cộng FA 8-bit
c. Phép trừ
	Khi thực hiện phép trừ 2 số nhị phân A – B, có thể biểu diễn số trừ B thành số bù 2:


	Tức là:

Hình 1.8: Trừ số bù 2
	Như vậy có thể biễu diễn phép trừ thành phép cộng dưới dạng biểu diễn số bù 2 của số trừ. 
Để xây dựng một bộ trừ 2 số n-bit, có thể tái sử dụng bộ cộng bằng cách đảo mức logic của B; đồng thời khi trừ 2 bit LSB, bit Cin ban đầu được đặt bằng 1.

Hình 1.9: Cổng logic XOR
		Có thể sử dụng cổng XOR với đầu vào là Cin và B để: 
Khi Cin = 1, đầu ra là B đảo => Mạch lúc này là Bộ Trừ FS.
Khi Cin = 0, đầu ra là B 	     => Mạch lúc này là Bộ Cộng FA.


Hình 1.10: Bộ cộng trừ 8-bit

d. Cờ trạng thái
Zero: bằng 1 khi kết quả phép toán là 0;
Negative: biểu diễn dấu của kết quả
Bit MSB có giá trị là 1 🡪 kết quả mang dấu âm
Bit MSB có giá trị là 0 🡪 kết quả mang dấu dương

Carry :
Trong phép cộng: Thể hiện sự tràn bit khi cộng 2 số không dấu
		Vd: Khi cộng 2 số nhị phân 4-bit, khi bit thứ 5 xuất hiện Carry=1



Trong phép trừ: Carry không còn là cờ tràn như phép cộng, lúc này sẽ trở thành cờ mượn Borrow. Cờ Borrow thể hiện việc mượn 1 khi trừ 2 số không dấu A - B và A < B
		Vd: Khi trừ 2 số nhị phân 4-bit, khi 2 bit MSB là 0 – 1 phải mượn 1 từ 		bit kế tiếp (không tồn tại) vì vậy phải mượn từ Borrow 🡪 Borrow = 1

		Vd: Khi biểu diễn số trừ theo số bù 2:


		Kết quả A – B = 1000 với bit 1 mượn lúc đầu 🡪 Borrow=1
Overflow: Thể hiện sự tràn bit dấu khi cộng trừ 2 số nhị phân có dấu.
Khi cộng 2 số có dấu A,B: nếu A và B cùng dấu mà kết quả ra khác dấu của A và B 🡪 tràn dấu 🡪 Overflow = 1
Khi trừ 2 số có dấu A,B: nếu A và B khác dấu mà kết quả ra khác dấu của số bị trừ A 🡪 tràn dấu 🡪 Overflow = 1
Vd: 






CHƯƠNG 2: THIẾT KẾ MẠCH 
  Sơ đồ khối
Thiết kế bộ ALU 8-bit thực hiện các phép toán gồm các khối: Control Unit, Datapath và khối Top để kết nối CU VÀ DP.


Hình 2.1: Sơ đồ khối
Tín hiệu vào:
Clk: Xung clock dùng để đồng bộ các FF trong CU, DP hoạt động theo sườn dương của Clk.
Rst: Reset đồng bộ mức cao. Khi Rst=1: A, B, Result và các cờ trạng thái đều về 0, hệ thống trở về trạng thái chờ.
Sel: Mã chọn phép toán. Quy ước: 00 – dịch trái (SL); 01 – dịch phải (SR); 10 – cộng (ADD); 11 – trừ (SUB).
Load: Tín hiệu yêu cầu nạp dữ liệu. Khi Load=1, A_in, B_in được lưu vào các thanh ghi A, B bên trong DP.
Start: Tín hiệu cho phép thực hiện phép toán. Khi Start=1 hệ thống sẽ dựa vào Sel để kích hoạt phép toán tương ứng.
A_in: Toán hạng một, là dữ liệu 8-bit từ bên ngoài đưa vào.
B_in: Toán hạng hai, là dữ liệu 8-bit từ bên ngoài đưa vào.
Tín hiệu ra:
Result [7:0]: Kết quả phép toán sau khi thực hiện SL/SR/ADD/SUB trên A và B. 
Zero: Dùng để kiểm tra kết quả bằng 0.
Negative: Bằng 1 khi bit MSB của Result = 1.
Overflow: Báo tràn số có dấu trong phép cộng/trừ. 
Carry: Báo carry trong phép cộng hoặc borrow trong phép trừ.
Các tín hiệu nội:
Rst1: Reset A,B,Y, cờ của DP.
Load1: Tín hiệu chốt A_in, B_in vào thanh ghi A, B.
SL: Lệnh shift left thực hiện dịch trái A.
SR: Lệnh shift right thực hiện dịch phải A.
ADD: Lệnh cộng, dùng module AddSub để tính A + B, đồng thời cập nhật các cờ.
SUB: Lệnh trừ, dùng module AddSub để tính A - B, đồng thời cập nhật các cờ.
Done: Báo kết thúc phép toán. DP kéo Done=1 khi đã tính xong Result và các cờ trạng thái. CU dùng Done để chuyển trạng thái FSM từ COMPUTE → DONE → IDLE.
Khối CU: điều khiển FSM


Hình 2.2: Đồ hình trạng thái

Ban đầu ở trạng thái idle
Mỗi khi có sườn dương của xung Clk và đạt điều kiện thỏa mãn sẽ chuyển sang trạng thái tiếp theo
Rst =1, idle 🡪 s_rst và đầu ra rst1=1
Load=1, idle 🡪 s_load và đầu ra load1=1
Start=1, idle 🡪 s_start 🡪 s_compute
Trong s_compute, khi sel=2’b00 đầu ra sl=1; sel=2’b01 đầu ra sr=1; sel=2’b10 đầu ra add=1, sel=2’b11 đầu ra sub=1
Khi nhận được done = 1, s_compute 🡪 s_done 🡪 idle
Khối DP: tính toán, hiển thị kết quả
Khi nhận được tín hiệu Rst1=1, giá trị Result và các cờ trạng thái được đặt về 0
Khi load1=1, giá trị đầu vào A_in và B_in được lưu vào thanh ghi chứa giá trị của A,B để tính toán
Khi SL=1, thực hiện dịch trái các bit của A và hiển thị kết quả result, cờ Zero,Negative
Khi SR=1, thực hiện dịch phải các bit của A và hiển thị kết quả result, cờ Zero,Negative
Khi ADD=1, thực hiện cộng các bit của A và B, hiển thị kết quả result, cờ Zero,Negative,Overflow,Carry
Khi SUB=1, thực hiện cộng các bit của A và B, hiển thị kết quả result, cờ Zero,Negative,Overflow,Carry

  Lưu đồ thuật toán

Hình 2.3: Lưu đồ thuật toán

  Code chính
Các module con: AND,OR,XOR




Sử các module cổng logic tạo module HA

Sử dụng module HA tạo module FA


Sử dụng module FA tạo module cộng/trừ AddSub


Module thực hiện dịch trái, dịch phải

Module ControlUnit


Module DataPath




Module Top

Module testbench



Waveform


Phân tích waveform:

Khi Start mà chưa có tín hiệu Load, sel=2’b00 🡪 thực hiện phép dịch với A=8’d0.
Sau khi có tín hiệu Load 
sel=2’b00, nhấn Start 🡪 dịch trái A_in: 11001100 🡪 result: 10011000, negative=1
sel=2’b01, nhấn Start 🡪 dịch phải A_in: 11001100 🡪 result: 01100110
sel=2’b10, nhấn Start 🡪 A_in + B_in 🡪 result: 00111100, carry=1
sel=2’b11, nhấn Start 🡪 A_in - B_in 🡪 result: 01011100, carry=1,overflow=1

Khi có rst, Y_out và các cờ trạng thái được gán về 0
Khi thay đổi giá trị A_in và B_in và load =1 🡪 kết quả phép tính thay đổi
sel=2’b00, nhấn Start 🡪 dịch trái A_in: 10000000 🡪 result: 00000000, zero=0
sel=2’b01, nhấn Start 🡪 dịch phải A_in: 10000000 🡪 result: 01000000
sel=2’b10, nhấn Start 🡪 A_in + B_in 🡪 result: 00010000, carry=1,overflow=1
sel=2’b11, nhấn Start 🡪 A_in - B_in 🡪 result: 11110000, negative=1

Khi không có rst mà thay đổi A_in,B_in và load=1 🡪 kết quả phép tính thay đổi
sel=2’b00, nhấn Start 🡪 dịch trái A_in: 01100110🡪 result: 11001100, negative=1
sel=2’b01, nhấn Start 🡪 dịch phải A_in: 01100110 🡪 result: 00110011
sel=2’b10, nhấn Start 🡪 A_in + B_in 🡪 result: 00000100, carry=1
sel=2’b11, nhấn Start 🡪 A_in - B_in 🡪 result: 11001000, negative=1,overflow=1

  Mạch RTL


Mạch RTL thể hiện rõ 2 khối chính: Control Unit và DataPath cùng các đầu vào, ra tương ứng.


Trong khối Control Unit: 3 khối FlipFlop, StateMemoryLogic, OutputLogic.

CHƯƠNG 3: KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN 
3.1  Kết luận
	Trong đề tài này, hệ thống ALU 8-bit đã được thiết kế theo kiến trúc Control Unit – Datapath, đảm bảo mô hình xử lý tách biệt rõ ràng giữa điều khiển và dữ liệu. 
	CU được xây dựng bằng FSM nhiều trạng thái có chức năng quản lý quá trình nạp dữ liệu, lựa chọn phép toán, kích hoạt tính toán và xác nhận hoàn tất thông qua tín hiệu done. 
	Datapath được tổ chức gồm các khối xử lý nhỏ: dịch trái (SL), dịch phải (SR), cộng và trừ theo bù hai, kết hợp với các thanh ghi A, B và khối tính các cờ trạng thái (Zero, Negative, Carry, Overflow).
	Hệ thống hoạt động ổn định với các bước xử lý rõ ràng: nạp dữ liệu vào thanh ghi, bắt đầu phép toán, chọn thao tác dựa vào mã điều khiển, thực thi phép toán và xuất kết quả cùng cờ trạng thái. Các phép cộng/trừ được triển khai theo cấu trúc ripple–carry full adder và có thể tái sử dụng. Việc áp dụng mô hình FSM giúp đảm bảo quá trình tính toán diễn ra đúng trình tự và không bị lặp khi tín hiệu điều khiển giữ mức cao.
	Qua quá trình thiết kế, mô phỏng và kiểm thử, tất cả chức năng đề ra đều được đáp ứng đúng yêu cầu. Hệ thống đã được kiểm chứng bằng các testbench, waveform và các phép đo giá trị cờ trạng thái, chứng minh tính đúng đắn của thuật toán và kiến trúc thiết kế.
3.2  Hướng phát triền
Dựa trên nền tảng đã xây dựng, hệ thống có thể mở rộng theo các hướng sau:
- Mở rộng tập lệnh ALU
Bổ sung các phép toán logic: AND, OR, XOR, NOT.
Thêm phép so sánh: CMP, SLT (set less than).
Hỗ trợ nhân/ chia ở mức đơn giản hoặc nhiều chu kỳ (iterative multiplier/divider).
- Mở rộng độ rộng dữ liệu
Tổng quát hoá datapath từ 8-bit lên 16-bit hoặc 32-bit.
Dùng cấu trúc hierarchical hoặc generate để thuận tiện tái sử dụng.
- Tối ưu phần cứng
Thay ripple-carry bằng carry-lookahead để tăng tốc độ.
Tối ưu số lượng LUT/FF khi đưa lên FPGA.
Tối ưu timing để tăng Fmax.
- Hoàn thiện mô phỏng và tổng hợp
Tổng hợp trên FPGA thực tế (Vivado/Quartus) để thu được số liệu LUT, FF, timing, Fmax.
Tạo testbench tự động và random test để bao phủ nhiều trường hợp hơn.
- Tích hợp thành CPU mini
ALU có thể tích hợp cùng bộ điều khiển lệnh, thanh ghi và bộ nhớ để tạo thành một CPU đơn giản kiểu RISC.
Kết hợp pipeline 2–3 stage để cải thiện hiệu năng.
- Tạo giao diện người dùng
Làm giao diện hiển thị kết quả ALU qua LED/7-seg hoặc UART terminal.
Tạo module nhập dữ liệu và theo dõi cờ trạng thái theo thời gian thực.
3.3. Kết luận chương 3
	Chương 3 đã trình bày chi tiết đánh giá, qua đó chứng minh rằng thiết kế ALU 8-bit đạt yêu cầu kỹ thuật, hoạt động ổn định, chính xác và phù hợp triển khai trên FPGA thực tế. Những hướng phát triển đã nêu sẽ giúp mở rộng khả năng ứng dụng và nâng cao hiệu năng của hệ thống trong các đề tài hoặc sản phẩm tương lai.



