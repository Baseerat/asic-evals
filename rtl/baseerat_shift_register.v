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
  clock,
  resetn,

  //----------------------------------------------------------------------------
  // Mux Interface
  //----------------------------------------------------------------------------
  din,
  update,
  udin,
  dout
); // baseerat_shift_register


//------------------------------------------------------------------------------
// Parameters
//------------------------------------------------------------------------------
parameter DATA_WIDTH = 256;
parameter PIPELINE_STAGES = 32;

// -----------------------------------------------------------------------------
// Signal definitions
// -----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Clock, Clock Enable and Reset
  //----------------------------------------------------------------------------
  input   wire                          clock;
  input   wire                          resetn;

  //----------------------------------------------------------------------------
  // Mux Interface
  //----------------------------------------------------------------------------
  //Inputs
  input                [DATA_WIDTH-1:0] din;
  input           [PIPELINE_STAGES-1:0] update;
  input                [DATA_WIDTH-1:0] udin;
  //Outputs
  output               [DATA_WIDTH-1:0] dout;

  //----------------------------------------------------------------------------
  // Internal Signals
  //----------------------------------------------------------------------------
  wire [DATA_WIDTH-1:0] d_sr [0:PIPELINE_STAGES-1];

  // ---------------------------------------------------------------------------
  // Main code
  // ---------------------------------------------------------------------------
/*
    generate
      genvar  g;

      for (g = 0; g < PIPELINE_STAGES-1; g = g + 1)
      begin : g_sr
        always @(posedge clock)
        begin : p_dout_reg
          if(g==0)
            if (update[g])
             d_sr[0][DATA_WIDTH-1:0] <= udin;
            else
             d_sr[0][DATA_WIDTH-1:0] <= din;
          else
            if (update[g])
             d_sr[g][DATA_WIDTH-1:0] <= udin;
            else
             d_sr[g][DATA_WIDTH-1:0] <= d_sr[g-1][DATA_WIDTH-1:0];
        end

      end
    endgenerate

    assign dout = d_sr[PIPELINE_STAGES]; */

    generate
      genvar  g;

      for (g = 0; g < PIPELINE_STAGES; g = g + 1)
      begin : g_sr

      wire [DATA_WIDTH-1:0] din_;
      reg  [DATA_WIDTH-1:0] d_sr_;
      wire                  update_;

        assign update_ = update[g];
        assign din_ = (g==0) ? din : d_sr[g-1];

        always @(posedge clock)
        begin : p_d_sr_reg
          if (update_)
            d_sr_ <= udin;
          else
            d_sr_ <= din_;
        end

        assign d_sr[g] = d_sr_;

      end
    endgenerate

    assign dout = d_sr[PIPELINE_STAGES-1];

endmodule // baseerat_shift_register

// -----------------------------------------------------------------------------
// End of File
// -----------------------------------------------------------------------------
