// Belinda Brown Ramírez
// June, 2020
// timna.brown@ucr.ac.cr
// Co- worked with Brandon Esquivel Molina
// brandon.esquivel@ucr.ac.cr


`ifndef T_DISP2
`define T_DISP2

module t_device2  #(
	parameter DATA_SIZE = 8,
	parameter MAIN_SIZE = 4)
  (

output reg clk,
output reg clk8f,
output reg reset,
output reg in0,
output reg in1,
output reg empty0,
output reg empty1,
output reg fifo_almost_empty0,
output reg fifo_almost_empty1,
// behav

input wire [DATA_SIZE-1:0] out0,
input wire [DATA_SIZE-1:0] out1,
input wire almost_full_f0,
input wire almost_full_f1,
input wire pop_0,
input wire pop_1,


// Syn
input wire [DATA_SIZE-1:0] out0_s,
input wire [DATA_SIZE-1:0] out1_s,
input wire almost_full_f0_s,
input wire almost_full_f1_s,
input wire pop_0_s,
input wire pop_1_s
);

reg clkbase, clk4f, clk2f;

initial begin
  $dumpfile("disp2.vcd");		// "dump" file
  $dumpvars;


  in0 = 0;
  in1 = 0;
  #4 reset = 0;
  empty0 = 0;
  empty1 = 0;
  fifo_almost_empty0 = 0;
  fifo_almost_empty1 = 0;



repeat (6) begin
	@(posedge clk8f);
		reset = 0;
end

repeat (6) begin
	@(posedge clk8f);
      reset = 1;
end

@(posedge clk8f);

repeat(3) begin         // 01010101  -> Active = 0 because BC < 4
  @(posedge clk8f);
  in0  <=  ~in0;
  in1  <=  ~in1;
  end
  // Tests
repeat(5) begin         // BC = 10 1111 00
  @(posedge clk8f); // write on FIFO 0
    in0  <=  1;
    in1  <=  1;


  @(posedge clk8f); // write on FIFO 0
    in0  <=  0;
    in1  <=  0;

  @(posedge clk8f); // read on FIFO 0 and write on fifo 1
    in0  <=  1;
    in1  <=  1;


  @(posedge clk8f); // read on FIFO 0 and write on fifo 1
    in0  <=  1;
    in1  <=  1;


  @(posedge clk8f); // Do nothing
    in0  <=  1;
    in1  <=  1;


  @(posedge clk8f); // nothing
    in0  <=  1;
    in1  <=  1;


  @(posedge clk8f); // write FIFO 0
    in0  <=  0;
    in1  <=  0;


  @(posedge clk8f); // read FIFO 0
    in0  <=  0;
    in1  <=  0;


end

///////////////////////////////////////////
  // AT THIS POINT YOU HAVE 5 BC> ACTIVE = 1 AND YOU RECEIVE A VALID WORD
 // ######     -> FF -> 11111111
 @(posedge clk8f); // write on FIFO 1
   in0  <=  1;
   in1  <=  1;


 @(posedge clk8f); // write on FIFO 1
   in0  <=  1;
   in1  <=  1;


 @(posedge clk8f); // write on fifo 0 and read on FIFO 1
   in0  <=  1;
   in1  <=  1;
   
   
   
   

 @(posedge clk8f); // write on fifo 0 and read on FIFO 1
   in0  <=  1;
   in1  <=  1;
   
   
   
   

 @(posedge clk8f); // Do nothing
   in0  <=  1;
   in1  <=  1;
   
   
   
   

 @(posedge clk8f); // Do nothing
   in0  <=  1;
   in1  <=  1;
   
   
   
   

 @(posedge clk8f); // write FIFO 1
   in0  <=  1;
   in1  <=  1;
   
   
   
   

 @(posedge clk8f); // read FIFO 1
   in0  <=  1;
   in1  <=  1;
   
   
   
   
// FF -> 11111111
///////////////////////////////////////////
///////////////////////////////////////////
// #########  --> DD 11011101
@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  0;
  in1  <=  0;
  

  
  

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  1;
  in1  <=  1;

  

  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
	
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f); // write FIFO 0
  in0  <=  0;
  in1  <=  0;

  
  
  
  

@(posedge clk8f); // read FIFO 0
  in0  <=  1;
  in1  <=  1;

  

  
  
// ->  DD 11011101
///////////////////////////////////////////
///////////////////////////////////////////
// #### -> EE -> 11101110
@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f);  // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;

  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f); // write FIFO 1
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f); // read FIFO 1
  in0  <=  0;
  in1  <=  0;

  
  
  
  
// EE -> 11101110
///////////////////////////////////////////
///////////////////////////////////////////
//#### CC ->  11001100
@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;

  
  
  
  

@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;

	
  
  
  

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  1;
  in1  <=  1;

  

  
  

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  0;
  in1  <=  0;
  

  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // write FIFO 0
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // read FIFO 0
  in0  <=  0;
  in1  <=  0;
  

  
  
// CC ->  11001100
///////////////////////////////////////////
///////////////////////////////////////////
//###### 99 -> 10011001
@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;
  
  
  
  


@(posedge clk8f); // write on FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  


@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // write FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // read FIFO 1
  in0  <=  1;
  in1  <=  1;
  
  
  
  
  // end 99 -> 10011001

// ### --> AA -> 10101010
@(posedge clk8f); // write on FIFO 0
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // write on FIFO 0
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  1;
  in1  <=  1;
  

  
  

@(posedge clk8f); // read on FIFO 0 and write on fifo 1
  in0  <=  0;
  in1  <=  0;
  

  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // write FIFO 0
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // read FIFO 0
  in0  <=  0;
  in1  <=  0;
  

  
  
// end AA


//### 88 -> 10001000
@(posedge clk8f); // write on FIFO 1
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // write on FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // write on fifo 0 and read on FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  1;
  in1  <=  1;
  
  
  
  

@(posedge clk8f); // Do nothing
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // write FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  

@(posedge clk8f); // read FIFO 1
  in0  <=  0;
  in1  <=  0;
  
  
  
  
// end 88

  #40  $finish;
  end // end initial

  // clock logic
    initial	clkbase	 			<= 0;			// Initial value to avoid indeterminations
    always	#5 clkbase				<= ~clkbase;		// toggle every 10ns

    initial clk8f <= 0;
    initial clk4f <= 0;
    initial clk2f <= 0;
    initial	clk	 	<= 0;			// Initial value to avoid indeterminations

  // Faster frequency
      always @(posedge clkbase) begin
  		clk8f <= ~clk8f; // if was LOW change to HIGH
          end


  // For 4 Hz
      always @(posedge clk8f) begin
          clk4f <= ~clk4f; // if was LOW change to HIGH
          end
             //////////////////////////////
      // For 2 Hz
      always @(posedge clk4f) begin
          clk2f <= ~clk2f; // if was LOW change to HIGH
          end
             //////////////////////////////
      // For 1 Hz
      always @(posedge clk2f) begin
          clk <= ~clk; // if was LOW change to HIGH
          end

endmodule
// Local Variables:
// verilog-library-directories:("."):
// verilog-auto-wire-type:\"logic\"
// End:

`endif
