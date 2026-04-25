# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

## Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# Makefile for HW08 - PM32 Multiplier Verification
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# 1. Point to the actual location of your source files
SRC_DIR = /foss/common/pm32

# 2. Specify the files in that directory
PROJECT_SOURCES = pm32.v spm.v

# RTL simulation setup
SIM_BUILD = sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

# 3. Point to the main module (pm32) and the Python test (test.py)
TOPLEVEL = pm32
COCOTB_TEST_MODULES = test

# Include cocotb's make rules
include $(shell cocotb-config --makefiles)/Makefile.sim

