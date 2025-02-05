//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_test_basic.sv
//
// Description: Base test for the async FIFO module.
//              extends uvm_test class
//
//

class async_fifo_test_basic #(parameter int DATA_WIDTH = 8) extends uvm_test;
    `uvm_component_utils(async_fifo_test_basic)
    
    function new(string name = "async_fifo_test_basic", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    async_fifo_env #(.DATA_WIDTH(DATA_WIDTH)) u_async_fifo_env;
    
    virtual async_fifo_if async_fifo_vif;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        u_async_fifo_env = u_async_fifo_env::type_id::create("u_async_fifo_env", this);
        if (!uvm_config_db #(virtual async_fifo_if)::get(this, "", "async_fifo_vif", async_fifo_vif))
            `uvm_fatal("TEST", "Did not get async_fifo_vif")
        uvm_config_db#(virtual async_fifo_if)::set(this, "async_fifo_env.async_fifo_agent.*", "async_fifo_vif", async_fifo_vif);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        fifo_sequence seq = fifo_sequence::type_id::create("seq");
        phase.raise_objection(this);
        apply_reset();
    endtask
    
    virtual task apply_reset();
        async_fifo_vif.wr_rst <= 1;
        repeat(5) @ (posedge async_fifo_vif.wr_clk);
        async_fifo_vif.wr_rst <= 0;
        repeat(5) @ (posedge async_fifo_vif.wr_clk);
    endtask
    
endclass
