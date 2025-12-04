//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_wr_agent.sv
//
// Description: UVM agent for the async FIFO testbench.
//              Extends uvm_agent class
//

class async_fifo_wr_agent extends async_fifo_agent;
    
    `uvm_component_utils(async_fifo_wr_agent)
    
    function new(string name="wr_agent", uvm_component parent=null);
        super.new(name, parent);
        // Override default logging name
        m_agent_name = "WR_AGENT";
    endfunction


    // Override base agent driver with wr versions
    virtual function void build_phase(uvm_phase phase);
        async_fifo_driver::type_id::set_inst_override(async_fifo_wr_driver::get_type(), {get_full_name(), ".u_async_fifo_driver"} );
        
        super.build_phase(phase);
    endfunction

endclass
