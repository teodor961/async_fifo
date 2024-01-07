//--------------------------------------------------
// Created by : Teodor Dimitrov
// Design     : async_fifo
// Module name: bin2gray.v
//
// Description: Binary to gray encoder with 
//              parameterized data width 
//
//

module bin2gray #(
        parameter DATA_WIDTH = 8,
    ) (
        input  [DATA_WIDTH-1 : 0] binary_in,
        output [DATA)WIDTH-1 : 0] gray_out
    );
    
    assign gray_out = (binary_in >> 1) ^ binary_in;
    
endmodule
