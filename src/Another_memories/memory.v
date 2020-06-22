// Memoria
// Proyecto 2 Digitales II

module memory #( parameter DATA_SIZE = 10, parameter MAIN_SIZE = 8) (
    input clk,
    input read,       
    input write,       
    input reset,
    input [DATA_SIZE-1:0] data_in,
    input [MAIN_SIZE-1:0] wr_ptr,
    input [MAIN_SIZE-1:0] rd_ptr,
    output reg [DATA_SIZE-1:0] data_out
);

  // Memoria accesada
    reg[DATA_SIZE-1:0] mem[MAIN_SIZE-1:0];

   // Leer
    always@ (*) begin
        data_out = ~reset && read ? 'b0 : mem[rd_ptr];    
    end

  // Escribir
    always@( posedge clk ) begin
        if (write) 
            mem[wr_ptr] <= data_in;          
    end

    
endmodule





