# Puzzle-Gadget-FPGA
The idea is two implement windows game, puzzle gadget on FPGA using Vivado as design suite.
Implementation will be done on Basys 3 FPGA board. 
The XDC file used is a modification to master xdc file available at:
https://github.com/Digilent/Basys3/tree/master/Resources/XDC


You may view the game that I am talking about by checking out
the following link: https://youtu.be/GI9cg2orYf4 . We may build a
similar game of 3*3 matrix with entries from 0 to 8 and a blank space.
The numbers are randomly distributed in the matrix initially. The
player may, at any time, view the current status of the game using
three switches. The player may play by shifting the blank box by 1 unit
(up, down, left or right). The position of the blank space may be
altered (thereby altering the status of the full matrix) using the
buttons btnL, btnR, btnU and btnD .
