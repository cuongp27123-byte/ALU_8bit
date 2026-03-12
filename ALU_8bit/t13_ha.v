module t13_ha 
  (input wire A,B,
  output wire Y,
  output wire Cout);
  
  t13_xor u1(.A(A), .B(B), .Y(Y));
  t13_and u2(.A(A), .B(B), .Y(Cout));
endmodule


