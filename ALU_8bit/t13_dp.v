module t13_dp #(parameter N=8)
  (input wire rst1,load1,sl,sr,add,sub,clk,
  input wire [N-1:0] A_in,B_in,
  output reg [N-1:0] Y_out,
  output reg zero,negative,overflow,carry,
  output reg done);
  
  reg [N-1:0] A,B,Y;
  reg zero_reg,negative_reg,overflow_reg,carry_reg,done_reg;
  wire [N-1:0] Y_sl,Y_sr,Y_add,Y_sub;
  wire carry1,borrow1;
  
  t13_sl u1(.A(A),.Y(Y_sl));
  t13_sr u2(.A(A),.Y(Y_sr));
  t13_addsub u3(.A(A),.B(B),.Cin(1'b0),.Y(Y_add),.Cout(carry1));
  t13_addsub u4(.A(A),.B(B),.Cin(1'b1),.Y(Y_sub),.Cout(borrow1));
  
  always @(posedge clk or posedge rst1) begin
    if(rst1) begin
      A <= {N{1'b0}};
      B <= {N{1'b0}};
    end else if(load1) begin
      A <= A_in;
      B <= B_in;
    end
  end
  always @(posedge clk or posedge rst1) begin
    if(rst1) begin
      Y_out <= {N{1'b0}};
      zero <= 1'b0;
      negative <= 1'b0;
      overflow <= 1'b0;
      carry <= 1'b0;
      done <= 1'b0;
    end else begin
      Y_out <= Y;
      zero <= zero_reg;
      negative <= negative_reg;
      overflow <= overflow_reg;
      carry <= carry_reg;
      done <= done_reg;
    end
  end
  
  always @(*) begin
    carry_reg=0; zero_reg=0; negative_reg=0; overflow_reg=0; done_reg=0; 
    Y = Y_out;
    if(sl) begin
      Y = Y_sl;
      zero_reg = (Y_sl == {N{1'b0}});
      negative_reg = Y_sl[N-1];
      done_reg = 1'b1;
    end else if(sr) begin
      Y = Y_sr;
      zero_reg = (Y_sr == {N{1'b0}});
      negative_reg = Y_sr[N-1];
      done_reg = 1'b1;
    end else if(add) begin
      Y = Y_add;
      zero_reg = (Y_add == {N{1'b0}});
      carry_reg = carry1;
      overflow_reg = (A[N-1] == B[N-1]) && (Y_add[N-1] != A[N-1]);
      negative_reg = Y_add[N-1];
      done_reg = 1'b1;
    end else if(sub) begin
      Y = Y_sub;
      zero_reg = (Y_sub == {N{1'b0}});
      carry_reg = borrow1;
      overflow_reg = (A[N-1] != B[N-1]) && (Y_sub[N-1] != A[N-1]);
      negative_reg = Y_sub[N-1];
      done_reg = 1'b1;
    end 
  end
endmodule
