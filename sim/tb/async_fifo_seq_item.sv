//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_seq_item.sv
//
// Description: UVM sequence item for the async FIFO module.
//              extends uvm_sequence_item class
//
//

import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_seq_item extends uvm_sequence_item;

    // Fixed widths as parameters/constants
    localparam int DATA_WIDTH_CONST = 8;
    localparam int DEPTH_CONST = 16;
    
    rand int tmp_depth = 8;
    int data_depth;
    
    // Dynamic array of packed vectors with fixed width
    rand  bit [DATA_WIDTH_CONST-1: 0] data_vector [];
    
    // Control signals
    rand bit wr_en;
    rand bit rd_en;
    
    
    function new(string name = "fifo_seq_item");
        super.new(name);
    endfunction
    
    function void pre_randomize();
      
      // Randomize a temporary variable with constraints
      //if (!randomize(tmp_depth) with { tmp_depth > 0; tmp_depth < 3*DEPTH_CONST; }) 
      //  begin
      //    `uvm_error("SEQ_ITEM", "Failed to randomize tmp_depth")
      //    tmp_depth = 2; // fallback
      //  end
      tmp_depth = $urandom_range(1, 2*DEPTH_CONST);
      data_depth = tmp_depth;
      `uvm_info("SEQ_ITEM", $sformatf("Data_depth randomized to: %0d", data_depth), UVM_LOW)
      data_vector = new[data_depth];
    endfunction
    
    `uvm_object_utils_begin(fifo_seq_item)
      `uvm_field_array_int(data_vector, UVM_DEFAULT)
      `uvm_field_int(wr_en,       UVM_DEFAULT)
      `uvm_field_int(rd_en,       UVM_DEFAULT)            
    `uvm_object_utils_end

    
endclass
