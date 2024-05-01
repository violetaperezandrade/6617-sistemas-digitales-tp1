.PHONY: simulate clean

# Waveform database name
WAVES = waves.ghw

# Compiled file name
OUT = tb.out

# Directories
ROOT_DIR = ..
RTL_DIR = $(ROOT_DIR)/rtl
TB_DIR = $(ROOT_DIR)/tb

TB_NAME=tb

# Source files
RTL_SRCS = $(shell find $(RTL_DIR) -name '*.vhd' ! -name '*_pkg.vhd')
TB_SRCS = $(shell find $(TB_DIR) -name '*.vhd')
PKG_SRCS = $(shell find $(RTL_DIR) -name '*_pkg.vhd')
SRCS = $(PKG_SRCS) $(RTL_SRCS) $(TB_SRCS)

# Default target
all: simulate

# Compile package files
pkg_compile: $(PKG_SRCS)
	ghdl -a --std=08 $(PKG_SRCS)

# Compile the TB and RTL
$(OUT): pkg_compile $(SRCS)
	ghdl -a --std=08 $(RTL_SRCS)
	ghdl -a --std=08 $(TB_SRCS)
	ghdl -e --std=08 $(TB_NAME)
	ghdl -r --std=08 $(TB_NAME) --wave=$(WAVES)

# Generate waves database
simulate: $(OUT)

clean:
	rm -rf $(WAVES) $(OUT) *.o *.cf
