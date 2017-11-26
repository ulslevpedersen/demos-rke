///////////////////////////////////////////////////////////////////////////
// W3OP module
module W3OP ();

// Number of instructions in the CODEMEM.BIN file
parameter INSTRUCTIONS = 4;
parameter CLK_PERIOD = 10; //Wait with 200 MHz

// Test module signals
reg         sim_clk;
reg [35:0]  sim_code; 

// Create DUT
w3op w3op_dut 
    (
     .clock     ( sim_clk  ),
     .code      ( sim_code )
    );

initial sim_clk = 1'b0;
always #( CLK_PERIOD/2.0 )
    sim_clk = ~sim_clk;

///////////////////////////////////////////////////////////////////////////
// 36-bit instruction SRAM
reg [35:0] CODEMEM[0:INSTRUCTIONS-1] ;
// Read the instructions into CODEMEM
initial $readmemb("codemem.bin", CODEMEM) ;

//parameter numInstructions = 4
///////////////////////////////////////////////////////////////////////////
integer j;
initial j = 0;
// Send the instruction to the MUT
always @(posedge sim_clk)
    begin
        //$stop;
        sim_code = CODEMEM[j];
        if (j < INSTRUCTIONS-1) begin
            j = j + 1; 
        end else begin
            //$stop;
            $display("Stopping: j=%d", j);
        end
    end
endmodule
