`timescale 1ns / 1ps

module seg7decimal(
	input [2:0] x,
    input clk,
    input wire clr,
    input wire btnl,
    input wire btnr,
    input wire btnu,
    input wire btnd,
    output reg [6:0] a_to_g,
    output reg [3:0] an,
    output wire dp
	 );
reg [3:0] offset;
wire [1:0] s;
reg [3:0] j=0; 
reg [8:0] whichdone=9'b110000000;
reg [3:0] digit;
reg [3:0] to_digit;
reg [3:0] todisplay;
wire [3:0] aen;
reg [19:0] clkdiv;
reg [3:0] lol=4'b0001;
reg [11:0] row1;//matrix rows
reg [11:0] row2;
reg [11:0] row3;
wire [11:0] Row1;
wire [11:0] Row2;
wire [11:0] Row3;
reg btnonce=0;
wire res;
assign dp = 0;
assign s = clkdiv[19:18];
assign aen = 4'b1111;
play_game A(.l(btnl),.r(btnr),.u(btnu),.d(btnd),.Row1(row1),.Row2(row2),.Row3(row3),.r1(Row1),.r2(Row2),.r3(Row3));
game_over B(.r1(row1),.r2(row2),.r3(row3),.result(res));
always @(posedge clk)// or posedge clr)
begin
    if(!clr)
    begin
        row1[11:0]=Row1[11:0];
        row2[11:0]=Row2[11:0];
        row3[11:0]=Row3[11:0];
    end
    if(clr)
    begin
       
       whichdone=9'b110000000;
       lol=4'b0001;
       row1=12'b000000000000;
       row2=12'b000000000000;
       row3=12'b000010000000;
       digit=clkdiv[3:0];
       digit=digit%7;
       btnonce=1'b1;
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
    
    else if (btnonce==1)
    begin
        j=j+1;
        offset=5-digit%5;
        to_digit=((digit+j*offset)%7);
        if(whichdone[to_digit]==0)
        begin
        
            j=0;
            whichdone[to_digit]=1;
            case (to_digit)
            
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
            digit=to_digit;
            lol=lol+1;
            lol=lol%9;
            
        end
    end
end
initial
begin
    
    lol=4'b0001; //number to be entered in the matrix
    row1=12'b000000000000;
    row2=12'b000000000000;
    row3=12'b000010000000;
    
end

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
    if(res==1)
        if(!an[0])
            a_to_g = 7'b0000010;
        else if(!an[1])
            a_to_g = 7'b1001000;
        else if(!an[2])
            a_to_g = 7'b1000000;
        else
            a_to_g = 7'b1000110;
    else
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
        10: a_to_g=7'b1111111;
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
always @(posedge clk or posedge clr)
begin
    if ( clr == 1&& btnonce==1'b0 )
        clkdiv <= 0;
    else
        clkdiv <= clkdiv+1;
end

endmodule