//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_rd_driver.sv
//
// Description: UVM driver for the async FIFO module.
//              extends uvm_driver class
//
//

import tb_pkg::*;

class async_fifo_rd_driver extends async_fifo_driver;
    `uvm_component_utils(async_fifo_rd_driver)
    
    uvm_analysis_imp#(fifo_seq_item, async_fifo_rd_driver) item_imp;
    
    // Store the received item
    fifo_seq_item wr_item;
    fifo_seq_item rd_item;
    
    function new(string name = "async_fifo_rd_driver", uvm_component parent=null);
        super.new(name, parent);
        // Override default logging name
        m_driver_name = "RD_DRIVER";
        item_imp = new("item_imp", this); // create analysis implementation
        wr_item = fifo_seq_item::type_id::create("wr_item", this);
        rd_item = fifo_seq_item::type_id::create("rd_item", this);
    endfunction
    
    // Called automatically when write driver calls item_ap.write()
    function void write(fifo_seq_item m_item);
        if (m_item != null)
          begin
              wr_item.copy(m_item); // store the item
              rd_item.copy(m_item);
          end
        else
          begin
              `uvm_error("DEBUG", "ERROR: NULL ITEM RECEIVED FOR M_ITEM IN WRITE FUNCTION")
          end
    endfunction
    
    
    // ------------------------------------------------------
    // Write-specific protocol logic
    // ------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        forever 
          begin
              if (wr_item != null)
                begin
                    `uvm_info(m_driver_name, "Got item from write driver", UVM_DEBUG)
                    drive_item(wr_item);
                end
              @(posedge async_fifo_vif.rd_clk);
          end
    endtask
    
    virtual task drive_item(fifo_seq_item m_item);
         // Set rd_en initial state
         async_fifo_vif.rd_en <= 0;
         
         for (int i = 0; i < m_item.data_depth; i++) 
           begin
               `uvm_info(m_driver_name, $sformatf("Wait for empty to drop"), UVM_DEBUG)
               if (async_fifo_vif.empty == 1)
                 begin
                     async_fifo_vif.rd_en <= 0;
                 end
               wait(async_fifo_vif.empty == 0)
               @(posedge async_fifo_vif.rd_clk)
                 rd_item.data_vector[i] = async_fifo_vif.rd_data;
                 //rd_item.data_vector[i] = 8'hae;
                 async_fifo_vif.rd_en <= 1;
           end
         
         @(posedge async_fifo_vif.rd_clk)
         async_fifo_vif.rd_en <= 0;
         wr_item.print();
         rd_item.print();
         
         #200ns;
    endtask
    
endclass
