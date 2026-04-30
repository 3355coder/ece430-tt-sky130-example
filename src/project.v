/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */


`default_nettype none

module tt_um_traffic_light_controller (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    wire _unused = &{ui_in, uio_in, ena, 1'b0}; 

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;      
    assign uo_out[7:4] = 4'b0;  

    wire reset_high = !rst_n;

    finite_state_machine my_fsm (
        .clock  (clk),
        .reset  (reset_high),
        .green  (uo_out[0]),
        .yellow (uo_out[1]),
        .red    (uo_out[2]),
        .done   (uo_out[3])
    );

endmodule

module finite_state_machine(
    input clock,
    input reset,
    output reg green,
    output reg yellow,
    output reg red,
    output reg done
);
    parameter GREEN  = 2'b00;
    parameter YELLOW = 2'b01;
    parameter RED    = 2'b10;

    reg [1:0] state, next_state;
    reg [3:0] timer;

    parameter GREEN_TIME  = 5;
    parameter YELLOW_TIME = 2;
    parameter RED_TIME    = 4;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= GREEN;
            timer <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state != next_state)
                timer <= 0;
            else
                timer <= timer + 1;
            done <= (state == RED && timer == RED_TIME);
        end
    end

    always @(*) begin
        green = 0; yellow = 0; red = 0;
        case (state)
            GREEN: begin
                green = 1;
                next_state = (timer >= GREEN_TIME) ? YELLOW : GREEN;
            end
            YELLOW: begin
                yellow = 1;
                next_state = (timer >= YELLOW_TIME) ? RED : YELLOW;
            end
            RED: begin
                red = 1;
                next_state = (timer >= RED_TIME) ? GREEN : RED;
            end
            default: next_state = GREEN;
        endcase
    end
endmodule



