`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2018 11:16:12
// Design Name: 
// Module Name: display
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


module play_game(
   input wire l,
   input wire r,
   input wire u,
   input wire d,
   input wire[11:0] Row1, 
   input wire[11:0] Row2,
   input wire[11:0] Row3,
   output reg[11:0] r1,
   output reg[11:0] r2,
   output reg[11:0] r3
    );
    
reg [3:0]pointer=4'b0000;  //check in matrix which entry is zero.(that's our pointer).
//reg temp_l;
//reg temp_r;
//reg temp_u;
//reg temp_d;
//initial
//begin
//    temp_l=0;
//    temp_r=0;
//    temp_u=0;
//    temp_d=0;
//end

//random_matrix_module(clk,btnc,r1,r2,r3); call abhi's module and store in r1,r2,r3.

always @(*)
begin
    r1[11:0]=Row1[11:0];
    r2[11:0]=Row2[11:0];
    r3[11:0]=Row3[11:0];
//    if(!l)
//        temp_l=0;
//    if(!r)
//        temp_r=0;
//    if(!u)
//        temp_u=0;
//    if(!d)
//        temp_d=0;
    if(l)begin
//        temp_l=1;
        if(!(pointer==r1[11:8] || pointer==r2[11:8] || pointer==r3[11:8]))begin             //swap with left digit..
           
            if(pointer==r1[7:4])begin 
                r1[7:4] = r1[11:8]; 
                r1[11:8] = 4'b000;
//                pointer = r1[11:8];
            end
            else if(pointer==r2[7:4])begin 
                    r2[7:4] = r2[11:8]; 
                    r2[11:8] = 4'b000;
//                    pointer = r2[11:8];
            end
            else if(pointer==r3[7:4])begin 
                    r3[7:4] = r3[11:8]; 
                    r3[11:8] = 4'b000;
//                    pointer = r3[11:8];
            end   
            
            if(pointer==r1[3:0])begin 
                r1[3:0] = r1[7:4]; 
                r1[7:4] = 4'b000;
//                pointer = r1[7:4];
            end
            else if(pointer==r2[3:0])begin 
                r2[3:0] = r2[7:4]; 
                r2[7:4] = 4'b000;
//                pointer = r2[7:4];
            end
            else if(pointer==r3[3:0])begin 
                r3[3:0] = r3[7:4]; 
                r3[7:4] = 4'b000;
//                pointer = r3[7:4];
            end                                                
        end
    end
    
    else if(r)begin
//         temp_r=1;
         if(!(pointer==r1[3:0] || pointer==r2[3:0] || pointer==r3[3:0]))begin                 //swap with right digit..

            if(pointer == r1[7:4])begin
                r1[7:4] = r1[3:0];
                r1[3:0] = 4'b0000;
//                pointer = r1[3:0];
            end
            else if(pointer == r2[7:4])begin
                r2[7:4] = r2[3:0];
                r2[3:0] = 4'b0000;
//                pointer = r2[3:0];
            end
            else if(pointer == r3[7:4])begin
                r3[7:4] = r3[3:0];
                r3[3:0] = 4'b0000;
//                pointer = r3[3:0]; 
            end               
            
            else if(pointer == r1[11:8])begin
                 r1[11:8] = r1[7:4];
                 r1[7:4] = 4'b0000;
//                 pointer = r1[7:4];
            end            
            else if(pointer == r2[11:8])begin
                 r2[11:8] = r2[7:4];
                 r2[7:4] = 4'b0000;
//                 pointer = r2[7:4];
            end
            else if(pointer == r3[11:8])begin
                 r3[11:8] = r3[7:4];
                 r3[7:4] = 4'b0000;
//                 pointer = r3[7:4];
            end
                                             
         end
    end
    
    else if(u)begin
//        temp_u=1;
         if(!(pointer==r1[11:8] || pointer==r1[7:4] || pointer==r1[3:0]))begin             //swap with up digit..       
            
            if(pointer == r2[3:0])begin
                r2[3:0] = r1[3:0];
                r1[3:0] = 4'b0000;
//                pointer = r1[3:0];
            end
            else if(pointer == r2[7:4])begin
                r2[7:4] = r1[7:4];
                r1[7:4] = 4'b0000;
//                pointer = r1[7:4];
            end         
            else if(pointer == r2[11:8])begin
                r2[11:8] = r1[11:8];
                r1[11:8] = 4'b0000;
//                pointer = r1[11:8];
            end  
            
            else if(pointer == r3[3:0])begin
                r3[3:0] = r2[3:0];
                r2[3:0] = 4'b0000;
//                pointer = r2[3:0];
            end
            else if(pointer == r3[7:4])begin
                r3[7:4] = r2[7:4];
                r2[7:4] = 4'b0000;
//                pointer = r2[7:4];
            end         
            else if(pointer == r3[11:8])begin
                r3[11:8] = r2[11:8];
                r2[11:8] = 4'b0000;
//                pointer = r2[11:8];
            end  
                                  
         end
    end
        
    else if(d)begin
//         temp_d=1;
         if(!(pointer==r3[11:8] || pointer==r3[7:4] || pointer==r3[3:0]))begin            //swap with down digit..            
         
            if(pointer == r2[3:0])begin
             r2[3:0] = r3[3:0];
             r3[3:0] = 4'b0000;
//             pointer = r3[3:0];
             end
             else if(pointer == r2[7:4])begin
                 r2[7:4] = r3[7:4];
                 r3[7:4] = 4'b0000;
//                 pointer = r3[7:4];
             end         
             else if(pointer == r2[11:8])begin
                 r2[11:8] = r3[11:8];
                 r3[11:8] = 4'b0000;
//                 pointer = r3[11:8];
             end  
             
             else if(pointer == r1[3:0])begin
                 r1[3:0] = r2[3:0];
                 r2[3:0] = 4'b0000;
//                 pointer = r2[3:0];
             end
             else if(pointer == r1[7:4])begin
                 r1[7:4] = r2[7:4];
                 r2[7:4] = 4'b0000;
//                 pointer = r2[7:4];
             end         
             else if(pointer == r1[11:8])begin
                 r1[11:8] = r2[11:8];
                 r2[11:8] = 4'b0000;
//                 pointer = r2[11:8];
             end  
         
         end
    end

end

endmodule
