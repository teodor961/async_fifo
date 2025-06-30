//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_seq_item.sv
//
// Description: UVM sequence item for the async FIFO module.
//              extends uvm_sequence_item class
//
//

class fifo_seq_item extends uvm_sequence_item;

    // Fixed widths as parameters/constants
    localparam int DATA_WIDTH_CONST = 8;
    localparam int DEPTH_CONST = 16;
    
    rand int data_depth;
    
    // Dynamic array of packed vectors with fixed width
    rand  bit [DATA_WIDTH_CONST-1: 0] data_vector [];
    
    
    // Constrain data vector to twice the depth at most
    constraint max_depth { data_depth < 2*DEPTH_CONST; }
    
    function new(string name = "fifo_seq_item");
        super.new(name);
    endfunction
    
    function void pre_randomize();
      if (data_depth <= 0) data_depth = 1; // safe default
        begin
            data_vector = new[data_depth];
        end
    endfunction
    
    `uvm_object_utils(fifo_seq_item)

    
endclass
