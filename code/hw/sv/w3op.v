`timescale 1ns / 1ps
`include "hi5_opcodes.h"

module w3op (
            clock,
            code // 36 bit HI5 instructions
);

input wire clock ;
input wire [35:0] code ;

reg[63:0] REGFILE [0:255] ;

always @ (posedge clock)
begin
  //$stop;
  if (`TEST32_OPC == code[35:35-`TEST32_LEN+1]) begin
      REGFILE[0][31:0] <= #1 code[31:0] ;
      $display("@%0dns this is selected, opcode TEST32 %b",$time, code);  
  end else if (`LOW32_OPC == code[35:35-`LOW32_LEN+1]) begin
      REGFILE[0][31:0] <= #1 code[31:0] ;
      $display("@%0dns this is selected, opcode LOW32 %b",$time, code);
  end else if (`HIGH32_OPC == code[35:35-`HIGH32_LEN+1]) begin
      REGFILE[0][63:32] <= #1 code[31:0] ;
      $display("@%0dns this is selected, opcode HIGH32 %b",$time, code);
  end else begin
      $display("@%0dns: no match for opcode %b",$time, code);
      REGFILE[0] <= #1 0;
  end
end 

endmodule 
