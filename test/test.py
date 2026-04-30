# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_traffic_light(dut):
    dut._log.info("Starting Traffic Light Controller Test")

    # Start the clock (10us period)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Resetting...")
    dut.rst_n.value = 0 # Low-active reset
    await Timer(20, unit="us")
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)

    # Verify Green State (First 5 cycles)
    dut._log.info("Checking Green phase")
    for i in range(5):
        await RisingEdge(dut.clk)
        val = dut.uo_out.value.integer # Convert to integer for bitwise check
        assert (val & 1) == 1, f"Expected Green (bit 0) at cycle {i}, got {val}"

    # Verify Yellow State (2 cycles)
    dut._log.info("Checking Yellow phase")
    await RisingEdge(dut.clk)
    val = dut.uo_out.value.integer
    assert (val & 2) == 2, f"Expected Yellow (bit 1), got {val}"
    
    # Wait for Red (bit 2)
    dut._log.info("Checking Red phase")
    while (dut.uo_out.value.integer & 4) == 0:
        await RisingEdge(dut.clk)
    
    dut._log.info("Test passed!")

