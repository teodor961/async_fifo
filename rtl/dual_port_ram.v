//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: dual_port_ram.v
//
// Description: parameterized RAM module for async 
//              fifo project 
//
//

module dual_port_ram #(
        parameter DATA_WIDTH = 8,
        parameter DEPTH = 10
    ) (
        input                             wr_rst,
        input                             wr_clk,
        input                             wr_en,
        input [clog2(DEPTH) - 1 : 0]      wr_addr,
        input [DATA_WIDTH - 1 : 0]        wr_data,
        
        input                             rd_clk,
        input                             rd_en,
        input      [clog2(DEPTH) - 1 : 0] rd_addr,
        output reg [DATA_WIDTH - 1 : 0]   rd_data
    );
    
    integer i;
    
    // WRITE logic
    always @ (posedge wr_clk)
      begin
          if (wr_rst)
            begin
                for (i = 0; i < DEPTH; i = i + 1)
                  mem[i] <= 0;
            end
          else
            begin
                if (wr_en)
                  mem[wr_addr] <= wr_data;
            end
      end
      
    // READ logic
    always @ (posedge rd_clk)
      begin
          if (rd_en)
            begin
                rd_data <= mem[rd_addr];
            end
      end
    
endmodule
