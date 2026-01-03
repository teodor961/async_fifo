//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_wr_driver.sv
//
// Description: UVM driver for the async FIFO module.
//              extends uvm_driver class
//
//

import tb_pkg::*;

class async_fifo_wr_driver extends async_fifo_driver;
    `uvm_component_utils(async_fifo_wr_driver)
    
    // Analysis port (broadcasts items to other components)
    uvm_analysis_port#(fifo_seq_item) item_ap;
    
    function new(string name = "async_fifo_wr_driver", uvm_component parent=null);
        super.new(name, parent);
        item_ap = new("item_ap", this); // create the analysis port
        // Override default logging name
        m_driver_name = "WR_DRIVER";
    endfunction
    
    
    // ------------------------------------------------------
    // Write-specific protocol logic
    // ------------------------------------------------------
    virtual task drive_item(fifo_seq_item m_item);
         // Set wr_en initial state
         async_fifo_vif.wr_en <= 0;
         // broadcast the sequence item to anyone connected
         item_ap.write(m_item);
         for (int i = 0; i < m_item.data_depth; i++) 
           begin
               `uvm_info(m_driver_name, $sformatf("Wait for full to drop"), UVM_DEBUG)
               if (async_fifo_vif.full == 1)
                 begin
                     async_fifo_vif.wr_en <= 0;
                 end
               wait(async_fifo_vif.full == 0)
               `uvm_info(m_driver_name, $sformatf("Full FIFO flag dropped"), UVM_DEBUG) 
               @(posedge async_fifo_vif.wr_clk)
               async_fifo_vif.wr_data <= m_item.data_vector[i];
               
               if (m_item.ctrl_flow_mode == ALWAYS_ON)
                 begin
                     `uvm_info(m_driver_name, "Driving as ALWAYS ON", UVM_DEBUG)
                     async_fifo_vif.wr_en <= 1;
                 end
               else if (m_item.ctrl_flow_mode == RANDOM)
                 begin
                     `uvm_info(m_driver_name, "Driving as RANDOM", UVM_DEBUG)
                     //`uvm_info(m_driver_name, $sformatf("Random delay: %d", $urandom_range(10, 200) ), UVM_HIGH);
                     #($urandom_range(10, 200)) async_fifo_vif.wr_en <= 1;
                 end
           end
         // One clock cycle for the last data byte to be read
         @(posedge async_fifo_vif.wr_clk)
         async_fifo_vif.wr_en <= 0;
         #200ns;
    endtask
    
endclass
