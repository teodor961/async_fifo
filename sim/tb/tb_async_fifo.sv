//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: tb_async_fifo.sv
//
// Description: Basic testbench for the async fifo module.
//
//
import uvm_pkg::*;
`include "uvm_macros.svh"

module tb_async_fifo (

);

    logic tb_wr_clk = 0;
    logic tb_wr_rst = 0;
    logic tb_rd_clk = 0;
    logic [7:0] tb_wr_data = 0;
    
    logic [31:0] error_count = 0;
    
    parameter WR_CLK_PERIOD = 4;
    parameter RD_CLK_PERIOD = 5;
    
    parameter DATA_WIDTH = 8;
    parameter DEPTH      = 16;
    parameter FULL_RST_STATE = 0;
    
    async_fifo_interface #(.DATA_WIDTH(DATA_WIDTH)) u_async_fifo_interface (tb_wr_clk, tb_rd_clk);
    
    async_fifo_top #(
        .DATA_WIDTH     (DATA_WIDTH),
        .DEPTH          (DEPTH),
        .FULL_RST_STATE (FULL_RST_STATE)
    ) dut (
        .wr_rst    (u_async_fifo_interface.wr_rst),
        .wr_clk    (u_async_fifo_interface.wr_clk),
        .wr_data   (u_async_fifo_interface.wr_data),
        .wr_en     (u_async_fifo_interface.wr_en),
        .full      (u_async_fifo_interface.full),
        .overflow  (u_async_fifo_interface.overflow),
    
    // READ clock domain signals
        .rd_clk    (u_async_fifo_interface.rd_clk),
        .rd_data   (u_async_fifo_interface.rd_data),
        .rd_en     (u_async_fifo_interface.rd_en),
        .empty     (u_async_fifo_interface.empty),
        .underflow (u_async_fifo_interface.underflow)
    );
    
    initial begin
      $display("Begin simulation");
      
      uvm_config_db#(virtual async_fifo_interface)::set(uvm_root::get(),"*","async_fifo_vif",u_async_fifo_interface);
      run_test();
      
    end

endmodule
