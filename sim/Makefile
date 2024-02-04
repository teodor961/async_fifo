ESC:=$(shell printf '\033')
GREEN:=$(ESC)[1;32m
RED:=$(ESC)[1;31m
HL:=$(ESC)[0;33m
NC:=$(ESC)[0m

CLEAN_TARGET += *.cache
CLEAN_TARGET += *.data
CLEAN_TARGET += *.xpr
CLEAN_TARGET += *.log
CLEAN_TARGET += *.jou
CLEAN_TARGET +=  xgui
CLEAN_TARGET +=  gui
CLEAN_TARGET += *.runs
CLEAN_TARGET += *.srcs
CLEAN_TARGET += *.sdk
CLEAN_TARGET += *.hw
CLEAN_TARGET += *.sim
CLEAN_TARGET += .Xil
CLEAN_TARGET += *.ip_user_files
CLEAN_TARGET += *.str
CLEAN_TARGET += *.txt
CLEAN_TARGET += *.csv
CLEAN_TARGET += *.hbs
CLEAN_TARGET += *.gen
CLEAN_TARGET += *.bit
CLEAN_TARGET += *.xsa
CLEAN_TARGET += *.ltx
CLEAN_TARGET += *.mif
CLEAN_TARGET += *.tmp
CLEAN_TARGET += component.xml
CLEAN_TARGET += *.debug
CLEAN_TARGET += *.dcp
CLEAN_TARGET += *.mem
CLEAN_TARGET += *.pb
CLEAN_TARGET += *.wdb
CLEAN_TARGET += xsim.dir

## RTL sources
RTL_DEPS += ../rtl/async_fifo_top.v
RTL_DEPS += ../rtl/bin2gray.v
RTL_DEPS += ../rtl/dual_port_ram.v
RTL_DEPS += ../rtl/cdc_dff.v

TB_DEPS += tb/tb_async_fifo.sv
TB_DEPS += tb/async_fifo_seq_item.sv
TB_DEPS += tb/async_fifo_driver.sv
TB_DEPS += tb/async_fifo_agent.sv
TB_DEPS += tb/async_fifo_env.sv
TB_DEPS += tb/async_fifo_if.sv
TB_DEPS += tb/async_fifo_sequencer.sv
TB_DEPS += tb/async_fifo_sequence.sv
TB_DEPS += tb/async_fifo_test_basic.sv


SIM_SWITCH := --t
GUI := 0


.PHONY: clean gui 

all: results_tb_async_fifo

clean:
	@echo "Cleaning $(HL)tb_async_fifo$(NC) simulation files ..."
	@rm -rf $(CLEAN_TARGET)
	
gui:
	$(eval GUI := 1)

xsim.dir/work/tb_async_fifo.sdb: $(TB_DEPS)
	@echo -n "Compile testbench $(HL)tb_async_fifo$(NC) ... "; 
	@if xvlog -sv -L uvm $(TB_DEPS) > tb_async_fifo_compile.log; then \
	    echo " $(GREEN)OK$(NC)"; \
	else \
	    echo " $(RED)FAILED$(NC)"; \
	    echo "For details see $(HL)$(CURDIR)/tb_async_fifo_compile.log$(NC)"; \
	    exit 1; \
	fi;
	
xsim.dir/work/async_fifo.sdb: $(RTL_DEPS)
	@echo -n "Compile design sources for $(HL)async_fifo$(NC) ... "
	@if xvlog $(RTL_DEPS) > async_fifo_compile.log; then \
		echo " $(GREEN)OK$(NC)"; \
	else \
	    echo " $(RED)FAILED$(NC)"; \
	    echo "For details see $(HL)$(CURDIR)/async_fifo_compile.log$(NC)"; \
	    exit 1; \
	fi;
	
elab_tb_async_fifo: xsim.dir/work/async_fifo.sdb xsim.dir/work/tb_async_fifo.sdb
	@echo -n "Elaborate $(HL)tb_async_fifo$(NC) ... "
	@if xelab --relax --debug all tb_async_fifo > tb_async_fifo_elab.log; then \
	    echo " $(GREEN)OK$(NC)"; \
	else \
	    echo " $(RED)FAILED$(NC)"; \
	    echo "For details see $(HL)$(CURDIR)/tb_async_fifo_elab.log$(NC)"; \
	    exit 1; \
	fi;

sim_tb_async_fifo: clean elab_tb_async_fifo
	@echo -n "Run simulation for $(HL)tb_async_fifo$(NC) ... "
	@xsim tb_async_fifo $(SIM_SWITCH) sim_tb_async_fifo.tcl > tb_async_fifo_sim.log
	@if [ $(GUI) -eq "1" ]; then \
		echo "LAUNCH WAVEFORM VIEWER"; \
		xsim work.tb_async_fifo.wdb --gui; \
	fi;

results_tb_async_fifo: sim_tb_async_fifo
	@if [ $(file < result.txt) -eq "0" ]; then \
	    echo " $(GREEN)OK$(NC)"; \
	else \
	    echo " $(RED)FAILED$(NC)"; \
	    echo "For details see $(HL)$(CURDIR)/tb_async_fifo_sim.log$(NC)"; \
	    exit 1; \
	fi;
	
	
	
