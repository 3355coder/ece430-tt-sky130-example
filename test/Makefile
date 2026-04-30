# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

## Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# Traffic controler

SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src

# Ensure this matches your filename exactly
VERILOG_SOURCES += $(SRC_DIR)/project.v

# This must match the 'module tt_um_...' name in project.v
TOPLEVEL = tt_um_traffic_light_controller

# This must match your 'test.py' filename
MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim

