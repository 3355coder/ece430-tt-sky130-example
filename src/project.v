/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */


`default_nettype none

module tt_um_traffic_light_controller (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // Bidirectional input
    output wire [7:0] uio_out,  // Bidirectional output
    output wire [7:0] uio_oe,   // Bidirectional enable
    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    wire reset = ~rst_n;  // TT uses active-low rst_n; FSM expects active-high
    wire green, yellow, red, done;

    // Map traffic light outputs to lower bits of uo_out (TT standard)
    assign uo_out = {4'b0000, done, red, yellow, green};
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;  // Bidirectional pins unused

    finite_state_machine fsm (
        .clock (clk),
        .reset (reset),
        .green (green),
        .yellow(yellow),
        .red   (red),
        .done  (done)
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
            done  <= 0;
        end else begin
            state <= next_state;
            if (state != next_state)
                timer <= 0;
            else
                timer <= timer + 1;
            done <= (state == RED && timer == RED_TIME - 1);  // Fix off-by-one timing
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


