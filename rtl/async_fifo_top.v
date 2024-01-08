//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: async_fifo_top.v
//
// Description: Top level module for the asynchronous fifo design
//              Design hierarchy is as follows:
//                async_fifo  -> top module
//                  \_ mem.v  -> RAM block
//                  \_ bin2gray.v -> gray encoder for sync logic 
//                  \_ gray2bin.v -> gray decoder for sync logic 
//
// TODO: Create gray2bin decoder module!!!
module async_fifo_top #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 10,
    parameter FULL_RST_STATE = 0
) (
    // WRITE clock domain signals
    input                   wr_rst,
    input                   wr_clk,
    input [DATA_WIDTH-1:0]  wr_data,
    input                   wr_en,
    output                  full,
    output reg              overflow,
    
    // READ clock domain signals
    input                   rd_clk,
    output [DATA_WIDTH-1:0] rd_data,
    input                   rd_en,
    output                  empty,
    output reg              underflow

);

  localparam ADDR_WIDTH = $clog2(DEPTH);
  
  // WRITE domain signals
  reg                   full_r;
  reg  [ADDR_WIDTH-1:0] wr_ptr;
  wire [ADDR_WIDTH-1:0] wr_ptr_gray;
  wire [ADDR_WIDTH-1:0] rd_ptr_gray_synced;
  reg  [ADDR_WIDTH-1:0] rd_ptr_synced;
  wire [ADDR_WIDTH-1:0] rd_ptr_synced_minus_one;
  
  // READ domain signals
  wire                  rd_rst;
  reg                   empty_r;
  reg  [ADDR_WIDTH-1:0] rd_ptr;
  wire [ADDR_WIDTH-1:0] rd_ptr_gray;
  wire [ADDR_WIDTH-1:0] wr_ptr_gray_synced;
  reg  [ADDR_WIDTH-1:0] wr_ptr_synced;
  

  dual_port_ram #(
      .DATA_WIDTH (DATA_WIDTH),
      .DEPTH      (DEPTH)
  ) fifo_ram (
      .wr_rst   (wr_rst),
      .wr_clk   (wr_clk),
      .wr_en    (wr_en),
      .wr_addr  (wr_ptr),
      .wr_data  (wr_data),
      
      .rd_addr  (rd_ptr),
      .rd_data  (rd_data)
  );

  always @(posedge wr_clk)
    begin
        if (wr_rst)
          begin
              wr_ptr <= 0;
          end
        else if (wr_en && wr_ptr == rd_ptr_synced_minus_one) // use full condition directly to avoid 1 clock latency
          begin
              wr_ptr <= (wr_ptr == DEPTH - 1) ? 0 : wr_ptr + 1;
          end
        else if (wr_en && full_r)
          begin
              overflow <= 1;
          end
    end

  always @(posedge rd_clk)
    begin
        if (rd_rst)
          begin
              rd_ptr <= 0;
          end
        else if (rd_en )
          begin
              rd_ptr <= (rd_ptr == DEPTH - 1) ? 0 : wr_ptr + 1;
          end
    end

//------------------------------------------
// Gray encoders & decoders
//------------------------------------------
  bin2gray #(
      .WIDTH(ADDR_WIDTH)
  ) rd_gray_encoder (
      .binary_in (rd_ptr),
      .gray_out  (rd_ptr_gray)
  );
  
  bin2gray #(
      .WIDTH(ADDR_WIDTH)
  ) wr_gray_encoder (
      .binary_in (wr_ptr),
      .gray_out  (wr_ptr_gray)
  );
  
//------------------------------------------
// RD<->WR CDC crossings
//------------------------------------------
  cdc_dff #(.DATA_WIDTH(1))          cdc_rd_rst(.clk_dest(rd_clk), .din(wr_rst),      .dout(rd_rst));
  cdc_dff #(.DATA_WIDTH(ADDR_WIDTH)) cdc_wr_ptr(.clk_dest(rd_clk), .din(wr_ptr_gray), .dout(wr_ptr_gray_synced));
  cdc_dff #(.DATA_WIDTH(ADDR_WIDTH)) cdc_rd_ptr(.clk_dest(wr_clk), .din(rd_ptr_gray), .dout(rd_ptr_gray_synced));
  
//------------------------------------------
// Full logic
//------------------------------------------
  always @(posedge wr_clk)
    begin
        if (wr_rst)
          begin
              full_r <= FULL_RST_STATE;
          end
        else
          begin
              if (wr_ptr == rd_ptr_synced_minus_one)
                begin
                    full_r <= 1'b1;
                end
              else
                begin
                    full_r <= 1'b0;
                end
          end
    end
    
  assign rd_ptr_synced_minus_one = rd_ptr_synced - 1;
  
//------------------------------------------
// Empty logic
//------------------------------------------
  always @(posedge rd_clk)
    begin
        if (wr_rst)
          begin
              empty_r <= FULL_RST_STATE;
          end
        else
          begin
              if (rd_ptr == wr_ptr_synced)
                begin
                    empty_r <= 1'b1;
                end
              else
                begin
                    empty_r <= 1'b0;
                end
          end
    end
    
    
endmodule
