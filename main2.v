`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:52:53 06/12/2014 
// Design Name: 
// Module Name:    seg7decimal 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seg7decimal(

	input [15:0] x,
    input clk,
    input clr,
    output reg [6:0] a_to_g,
    output reg [3:0] an,
    output wire dp ,
    input btnl
	 );
	 
	 
wire [1:0] s;	 
reg [8:0] whichdone;
initial begin
whichdone=9'b00000000;//which matrix slot already has a number
end
reg [3:0] digit;
reg [3:0] todisplay;
wire [3:0] aen;
reg [19:0] clkdiv;
reg [3:0] lol;
//reg [1:0] first_time;

reg [11:0] row1;//matrix rows
reg [11:0] row2;
reg [11:0] row3;
reg [1:0]btnonce;
//assign btnonce=2'b01;
initial begin
btnonce=2'b00;
lol=4'b0001; //number to be entered in the matrix
row1=12'b000000000000;
row2=12'b000000000000;
row3=12'b000000000000;
end

always @(posedge clk)
	if(! (whichdone==9'b111111101 || whichdone==9'b111111110 || whichdone==9'b111111101 || whichdone==9'b111111011 || whichdone==9'b111110111 || whichdone==9'b111101111 || whichdone==9'b011111111 || whichdone==9'b101111111 || whichdone==9'b110111111))
begin
if(btnl==1)
begin
randomGen(.inBtn(btnonce[1:0]),.inRand(clkdiv[3:0]),.outNum(digit));
whichdone[digit]=1;
btnonce=1;
 case (digit)
  0:row1[11:8]=lol[3:0];
  1:row1[7:4]=lol[3:0];
  2:row1[3:0]=lol[3:0];
  3:row2[11:8]=lol[3:0];
  4:row2[7:4]=lol[3:0];
  5:row2[3:0]=lol[3:0];
  6:row3[11:8]=lol[3:0];
  7:row3[7:4]=lol[3:0];
  8:row3[3:0]=lol[3:0];
  
  
  endcase
 lol=lol+1;  
btnonce=1;
end
else if(btnonce==1)

// or posedge clr)
/*if(btnl==1 and btnonce==0)
*/
begin
   randomGen(.inBtn(btnonce[1:0]),.inRand(digit[3:0]),.outNum(digit));
   
   
  if(whichdone[digit]==0)
   begin
   whichdone[digit]=1;
   case (digit)
   0:row1[11:8]=lol[3:0];
   1:row1[7:4]=lol[3:0];
   2:row1[3:0]=lol[3:0];
   3:row2[11:8]=lol[3:0];
   4:row2[7:4]=lol[3:0];
   5:row2[3:0]=lol[3:0];
   6:row3[11:8]=lol[3:0];
   7:row3[7:4]=lol[3:0];
   8:row3[3:0]=lol[3:0];
   
   
   endcase
   lol=lol+1;
   lol=lol%9;
   
   //end
   
end    
end
end

   
/*assign dp = 0;
assign s = clkdiv[19:18];
assign aen = 4'b1111; // all turned off initially
end */

endmodule
// quad 4to1 MUX.
/*
always @(posedge clk)
if(btnonce==1)
begin
digit=(digit+clkdiv[7:4])^clkdiv[11:8]^clkdiv[10:7];
digit=digit%9;

 if(whichdone[digit]==0)
begin
whichdone[digit]=1;
case (digit)
0:row1[11:8]=lol[3:0];
1:row1[7:4]=lol[3:0];
2:row1[3:0]=lol[3:0];
3:row2[11:8]=lol[3:0];
4:row2[7:4]=lol[3:0];
5:row2[3:0]=lol[3:0];
6:row3[11:8]=lol[3:0];
7:row3[7:4]=lol[3:0];
8:row3[3:0]=lol[3:0];


endcase
lol=lol+1;
lol=lol%9;
end
end
*/
/*

always @(posedge clk)// or posedge clr)
if(x[0]==1)
begin	   
	case(s)
	
	
	
	0:todisplay = row1[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
	1:todisplay= row1[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
	2:todisplay= row1[11:8]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
	3:todisplay = 10; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
	//	default:digit = x[3:0];
	
	endcase
end	
else if(x[1]==1)
begin	   
	case(s)
	
	
	
	0:todisplay = row2[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
	1:todisplay = row2[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
	2:todisplay= row2[11:8];
	3:todisplay = 10; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
	//3:digit = x[15:12]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
	//	default:digit = x[3:0];
	
	endcase
end	
else if(x[2]==1)
begin	   
	case(s)
	
	
	
	0:todisplay= row3[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
        1:todisplay = row3[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
        2:todisplay = row3[11:8]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
	3:todisplay = 10;
	endcase
end	
else
 todisplay=0;
	//decoder or truth-table for 7a_to_g display values
	always @(*)

case(todisplay)


//////////<---MSB-LSB<---
//////////////gfedcba////////////////////////////////////////////              a
0:a_to_g = 7'b1000000;////0000												   __					
1:a_to_g = 7'b1111001;////0001												f/	  /b
2:a_to_g = 7'b0100100;////0010												  g
//                                                                           __	
3:a_to_g = 7'b0110000;////0011										 	 e /   /c
4:a_to_g = 7'b0011001;////0100												 __
5:a_to_g = 7'b0010010;////0101                                               d  
6:a_to_g = 7'b0000010;////0110
7:a_to_g = 7'b1111000;////0111
8:a_to_g = 7'b0000000;////1000
9:a_to_g = 7'b0010000;////1001
10: a_to_g=7'b11111111;
'hA:a_to_g = 7'b0111111; // dash-(g)
'hB:a_to_g = 7'b1111111; // all turned off
'hC:a_to_g = 7'b1110111;

default: a_to_g = 7'b0000000; // U

endcase


always @(*)begin
an=4'b1111;
if(aen[s] == 1)
an[s] = 0;
end


//clkdiv
always @(posedge clk or posedge clr) begin
if ( clr == 1)
begin
clkdiv <= 0;
//lol<=1;
end
else
clkdiv <= clkdiv+1;
end
*/

