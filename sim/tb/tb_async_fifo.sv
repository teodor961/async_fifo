//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: tb_async_fifo.sv
//
// Description: Basic testbench for the async fifo module.
//
//

module tb_async_fifo (

);

    logic tb_wr_clk = 0;
    logic tb_wr_rst = 0;
    logic tb_rd_clk = 0;
    logic [7:0] tb_wr_data = 0;
    
    parameter WR_CLK_PERIOD = 4;
    parameter RD_CLK_PERIOD = 5;
    
    parameter DATA_WIDTH = 8;
    parameter DEPTH      = 16;
    parameter FULL_RST_STATE = 0;
    
    async_fifo_top #(
        .DATA_WIDTH     (DATA_WIDTH),
        .DEPTH          (DEPTH),
        .FULL_RST_STATE (FULL_RST_STATE)
    ) dut (
        .wr_rst    (tb_wr_rst),
        .wr_clk    (tb_wr_clk),
        .wr_data   (tb_wr_data),
        .wr_en     (1'b1),
        .full      (),
        .overflow  (),
    
    // READ clock domain signals
        .rd_clk    (),
        .rd_data   (),
        .rd_en     (1'b0),
        .empty     (),
        .underflow ()
    );
    
    initial begin
        forever #(WR_CLK_PERIOD) tb_wr_clk <= ~tb_wr_clk;
    end
    
    initial begin
        forever #(RD_CLK_PERIOD) tb_rd_clk <= ~tb_rd_clk;
    end

endmodule
