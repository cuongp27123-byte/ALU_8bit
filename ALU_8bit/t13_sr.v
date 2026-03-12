module t13_sr #(parameter N=8)
  (input wire [N-1:0] A,
  output wire [N-1:0] Y);
  
  assign Y = {1'b0, A[N-1:1]};
  //assign Y[7]=1'b0;
  //assign Y[6]=A[7];
  //assign Y[5]=A[6];
  //assign Y[4]=A[5];
  //assign Y[3]=A[4];
  //assign Y[2]=A[3];
  //assign Y[1]=A[2];
  //assign Y[0]=A[1];
endmodule





