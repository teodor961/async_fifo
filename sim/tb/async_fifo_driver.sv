//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_driver.sv
//
// Description: UVM driver for the async FIFO module.
//              extends uvm_driver class
//
//

class async_fifo_driver #(type SEQ_ITEM_TYPE = fifo_seq_item) extends uvm_driver #(SEQ_ITEM_TYPE);
    `uvm_component_utils(async_fifo_driver)
    
    protected string m_driver_name;
    
    function new(string name = "async_fifo_driver", uvm_component parent=null);
        super.new(name, parent);
        m_driver_name = "DRIVER";
    endfunction
    
    virtual async_fifo_if async_fifo_vif;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(m_driver_name, "Entered build phase", UVM_DEBUG)
        if (!uvm_config_db#(virtual async_fifo_if)::get(this, "", "async_fifo_vif", async_fifo_vif))
        `uvm_fatal("DRIVER", "Could not get vif")
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            fifo_seq_item m_item;
            `uvm_info(m_driver_name, $sformatf("Wait for item from sequencer"), UVM_LOW) 
            seq_item_port.get_next_item(m_item);
            drive_item(m_item);
            seq_item_port.item_done();
        end
    endtask
    
    virtual task drive_item(fifo_seq_item m_item);
         `uvm_fatal("DRIVER", "drive_item() not implemented in base driver. Please override with custom driver class")
    endtask
    
endclass
