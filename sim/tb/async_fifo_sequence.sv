//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_test_basic.sv
//
// Description: Base test for the async FIFO module.
//              extends uvm_test class
//
//

class fifo_sequence extends uvm_sequence;
    `uvm_object_utils(fifo_sequence)
    function new(string name="fifo_sequence");
        super.new(name);
    endfunction
    
    rand int num_transactions; // Number of sequence items to send
    
    constraint num_trans_limits { num_transactions inside {[2:5]}; }
    
    virtual task body();
        repeat (num_transactions) begin
            fifo_seq_item m_item = fifo_seq_item::type_id::create("m_item");
            start_item(m_item);
            m_item.randomize();
            `uvm_info("SEQ", $sformatf("Generate new item: "), UVM_LOW)
            m_item.print();
            finish_item(m_item);
        end
        `uvm_info("SEQ", $sformatf("Done generation of %0d items", num_transactions), UVM_LOW)
    endtask
    
endclass
