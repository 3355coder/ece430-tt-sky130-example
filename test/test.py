# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_pm32_multiplier(dut):
    # 1. Start Clock 
    clock = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(clock.start())

    async def do_multiplication(a, b):
        # Reset
        dut.rst.value = 1
        dut.start.value = 0
        await RisingEdge(dut.clk)
        dut.rst.value = 0
        await RisingEdge(dut.clk)

        # Set values and pulse start
        dut.mc.value = a
        dut.mp.value = b
        dut.start.value = 1
        await RisingEdge(dut.clk)
        dut.start.value = 0

        # Wait for 'done' signal (64 cycles)
        while not dut.done.value:
            await RisingEdge(dut.clk)
        
        # Use to_unsigned() for clear results
        return dut.p.value.to_unsigned()

    # --- Test Case 1: Small Positive ---
    val_a, val_b = 7, 9
    actual = await do_multiplication(val_a, val_b)
    expected = val_a * val_b
    dut._log.info(f"Test 1: {val_a} * {val_b} = {actual}")
    assert actual == expected, f"Error: Expected {expected}, got {actual}"

    # --- Test Case 2: Larger Positive ---
    val_a, val_b = 1234, 5678
    actual = await do_multiplication(val_a, val_b)
    expected = val_a * val_b
    dut._log.info(f"Test 2: {val_a} * {val_b} = {actual}")
    assert actual == expected, f"Error: Expected {expected}, got {actual}"

    dut._log.info("All PM32 tests passed!")

