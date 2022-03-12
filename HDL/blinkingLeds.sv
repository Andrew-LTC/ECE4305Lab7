`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 03:47:46 PM
// Design Name: 
// Module Name: blinkingLeds
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


module blinkingLeds
    #(parameter W = 4)( //core will control 4 discrete LEDS
    input logic clk, reset,
    //slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    //external port
    output logic [W-1:0] LED
    );
    
    //declaration
    //4 16 bit registers 
    logic [15:0] led_reg [3:0];//???? was originally [1:0] but error indicating index 2 and 3 out of range???
    logic wr_en;
    
    //**LED Blinking Circuit**//
    //replicated 4 times
    generate
        genvar i;
        for(i=0; i<4; i=i+1)
        begin: blinkingCircuit
            singleLedBlink #(.bits(16)) (
                .finalValue(led_reg[i]),
                .led(LED[i]),
                .*
            );
        end
    endgenerate
    
    //**Wrapping Circuit**//
    //LED registers
    always_ff@(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            led_reg[0] <= 0;
            led_reg[1] <= 0;
            led_reg[2] <= 0;
            led_reg[3] <= 0;
        end
        else
        begin
            if(wr_en)
            begin
                if(addr[1:0] == 2'b00)
                    led_reg[0] <= wr_data[15:0];   
                if(addr[1:0] == 2'b01)
                    led_reg[1] <= wr_data[15:0];   
                if(addr[1:0] == 2'b10)
                    led_reg[2] <= wr_data[15:0];   
                if(addr[1:0] == 2'b11)
                    led_reg[3] <= wr_data[15:0];   
            end
        end
    end
    
    //want to write whenever we are in addr's 0 - 3
    assign wr_en = write && cs && (addr <= 3);
    //since this core doesn't need to read
    assign rd_data = 0;
endmodule
