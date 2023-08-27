.PHONY: all simulate clean

PROJECT_NAME := async_fifo
export PROJECT_NAME

VIVADO := vivado -mode batch -source

RTL_DEPS += $(wildcard ../rtl/*)
TESTBENCH_DEPS += $(wildcard ../tb/*)

BUILD_DEPS += RTL_DEPS
BUILD_DEPS += TESTBENCH_DEPS


CLEAN_TARGET += *.cache
CLEAN_TARGET += *.data
CLEAN_TARGET += *.xpr
CLEAN_TARGET += *.log
CLEAN_TARGET += *.jou
CLEAN_TARGET +=  xgui
CLEAN_TARGET += *.runs
CLEAN_TARGET += *.srcs
CLEAN_TARGET += *.sdk
CLEAN_TARGET += *.hw
CLEAN_TARGET += *.sim
CLEAN_TARGET += .Xil
CLEAN_TARGET += *.ip_user_files
CLEAN_TARGET += *.str
CLEAN_TARGET += mem_init_sys.txt
CLEAN_TARGET += tight_setup_hold_pins.txt
CLEAN_TARGET += *.csv
CLEAN_TARGET += *.hbs
CLEAN_TARGET += *.gen
CLEAN_TARGET += *.xsa
CLEAN_TARGET += *.mif
CLEAN_TARGET += *.tmp
CLEAN_TARGET += component.xml
CLEAN_TARGET += *.debug
CLEAN_TARGET += *.dcp

all: simulate

clean:
	@echo "Cleaning vivado files ..."
	-rm -rf $(CLEAN_TARGET)
	
project: clean
	$(VIVADO) create_project.tcl
	

simulate: project
	$(VIVADO) 
