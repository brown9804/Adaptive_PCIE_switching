//////////////////////////////////////////////////////////////////////////////////
// Company: U.C.R, EIE
// Engineer: Brandon Esquivel Molina
//
// Create Date: 26.05.2020
// Design Name: Serial to parallel Module
// Project Name: PHY Layer PCIe
// Target Devices: PCIe
// Tool Versions: Yosys 0.9 Iverolg release at 2020
// Description: tester for Serial to parallel module
// Dependencies:
//
// Revision: 1.0  All good
// Revision 0.01 - File Created
// Additional Comments: revision struct and behav
//
//////////////////////////////////////////////////////////////////////////////////


module tester(
    input wire [7:0] outc,           // salida paralela de bus de 8 bits + valid
    input wire [7:0] outs,
    input wire valid,               // + valid
    output reg in,                  // entrada bit a bit serial
    output reg reset,               // reset
    output reg clk8f,              // frecuencia mas rapida, de recepcion
    output reg clk                // frecuencia de envio

);
    // AUXILIARES
    reg clk32f;
    reg clk16f;
    reg clk4f;
    reg clk2f;
    reg clk1f;

    initial begin
		$dumpfile("stop.vcd");																						// "dump" file
	$dumpvars;

      repeat (6) begin
		@(posedge clk8f);
		reset <= 0;
		end

		repeat (6) begin																							// Repeat the test 3 times
		@(posedge clk8f);																								// sync with clock
		reset <= 1;
		end

        @(posedge clk8f);

        // pruebas

        repeat(3) begin         // 01010101  -> NO HAY ACTIVE YA QUE BC < 4
        @(posedge clk8f);
        in  <=  ~in;
        end


        repeat(5) begin         // BC = 10 1111 00
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;
        end

        // EN ESTE PUNTO SE TIENEN 5 BC > ACTIVE = 1 Y SE RECIBE UNA PALABRA valida

             // Nueva palabra a enviar  -> FF -> 11111111
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;

        // nueva palabra DD 11011101

         @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;



         // Nueva palabra a enviar  -> EE -> 11101110
      @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;

        // nueva palabra CC ->  11001100
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;

        // NUEVA PALABRA BB -> 10111011

        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;

        // NUEVA PALABRA 99 -> 10011001
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;

        // NUEVA PALABRA 10101010 -> AA

@(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;

        // Nueva palabra a enviar  -88 -> 10001000
      @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  1;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;
        @(posedge clk8f);
        in  <=  0;

         repeat(8) begin
        @(posedge clk8f);
         end


        $finish;
    end


	// Initial Values
	initial in			<= 0;
	initial reset 		<= 0;

	// clock logic
	initial	clk	 	    <= 0;			// Initial value to avoid indeterminations
	always	#5 clk	    <= ~clk;		// toggle every 1ns

	// clks

	  initial clk32f <= 0;
    initial clk16f <= 0;
    initial clk8f <= 0;
    initial clk4f <= 0;
    initial clk2f <= 0;
    initial clk1f <= 0;


    // Faster frequency
    always @(posedge clk) begin
		clk32f <= ~clk32f; // if was LOW change to HIGH
        end
    //////////////////////////////
    // For 16 Hz
    always @(posedge clk32f) begin
        clk16f <= ~clk16f; // if was LOW change to HIGH
        end
    //////////////////////////////
    // For 8 Hz
    always @(posedge clk16f) begin
            clk8f <= ~clk8f; // if was LOW change to HIGH
    end
    //////////////////////////////
    // For 4 Hz
    always @(posedge clk8f) begin
        clk4f <= ~clk4f; // if was LOW change to HIGH
        end
    //////////////////////////////
    // At 2 Hz
    always @(posedge clk4f) begin
        clk2f <= ~clk2f; // if was LOW change to HIGH
        end

    //////////////////////////////
    // At 1 HZ
    always @(posedge clk2f) begin
    clk1f <= ~clk1f; // if was LOW change to HIGH
 	end

endmodule
