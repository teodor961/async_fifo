//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_agent.sv
//
// Description: UVM agent for the async FIFO testbench.
//              Extends uvm_agent class
//

class async_fifo_agent #(parameter DATA_WIDTH=8) extends uvm_agent;
    
    `uvm_component_utils(agent)
    
    function new(string name="agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    async_fifo_driver #(.DATA_WIDTH(DATA_WIDTH) ) u_async_fifo_driver;    // Driver handle
    //async_fifo_monitor                          u_async_fifo_monitor;   // Monitor handle
    uvm_sequencer  #(fifo_seq_item)               u_async_fifo_sequencer; // Sequencer handle

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        u_async_fifo_driver = async_fifo_driver::type_id::create("u_async_fifo_driver", this);
        //u_async_fifo_monitor = async_fifo_monitor::type_id::create("u_async_fifo_monitor", this);
        u_async_fifo_sequencer = uvm_sequencer#(fifo_seq_item)::type_id::create("u_async_fifo_driver", this);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        u_async_fifo_driver.seq_item_port.connect(u_async_fifo_sequencer.seq_item_export);
    endfunction

endclass


