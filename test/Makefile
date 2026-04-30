# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

## Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# Traffic controler

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Be very explicit with the path
VERILOG_SOURCES = $(PWD)/../src/project.v

# This MUST match the 'module tt_um_...' name in project.v
TOPLEVEL = tt_um_traffic_light_controller

# This MUST match the 'test.py' filename (without .py)
MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim

