//------------------------------------------------------------------------------
//	Module:		LevelToPulse
//	Desc:		This module provides a 1-cycle output based on a push button
//				raw input source.
//	Params:		This module is not parameterized.
//	Inputs:		See Lab2 document
//	Outputs:	See Lab2 document
//
//	Author:     YOUR NAME GOES HERE
//------------------------------------------------------------------------------
module	LevelToPulse(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------

			//------------------------------------------------------------------
			//	Inputs
			//------------------------------------------------------------------
			Level,
			//------------------------------------------------------------------

			//------------------------------------------------------------------
			//	Outputs
			//------------------------------------------------------------------
			Pulse
			//------------------------------------------------------------------
	);
	//--------------------------------------------------------------------------
	//	Clock & Reset Inputs
	//--------------------------------------------------------------------------
	input					Clock;	// System clock
	input					Reset;	// System reset
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Inputs
	//--------------------------------------------------------------------------
	input					Level;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Outputs
	//--------------------------------------------------------------------------
	output					Pulse;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	State Encoding
	localparam buttonPush = 1'b1,
	localparam buttonRelease = 1'b0;

	reg state,nextState;


	//--------------------------------------------------------------------------

	// place state encoding here

	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wire Declarations
	//--------------------------------------------------------------------------

	// place wire declarations here

	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Logic
	always @(posedge Clock)
		begin
			state <= buttonRelease
		end
		always @(state or Level or Reset)
			begin
				case(state)
					buttonRelease:
						begin
							Pulse = 1'b0;
							if(Level and !Reset)
								nextState = buttonPush;
							else
								next = buttonRelease;
						end
					buttonPush:
						begin
							Pulse = 1'b1;
							nextState = buttonRelease;
						end
				endcase
			end
	//--------------------------------------------------------------------------

	// Place you *behavioral* Verilog here
	// You may find it useful to use a case statement to describe your FSM.

	//--------------------------------------------------------------------------
endmodule // LevelToPulse
