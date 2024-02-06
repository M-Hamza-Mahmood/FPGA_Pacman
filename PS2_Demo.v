
module PS2_Demo (
	// Inputs
	CLOCK_50,
	
	reset,
	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	
	// Outputs
	goup,
	godown,
	goleft,
	goright
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input				CLOCK_50;
input				reset;

// Bidirectionals
inout				PS2_CLK;
inout				PS2_DAT;

// Outputs
// Output for arrow keys
output reg goup;
output reg godown;
output reg goleft;
output reg goright;


/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;

// Internal Registers
// Internal Wires
reg			[7:0]	last_data_received;
// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if (reset == 1'b1)
		last_data_received <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		last_data_received <= ps2_key_data;
end



always @(posedge CLOCK_50)
begin
	case (last_data_received) 
		8'h1D: begin
		goup <= 1'b1;
			   godown <= 1'b0;
			   goleft <= 1'b0;
			   goright <= 1'b0;
				end
		8'h1B: begin
		godown <= 1'b1;
			   goup <= 1'b0;
			   goleft <= 1'b0;
			   goright <= 1'b0;
				end
		8'h1C: begin
		goleft <= 1'b1;
			   goup <= 1'b0;
			   godown <= 1'b0;
			   goright <= 1'b0;
				end
		8'h23: begin
		goright <= 1'b1;
			   goup <= 1'b0;
			   godown <= 1'b0;
			   goleft <= 1'b0;
			end	
		default:
	begin	
			   goup <= 1'b0;
			   godown <= 1'b0;
			   goleft <= 1'b0;
			   goright <= 1'b0;
				end
	endcase 
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/



/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(reset),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);


endmodule
