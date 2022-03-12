`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2022 08:00:35 AM
// Design Name: 
// Module Name: timerMs_input
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


module timerMs_input
    #(parameter bits = 16)(
    input logic clk, reset,
    input logic [bits - 1:0] finalValue,
    output logic done
    );
    
    logic [2*bits-1:0] r_reg, r_next;
    
    always_ff@(posedge clk, posedge reset)
    begin
        if(reset)
            r_reg <= 0;
        else
            r_reg <= r_next;
    end
    
    assign r_next = (r_reg == finalValue * 1_000_000)? 1 : r_reg + 1;
    
    assign done = (r_reg == finalValue * 1_000_000);
endmodule
