module t13_addsub #(parameter N=8)
  (input wire [N-1:0] A,B,
  input wire Cin,
  output wire [N-1:0] Y,
  output wire Cout);
  wire [N-2:0] W;
  wire [N-1:0] WXOR;
  
  t13_xor u1(.A(B[0]),.B(Cin),.Y(WXOR[0]));
  t13_xor u2(.A(B[1]),.B(Cin),.Y(WXOR[1]));
  t13_xor u3(.A(B[2]),.B(Cin),.Y(WXOR[2]));
  t13_xor u4(.A(B[3]),.B(Cin),.Y(WXOR[3]));
  t13_xor u5(.A(B[4]),.B(Cin),.Y(WXOR[4]));
  t13_xor u6(.A(B[5]),.B(Cin),.Y(WXOR[5]));
  t13_xor u7(.A(B[6]),.B(Cin),.Y(WXOR[6]));
  t13_xor u8(.A(B[7]),.B(Cin),.Y(WXOR[7]));
  
  t13_fa u9(.A(A[0]),.B(WXOR[0]),.Cin(Cin),.Cout(W[0]),.Y(Y[0]));
  t13_fa u10(.A(A[1]),.B(WXOR[1]),.Cin(W[0]),.Cout(W[1]),.Y(Y[1]));
  t13_fa u11(.A(A[2]),.B(WXOR[2]),.Cin(W[1]),.Cout(W[2]),.Y(Y[2]));
  t13_fa u12(.A(A[3]),.B(WXOR[3]),.Cin(W[2]),.Cout(W[3]),.Y(Y[3]));
  t13_fa u13(.A(A[4]),.B(WXOR[4]),.Cin(W[3]),.Cout(W[4]),.Y(Y[4]));
  t13_fa u14(.A(A[5]),.B(WXOR[5]),.Cin(W[4]),.Cout(W[5]),.Y(Y[5]));
  t13_fa u15(.A(A[6]),.B(WXOR[6]),.Cin(W[5]),.Cout(W[6]),.Y(Y[6]));
  t13_fa u16(.A(A[7]),.B(WXOR[7]),.Cin(W[6]),.Cout(Cout),.Y(Y[7]));
endmodule
  




