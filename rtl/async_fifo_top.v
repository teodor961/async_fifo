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
    parameter DATA_WIDTH
) (
    input wrst,
    input wclk,
    input wdata,

);




endmodule
