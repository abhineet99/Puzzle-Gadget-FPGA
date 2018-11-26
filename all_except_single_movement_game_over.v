`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2018 14:22:57
// Design Name: 
// Module Name: game_over
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module game_over(
    input wire [11:0] r1,
    input wire [11:0] r2,
    input wire [11:0] r3,
    output reg result
    );
    
always @(*)begin    
    if(r1[11:8]==4'b0001 && r1[7:4]==4'b0010 && r1[3:0]==4'b0011 && r2[11:8]==4'b0100 && r2[7:4]==4'b0101 && r2[3:0]==4'b0110 && r3[11:8]==4'b0111 && r3[7:4]==4'b1000 && r3[3:0]==4'b0000)
        result <= 1'b1;
    else result <= 1'b0;
end
    
endmodule

