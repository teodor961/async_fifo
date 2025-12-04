//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_rd_agent.sv
//
// Description: UVM agent for the async FIFO testbench.
//              Extends uvm_agent class
//

class async_fifo_rd_agent extends async_fifo_agent;
    
    `uvm_component_utils(async_fifo_rd_agent)
    
    function new(string name="rd_agent", uvm_component parent=null);
        super.new(name, parent);
        // Override default logging name
        m_agent_name = "RD_AGENT";
    endfunction


    // Override base agent driver with rd versions
    virtual function void build_phase(uvm_phase phase);
        async_fifo_driver::type_id::set_inst_override(async_fifo_rd_driver::get_type(), {get_full_name(), ".u_async_fifo_driver"} );

        super.build_phase(phase);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        //super.connect_phase(phase);
        //u_async_fifo_driver.seq_item_port.connect(u_async_fifo_sequencer.seq_item_export);
        //`uvm_info(m_agent_name,"Connected driver.seq_item_port -> sequencer.seq_item_export", UVM_LOW)
        `uvm_info(m_agent_name,"Do nothing", UVM_LOW)
    endfunction

endclass
