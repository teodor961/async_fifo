//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_driver.sv
//
// Description: UVM driver for the async FIFO module.
//              extends uvm_driver class
//
//

class async_fifo_driver extends uvm_driver #(fifo_seq_item);
    `uvm_component_utils(async_fifo_driver)
    
    function new(string name = "async_fifo_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    virtual async_fifo_if async_fifo_vif;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual async_fifo_if)::get(this, "", "async_fifo_vif", async_fifo_vif))
        `uvm_fatal("DRV", "Could not get vif")
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            fifo_seq_item m_item;
            `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_LOW) 
            seq_item_port.get_next_item(m_item);
            drive_item(m_item);
            seq_item_port.item_done();
        end
    endtask
    
    virtual task drive_item(fifo_seq_item m_item);
         for (int i = 0; i < m_item.data_depth; i++) 
           begin
               async_fifo_vif.wr_en <= 0;
               wait(async_fifo_vif.full == 0)
               @(posedge async_fifo_vif.wr_clk)
               async_fifo_vif.wr_data <= m_item.data_vector[i];
               async_fifo_vif.wr_en <= 1;
           end
    endtask
    
endclass
