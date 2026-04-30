// Testbench for Traffic Light Controller FSM
`timescale 1ns/1ps

module finite_state_machine_tb;
    reg clock;
    reg reset;
    wire green, yellow, red, done;

    finite_state_machine uut (
        .clock(clock),
        .reset(reset),
        .green(green),
        .yellow(yellow),
        .red(red),
        .done(done)
    );

    // Clock generation
    initial clock = 0;
    always #5 clock = ~clock; // 10ns period

    initial begin
        $display("Starting FSM Testbench");
        reset = 1;
        #12;
        reset = 0;
        #100;
        $display("Test complete");
        $finish;
    end

    always @(posedge clock) begin
        $display("T=%0t | reset=%b | green=%b yellow=%b red=%b done=%b", $time, reset, green, yellow, red, done);
    end
endmodule

