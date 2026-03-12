module t13_top #(parameter N = 8)
  (input wire clk,rst,load,start,
  input wire [1:0] sel,
  input wire [N-1:0] A_in, B_in,
  output wire [N-1:0] Y_out,
  output wire zero,negative,overflow,carry);
  
  wire rst1,load1,sl,sr,add,sub,done;
  
  t13_cu u1(.clk(clk),.rst(rst),.load(load),.start(start),.done(done),.sel(sel),
            .rst1(rst1),.load1(load1),.sl(sl),.sr(sr),.add(add),.sub(sub));
  t13_dp u2(.clk(clk),.rst1(rst1),.load1(load1),.sl(sl),.sr(sr),.add(add),.sub(sub),.A_in(A_in),.B_in(B_in),
            .Y_out(Y_out),.zero(zero),.negative(negative),.overflow(overflow),.carry(carry),.done(done));
endmodule
  
