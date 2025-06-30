//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_env.sv
//
// Description: UVM environment for the async FIFO module.
//              extends uvm_env class
//
//

class async_fifo_env extends uvm_env;
    `uvm_component_utils(async_fifo_env)
    
    function new(string name="async_fifo_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    async_fifo_agent u_async_fifo_agent; // agent handle
    //async_fifo_scoreboard u_async_fifo_scoreboard; // scoreboard handle
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        u_async_fifo_agent = async_fifo_agent::type_id::create("u_async_fifo_agent", this);
        //u_async_fifo_scoreboard = async_fifo_scoreboard::type_id::create("u_async_fifo_scoreboard", this);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // u_async_fifo_agent.u_async_fifo.connect(u_async_fifo_scoreboard.m_analysis_imp);
    endfunction
    
endclass
        
        
