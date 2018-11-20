`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2018 11:15:35
// Design Name: 
// Module Name: randomGen
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


module randomGen(
    input [1:0] inBtn,
    input [3:0] inRand,
    output reg [3:0]outNum
    );
reg [3:0] to_out;
always@*
if(inBtn==2'b01)
    begin 
    to_out[3:0]=inRand[3:0];
    outNum=to_out%9;    
    end
else
    begin
    to_out[3:0]=(inRand[3:0]*7)%17;
    outNum=to_out%9;
    end    
endmodule
