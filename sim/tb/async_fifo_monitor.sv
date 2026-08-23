class async_fifo_monitor extends uvm_monitor;

    `uvm_component_utils(reg_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass
