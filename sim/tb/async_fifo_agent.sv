//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_agent.sv
//
// Description: basic UVM agent for the async FIFO testbench.
//              Extends uvm_agent class
//

class async_fifo_agent extends uvm_agent;
    `uvm_component_utils(async_fifo_agent)
    
    protected string m_agent_name;
    
    function new(string name="agent", uvm_component parent=null);
        super.new(name, parent);
        m_agent_name = "AGENT";
    endfunction

    async_fifo_driver                             u_async_fifo_driver;    // Driver handle
    //async_fifo_monitor                          u_async_fifo_monitor;   // Monitor handle
    async_fifo_sequencer  #(fifo_seq_item)        u_async_fifo_sequencer; // Sequencer handle

    function async_fifo_driver get_driver();
        `uvm_info(m_agent_name, "Inside get_driver() function", UVM_DEBUG)
        return u_async_fifo_driver;
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(m_agent_name, "Entered build_phase", UVM_DEBUG)
        u_async_fifo_driver = async_fifo_driver::type_id::create("u_async_fifo_driver", this);
        //u_async_fifo_monitor = async_fifo_monitor::type_id::create("u_async_fifo_monitor", this);
        u_async_fifo_sequencer = async_fifo_sequencer#(fifo_seq_item)::type_id::create("u_async_fifo_sequencer", this);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        u_async_fifo_driver.seq_item_port.connect(u_async_fifo_sequencer.seq_item_export);
        `uvm_info(m_agent_name,"Connected driver.seq_item_port -> sequencer.seq_item_export", UVM_LOW)
    endfunction

endclass


