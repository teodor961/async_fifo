//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_if.sv
//
// Description: Basic testbench for the async fifo module.
//
//

interface async_fifo_if #(parameter DATA_WIDTH = 8) (input wr_clk, input rd_clk);
    // WRITE clock domain signals
    logic                   wr_rst;
    logic [DATA_WIDTH-1:0]  wr_data;
    logic                   wr_en;
    logic                   full;
    logic                   overflow;
    
    // READ clock domain signals
    logic [DATA_WIDTH-1:0]  rd_data;
    logic                   rd_en;
    logic                   empty;
    logic                   underflow;
    
    
//--------------------------------------
// write clock
//--------------------------------------
    clocking write_clk @(posedge wr_clk);
      input  wr_data;
      input  wr_en;
      output full;
      output overflow;
    endclocking
    
//--------------------------------------
// read clock
//--------------------------------------
    clocking read_clk @(posedge rd_clk);
      input  rd_data;
      input  rd_en;
      output empty;
      output underflow;
    endclocking
    
    modport DRV_PORT (clocking write_clk, input wr_clk);
    modport MON_PORT (clocking read_clk, input rd_clk);
    
endinterface
    
