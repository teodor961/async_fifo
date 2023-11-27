//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_top.v
//
// Description: Top level module for the asynchronous fifo design
//              Design hierarchy is as follows:
//                async_fifo  -> top module
//                  \_ mem.v  -> RAM block
//                  \_ gray.v -> gray encoder for sync logic 
//
//

module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 10
) (
    // WRITE clock domain signals
    input  wr_rst,
    input  wr_clk,
    input  wr_data,
    input  wr_en,
    output full,
    
    // READ clock domain signals
    input  rd_clk,
    output rd_data,
    input  rd_en,
    output empty
    
    

);




endmodule
