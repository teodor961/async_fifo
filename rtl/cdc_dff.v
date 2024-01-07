//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: cdc_dff.v
//
// Description: Simple cdc block using chained
//              D flip-flops, configured using
//              parameters. 
//
 
 module cdc_dff # (
      parameter NUM_SYNC_STAGES = 2,
      parameter DATA_WIDTH = 1
     ) (
     input  clk_dest,                  // Receiving clock domain
     
     input  [DATA_WIDTH-1:0]  din,     // Input data signal
     output [DATA_WIDTH-1:0]  dout     // Synchronized output signal
 );
 
(* ASYNC_REG = "TRUE" *) reg [DATA_WIDTH-1:0] cdc_pipeline[NUM_SYNC_STAGES-1:0];


generate
  genvar i;
  if (NUM_SYNC_STAGES == 0)
    begin
        assign dout = din;
    end
  else
    begin
        assign dout = cdc_pipeline[NUM_SYNC_STAGES-1];
        always @(posedge clk_dest)
          begin
              cdc_pipeline[0] <= din;
          end
        
        for (i = 1; i < NUM_SYNC_STAGES; i = i + 1)
          begin
              always @(posedge clk_dest)
                begin
                    cdc_pipeline[i] <= cdc_pipeline[i-1];
                end
          end
    end
endgenerate
 
 endmodule 
