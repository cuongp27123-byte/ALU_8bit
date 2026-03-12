`timescale 1ns/1ps
module t13_tb #(parameter N=8);
  reg clk,rst,load,start;
  reg [1:0] sel;
  reg [N-1:0] A_in, B_in;
  wire [N-1:0] Y_out;
  wire zero, negative, overflow, carry;
  
  t13_top dut(.clk(clk),.rst(rst),.load(load),.start(start),.sel(sel),.A_in(A_in),.B_in(B_in),
              .Y_out(Y_out),.zero(zero),.negative(negative),.overflow(overflow),.carry(carry));
  
  initial begin
    clk = 1'b1;
    forever #5 clk=~clk;
  end
  
  initial begin
    $dumpfile("t13_top.vcd");
    $dumpvars(0, t13_tb);
    $display("Time|clk|rst load start sel A_in B_in|Y_out zero negative overflow carry");
    $monitor("%4t |%b|%b %b %b %2b %8b %8b| %8b %b %b %b %b", 
              $Time,clk,rst,load,start,sel,A_in,B_in,Y_out,zero,negative,overflow,carry);

    rst=1;load=0;start=0;sel=2'b00;A_in=8'b11001100;B_in=11110000;#20;
    rst=0;#20;
    start=1;#20;start=0;#60;
    load=1;#20;load=0;#20;
    start=1;#20;start=0;#60;
    sel=2'b01;#20;
    start=1;#20;start=0;#60;
    sel=2'b10;#20;
    start=1;#20;start=0;#60;
    sel=2'b11;#20;
    start=1;#20;start=0;#60;
    rst=1;#20;rst=0;#20;
    A_in=8'b10000000;B_in=8'b10010000;#20;
    load=1;#20;load=0;#20;
    sel=2'b00;#20;
    start=1;#20;start=0;#60;
    sel=2'b01;#20;
    start=1;#20;start=0;#60;
    sel=2'b10;#20;
    start=1;#20;start=0;#60;
    sel=2'b11;#20;
    start=1;#20;start=0;#60;
    A_in=8'b01100110;B_in=8'b10011110;#20;
    load=1;#20;load=0;#20;
    sel=2'b00;#20;
    start=1;#20;start=0;#60;
    sel=2'b01;#20;
    start=1;#20;start=0;#60;
    sel=2'b10;#20;
    start=1;#20;start=0;#60;
    sel=2'b11;#20;
    start=1;#20;start=0;#60;
    $finish;
  end
endmodule
