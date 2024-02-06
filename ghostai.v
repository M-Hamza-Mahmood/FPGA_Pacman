module return_blue_ghost_direction(
	input [8:0] pacmanx,
    input [8:0] pacmany,
	input [8:0] B_ghostx,
    input [8:0] B_ghosty,
	input [8:0] R_ghostx,
    input [8:0] R_ghosty,
	input clock_in,
	output reg [1:0] dx,
	output reg [1:0] dy);

	reg vx_s;
	reg vy_s;
	reg [8:0] BPvectorx;
	reg [8:0] BPvectory;
	reg [8:0] RBvectorx;
	reg [8:0] RBvectory;
	reg [8:0] avgvectorx;
	reg [8:0] avgvectory;

	localparam map_array = 9'd21;

	always @(posedge clock_in) begin
		BPvectorx<=pacmanx-B_ghostx;
		BPvectory<=pacmany-B_ghosty;
		RBvectorx<=R_ghostx-B_ghostx;
		RBvectory<=R_ghosty-B_ghosty;
		avgvectorx<=((BPvectorx+RBvectorx)/2);
		avgvectory<=((BPvectory+RBvectory)/2);

		vx_s<=avgvectorx[8];
		vy_s<=avgvectory[8];

		if(avgvectorx!=9'b000000000) begin
			case(vx_s)
				1'b1: dx=2'b10;
				1'b0: dx=2'b01;
			endcase
		end
		else begin
			dx=2'b00;
		end
		
		if(avgvectory!=9'b000000000) begin
			case(vy_s)
				1'b1: dy=2'b10;
				1'b0: dy=2'b01;
			endcase
		end
		else begin
			dy=2'b00;
		end
	end
endmodule


module return_green_ghost_direction(
	input [8:0] pacmanx,
    input [8:0] pacmany,
	input [8:0] ghostx,
    input [8:0] ghosty,
	input clock_in,
	output reg [1:0] dx,
	output reg [1:0] dy);

	reg vx_s;
	reg vy_s;
	reg [8:0] vectorx;
	reg [8:0] vectory;


	localparam map_array = 9'd21;

	always @(posedge clock_in) begin

		vectorx<=pacmanx-ghostx;
		vectory<=pacmany-ghosty;
		vx_s<= ~vectorx[8];
		vy_s<= ~vectory[8];

		if(vectorx!=9'b000000000) begin
			case(vx_s)
				1'b1: dx=2'b10;
				1'b0: dx=2'b01;
			endcase
		end
		else begin
			dx=2'b00;
		end
		
		if(vectory!=9'b000000000) begin
			case(vy_s)
				1'b1: dy=2'b10;
				1'b0: dy=2'b01;
			endcase
		end
		else begin
			dy=2'b00;
		end
	end

endmodule



module return_red_ghost_direction(
	input [8:0] pacmanx,
   input [8:0] pacmany,
	input [8:0] ghostx,
   input [8:0] ghosty,
	input clock_in,
	output reg [1:0] dx,
	output reg [1:0] dy);

	reg vx_s;
	reg vy_s;
	reg [8:0] vectorx;
	reg [8:0] vectory;


	localparam map_array = 9'd21;

	always @(posedge clock_in) begin

		vectorx<=pacmanx-ghostx;
		vectory<=pacmany-ghosty;
		vx_s<=vectorx[8];
		vy_s<=vectory[8];

		if(vectorx!=9'b000000000) begin
			
				case(vx_s)
					1'b1: dx=2'b10;
					1'b0: dx=2'b01;
				endcase
		end
		else begin
			dx=2'b00;
		end
		
		if(vectory!=9'b000000000) begin
			case(vy_s)
				1'b1: dy=2'b10;
				1'b0: dy=2'b01;
			endcase
		end
		else begin
			dy=2'b00;
		end
	end

endmodule