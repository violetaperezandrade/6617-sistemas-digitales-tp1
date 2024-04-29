.PHONY: simulate clean

# Waveform database name
WAVES = waves.vcd

# Compiled file name
OUT = tb.out

# Directories
ROOT_DIR = ..
RTL_DIR = $(ROOT_DIR)/rtl
TB_DIR = $(ROOT_DIR)/tb

TB_NAME=tb

# Source files
RTL_SRCS = $(shell find $(RTL_DIR) -name '*.vhd')
TB_SRCS = $(shell find $(TB_DIR) -name '*.vhd')
SRCS = $(RTL_SRCS) $(TB_SRCS)

# Default target
all: simulate

# Compile the TB and RTL
$(OUT): $(SRCS)
	ghdl -a --std=08 $(RTL_SRCS)
	ghdl -a --std=08 $(TB_SRCS)
	ghdl -e --std=08 $(TB_NAME)
	ghdl -r --std=08 $(TB_NAME) --vcd=$(WAVES)

# Generate waves database
simulate: $(OUT)

clean:
	rm -rf $(WAVES) $(OUT) *.o *.cf
