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
    
    async_fifo_wr_agent u_async_fifo_wr_agent; // write agent handle
    async_fifo_rd_agent u_async_fifo_rd_agent; // read agent handle
    //async_fifo_scoreboard u_async_fifo_scoreboard; // scoreboard handle
    
    async_fifo_wr_driver wr_drv;
    async_fifo_rd_driver rd_drv;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ENV", "Entered build phase", UVM_HIGH)
        u_async_fifo_wr_agent = async_fifo_wr_agent::type_id::create("u_async_fifo_wr_agent", this);
        u_async_fifo_rd_agent = async_fifo_rd_agent::type_id::create("u_async_fifo_rd_agent", this);

        //u_async_fifo_scoreboard = async_fifo_scoreboard::type_id::create("u_async_fifo_scoreboard", this);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        wr_drv = async_fifo_wr_driver'(u_async_fifo_wr_agent.get_driver());
        rd_drv = async_fifo_rd_driver'(u_async_fifo_rd_agent.get_driver());
        
        if (wr_drv == null) `uvm_error("ENV", "wr_drv is NULL in connect_phase")
        else `uvm_info("ENV", $sformatf("Got WR_DRV as: %s", wr_drv.get_full_name()), UVM_DEBUG)
        if (rd_drv == null) `uvm_error("ENV", "rd_drv is NULL in connect phase")
        else `uvm_info("ENV", $sformatf("Got RD_DRV as: %s", rd_drv.get_full_name()), UVM_DEBUG)
        
        wr_drv.item_ap.connect(rd_drv.item_imp);
        //u_async_fifo_wr_agent.u_async_fifo_driver.item_ap.connect(u_async_fifo_rd_agent.u_async_fifo_driver.item_imp);
        // u_async_fifo_agent.u_async_fifo.connect(u_async_fifo_scoreboard.m_analysis_imp);
    endfunction
    
endclass
        
        
