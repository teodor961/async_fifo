//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_sequencer.sv
//
// Description: UVM sequencer for the async FIFO module.
//              Extends uvm_sequencer class
//

class async_fifo_sequencer #(type REQ = uvm_sequence_item, type RSP = REQ) extends uvm_sequencer #(REQ, RSP);
	`uvm_component_utils (async_fifo_sequencer#(REQ, RSP))
	function new (string name="async_fifo_sequencer", uvm_component parent);
		super.new (name, parent);
	endfunction

endclass




