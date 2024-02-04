//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_seq_item.sv
//
// Description: UVM sequence item for the async FIFO module.
//              extends uvm_sequence_item class
//
//

class fifo_seq_item #(parameter int DATA_WIDTH = 8, int DEPTH = 10) extends uvm_sequence_item;
    rand  bit [DATA_WIDTH-1: 0] data_vector [];
    rand  int data_depth;
    
    // Constrain data vector to twice the depth at most
    constraint max_depth { data_depth < 2*DEPTH; }
    
    function new(string name = "fifo_seq_item");
        super.new(name);
    endfunction
    
    virtual function void pre_randomize();
        data_vector = new[data_depth];
    endfunction
    
    `uvm_object_utils_begin(fifo_seq_item)
        `uvm_field_int (DATA_WIDTH, UVM_DEFAULT)
        `uvm_field_int (data_depth, UVM_DEFAULT)
    `uvm_object_utils_end
    
endclass
