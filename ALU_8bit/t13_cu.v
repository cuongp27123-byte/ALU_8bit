module t13_cu(
  input wire clk,rst,load,start,done,
  input wire [1:0] sel,
  output reg rst1,load1,sl,sr,add,sub);
  
  localparam [2:0] s_idle=3'b000,s_rst=3'b001,s_load=3'b010,s_start=3'b011,s_compute=3'b100,s_done=3'b101;
  reg [2:0] state, next_state;
  
  always @(posedge clk or posedge rst) begin
    if(rst)
      state <= s_rst;
    else
      state <= next_state;
  end
  
  always @(*) begin
    next_state <= state;
    case(state)
      s_idle: begin
        if(rst) next_state <= s_rst;
        else if(load) next_state <= s_load;
        else if(start) next_state <= s_start;
        else next_state <= s_idle;
      end
      s_rst: next_state <= s_idle;
      s_load: next_state <= s_idle;
      s_start: next_state <= s_compute;
      s_compute: begin
        if(done) next_state <= s_done;
      end
      s_done: next_state <= s_idle;
      default: next_state <= s_idle;
    endcase
  end
  
  always @(*) begin
    rst1=1'b0; load1=1'b0; 
    sl=1'b0; sr=1'b0; add=1'b0; sub=1'b0;
    case(state)
      s_rst: rst1 = 1'b1;
      s_load: load1= 1'b1;
      s_compute: begin
        if(sel == 2'b00) sl = 1'b1;
        else if(sel == 2'b01) sr = 1'b1;
        else if(sel == 2'b10) add = 1'b1;
        else if(sel == 2'b11) sub = 1'b1;
        else begin sl=1'b0; sr=1'b0; add=1'b0; sub=1'b0; end
      end
      default: begin
        rst1=1'b0; load1=1'b0; 
        sl=1'b0; sr=1'b0; add=1'b0; sub=1'b0;
      end
    endcase
  end
endmodule
    