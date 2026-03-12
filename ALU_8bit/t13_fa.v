module t13_fa(
  input wire A,B,Cin,
  output wire Cout,Y);
  wire W1,W2,W3;
  
  t13_ha u1(.A(A), .B(B), .Cout(W1), .Y(W2));
  t13_ha u2(.A(W2), .B(Cin), .Cout(W3), .Y(Y));
  t13_or u3(.A(W1), .B(W3), .Y(Cout));
endmodule


