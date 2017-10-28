// -----------------------------------------------------------------------------
// Name : baseerat_shift_register.v
// Purpose : M-Stage Shift Register 
//
// -----------------------------------------------------------------------------
// Note    : This file uses Verilog-2001.
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Module declaration
// -----------------------------------------------------------------------------
module baseerat_shift_register
(
  //----------------------------------------------------------------------------
  // Clock, Clock Enables and Reset.
  //----------------------------------------------------------------------------
  clk,
  resetn,

  //----------------------------------------------------------------------------
  // Mux Interface
  //----------------------------------------------------------------------------
  din,
  dout

); // baseerat_shift_register


//------------------------------------------------------------------------------
// Parameters
//------------------------------------------------------------------------------
parameter DATA_WIDTH = 16;
parameter PIPELINE_STAGES = 4;

// -----------------------------------------------------------------------------
// Signal definitions
// -----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Clock, Clock Enable and Reset
  //----------------------------------------------------------------------------
  input   wire                          clk;
  input   wire                          resetn;

  //----------------------------------------------------------------------------
  // Mux Interface
  //----------------------------------------------------------------------------
  //Inputs
  input                [DATA_WIDTH-1:0] din;
  //Outputs
  output               [DATA_WIDTH-1:0] dout;

  //----------------------------------------------------------------------------
  // Internal Signals
  //----------------------------------------------------------------------------
  reg [DATA_WIDTH_INT-1:0] d_sr [0:PIPELINE_STAGES-1];

  // ---------------------------------------------------------------------------
  // Main code
  // ---------------------------------------------------------------------------
    assign d_sr[0] = din;

    generate
      genvar  g;

      for (g = 0; g < PIPELINE_STAGES-1; g = g + 1)
      begin : g_sr
        always @(posedge clk)
        begin : p_dout_reg
          d_sr[g+1] <= d_sr[g];
        end

      end
    endgenerate

    assign dout = d_sr[PIPELINE_STAGES];

endmodule // baseerat_shift_register

// -----------------------------------------------------------------------------
// End of File
// -----------------------------------------------------------------------------
