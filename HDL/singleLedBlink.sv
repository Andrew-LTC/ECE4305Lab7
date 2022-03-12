`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 04:02:26 PM
// Design Name: 
// Module Name: singleLedBlink
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


module singleLedBlink
    #(parameter bits = 16)(
    input logic clk, reset,
    input logic [bits - 1:0] finalValue,
    output logic led
    );
    
    //declaration
    logic timerOut;
    
    timerMs_input #(.bits(bits)) (
        .finalValue(finalValue),
        .done(timerOut),
        .*
    );
    
    t_ff TFF (
        .t(timerOut),
        .q(led),
        .*
    );
endmodule
