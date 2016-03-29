
// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions of V2.0:	MTL controller adapted to a slideshow application
//										on the DE0-Nano board.
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            		:| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Fan					:| 07/06/30  :| Initial Revision
//	  V2.0 :| Charlotte Frenkel      :| 14/08/03  :| Improvements and adaptation to a
//																	 slideshow application on the DE0-Nano
// --------------------------------------------------------------------

module mtl_controller_avalon(
	// Avalon side
	input  wire        Avalon_CLK_50,     //   clock_sink.clk
	input  wire        Avalon_reset,      //   reset_sink.reset
	input  wire [7:0]  Avalon_address,    // avalon_slave.address
	input  wire        Avalon_read,       //             .read
	output wire [31:0] Avalon_readdata,  //             .readdata
	input  wire        Avalon_write,      //             .write
	input  wire [31:0] Avalon_writedata, //             .writedata
	
	// SPI Side
	input	wire	[7:0] iSPI,
	// Host Side
	input wire		  iCLK, 				// Input LCD control clock
	input wire        iRST_n, 				// Input system reset
	input	wire		  iLoading,			// Input signal telling in which loading state is the system
	output	wire		  oNewFrame,			// Output signal being a pulse when a new frame of the LCD begins
	output	wire		  oEndFrame,			// Output signal being a pulse when a frame of the LCD ends
	// SDRAM Side
	input	 wire [31:0]	  iREAD_DATA, 		// Input data from SDRAM (contains R, G and B colors)
	output	wire		  oREAD_SDRAM_EN,	// Output read SDRAM data control signal
	// LCD Side
	output	wire		  oHD,					// Output LCD horizontal sync 
	output	wire		  oVD,					// Output LCD vertical sync 
	output wire [7:0]	  oLCD_R,				// Output LCD red color data 
	output wire [7:0]	  oLCD_G,           // Output LCD green color data  
	output wire [7:0]	  oLCD_B            // Output LCD blue color data  
);
						
//============================================================================
// PARAMETER declarations
//============================================================================

// All these parameters are given in the MTL datasheet, section 3.2,
// available in the project file folder
parameter H_LINE = 1056; 
parameter V_LINE = 525;
parameter Horizontal_Blank = 46;          //H_SYNC + H_Back_Porch
parameter Horizontal_Front_Porch = 210;
parameter Vertical_Blank = 23;      	   //V_SYNC + V_BACK_PORCH
parameter Vertical_Front_Porch = 22;


//=============================================================================
// REG/WIRE declarations
//=============================================================================

reg  [10:0] x_cnt;  
reg  [9:0]	y_cnt; 
wire [7:0]	read_red;
wire [7:0]	read_green;
wire [7:0]	read_blue; 
wire		display_area, display_area_prev;
wire		q_rom;
wire [18:0] address;
reg			mhd;
reg			mvd;
reg			loading_buf;
reg			no_data_yet;

// -- QBERT signals ----------------//

logic [7:0] QBERT_GAME_red;
logic [7:0] QBERT_GAME_green;
logic [7:0] QBERT_GAME_blue;

// ===========================================================================
// AVALON interface
// ===========================================================================

logic enable;
logic [4:0] A_enable = 4'd0;

// ---- Cube definition ------------//

logic [10:0] XLENGTH;
logic [10:0] XDIAG_DEMI;
logic [9:0] YDIAG_DEMI;

logic [10:0] RANK1_X_OFFSET;
logic [9:0] RANK1_Y_OFFSET;

logic [20:0] xydiag_demi;
logic [20:0] rank1_xy_offset;

logic [4:0] A_XLENGTH = 4'd1;
logic [4:0] A_xydiag_demi = 4'd2;
logic [4:0] A_rank1_xy_offset = 4'd3;

// ---- Qbert definition -----------//

logic [10:0] QBERT_POSITION_X0;
logic [10:0] QBERT_POSITION_X1;
logic [9:0] QBERT_POSITION_Y0;
logic [9:0] QBERT_POSITION_Y1;

logic [20:0] qbert_position_xy0;
logic [20:0] qbert_position_xy1;
logic  		 qbert_jump; 	

logic [4:0] A_qbert_position_xy0 = 4'd4;
logic [4:0] A_qbert_position_xy1 = 4'd5;
logic [4:0] A_qbert_jump = 4'd6;


// ---- SPI definition -----------//

reg [31:0] reg_readdata;

logic [4:0] A_iSPI = 4'd7;

// ---- READ & WRITE -----------//

always @ (posedge Avalon_CLK_50)
begin
	if (Avalon_reset) begin
		enable <= 1'd0;
		XLENGTH <= 11'd0;
		xydiag_demi <= 21'd0;
		rank1_xy_offset <= 21'd0;
		qbert_position_xy0 <= 21'd0;
		qbert_position_xy1 <= 21'd0;
		qbert_jump <= 1'd0;
	end
	else begin 
		if (Avalon_write) begin 
			case(Avalon_address)
				A_enable : enable <= Avalon_writedata[0];
				A_XLENGTH : XLENGTH <= Avalon_writedata[10:0];
				A_xydiag_demi : xydiag_demi <= Avalon_writedata[20:0];
				A_rank1_xy_offset : rank1_xy_offset <= Avalon_writedata[20:0];
				A_qbert_position_xy0 : qbert_position_xy0 <= Avalon_writedata[20:0];
				A_qbert_position_xy1 : qbert_position_xy1 <= Avalon_writedata[20:0];
				A_qbert_jump : qbert_jump <= Avalon_writedata[0];
				default;
			endcase
		end

	 	if (Avalon_read) begin 
			case(Avalon_address)
				A_enable : reg_readdata <= {31'b0,enable};
				A_XLENGTH : reg_readdata <= {21'b0,XLENGTH};  
				A_xydiag_demi : reg_readdata <= {11'b0,xydiag_demi};
				A_rank1_xy_offset : reg_readdata <= {11'b0,rank1_xy_offset};
				A_qbert_position_xy0 : reg_readdata <= {11'b0,qbert_position_xy0};
				A_qbert_position_xy1 : reg_readdata <= {11'b0,qbert_position_xy1};
				A_qbert_jump : reg_readdata <= {31'b0,qbert_jump};
				A_iSPI : reg_readdata <= {24'b0, iSPI};
				default;
			endcase
		end				 
	end
end

assign Avalon_readdata = reg_readdata;


always_ff @(posedge Avalon_CLK_50)
begin
	{XDIAG_DEMI, YDIAG_DEMI} <= xydiag_demi;
	{RANK1_X_OFFSET, RANK1_Y_OFFSET} <= rank1_xy_offset;
	{QBERT_POSITION_X0, QBERT_POSITION_Y0} <= qbert_position_xy0;
	{QBERT_POSITION_X1, QBERT_POSITION_Y1} <= qbert_position_xy1;
end


//=============================================================================
// Structural coding
//=============================================================================


//--- Assigning the right color data as a function -------------------------
//--- of the current pixel position ----------------------------------------

// This loading ROM contains B/W data to display the loading screen.
// The data is available in the rom.mif file in the project folder.
// Note that it is just a gadget for the demonstration, it is not efficient!
// Indeed, it must contain 1bit x 800 x 480 = 384000 bits of data,
// which is more than 60% of the total memory bits of the FPGA.
// Don't hesitate to suppress it.

/*
Loading_ROM	Loading_ROM_inst (
	.address (address),
	.clock (iCLK),
	.q (q_rom),
	.rden (iLoading)
);
*/

// This signal controls read requests to the SDRAM.
// When asserted, new data becomes available in iREAD_DATA
// at each clock cycle.
assign	oREAD_SDRAM_EN = (~loading_buf && display_area_prev);
						
// This signal indicates the LCD active display area shifted back from
// 1 pixel in the x direction. This accounts for the 1-cycle delay
// in the sequential logic.
assign	display_area = ((x_cnt>(Horizontal_Blank-2)&&
						(x_cnt<(H_LINE-Horizontal_Front_Porch-1))&&
						(y_cnt>(Vertical_Blank-1))&& 
						(y_cnt<(V_LINE-Vertical_Front_Porch))));

// This signal indicates the same LCD active display area, now shifted
// back from 2 pixels in the x direction, again for sequential delays.
assign	display_area_prev =	((x_cnt>(Horizontal_Blank-3)&&
						(x_cnt<(H_LINE-Horizontal_Front_Porch-2))&&
						(y_cnt>(Vertical_Blank-1))&& 
						(y_cnt<(V_LINE-Vertical_Front_Porch))));	
						
// This signal updates the ROM address to read from based on the current pixel position.
assign address = display_area_prev ? ((x_cnt-(Horizontal_Blank-2)) + (y_cnt-Vertical_Blank)*800) : 19'b0;


// Assigns the right color data.
always_ff @(posedge iCLK) begin
	// If the screen is reset, put at zero the color signals.
	if (!iRST_n) begin
		read_red 	<= 8'b0;
		read_green 	<= 8'b0;
		read_blue 	<= 8'b0;
	// If we are in the active display area...
	end else if (display_area) begin
		// ...and if no data has been sent yet by the PIC32,
		// then display a white screen.
		
//000000000000000000000000000000000000000000000000000000000//				
//*****BEGIN********** QBERT COLOR GAME *********BEGIN*****// 
//000000000000000000000000000000000000000000000000000000000//	
		if (no_data_yet) begin
					if (enable) begin
						read_red 	<= QBERT_GAME_red;
						read_green 	<= QBERT_GAME_green;
						read_blue 	<= QBERT_GAME_blue;
					end 
					else begin
						read_red 	<= 8'd199;
						read_green 	<= 8'd65;
						read_blue 	<= 8'd175;
					end
		end				
//000000000000000000000000000000000000000000000000000000000//						
//*****END************* QBERT COLOR GAME ********END*******//
//000000000000000000000000000000000000000000000000000000000//
	
		// ...and if the slideshow is currently loading,
		// then display the loading screen.
		// The current pixel is black (resp. white)
		// if a 1 (resp. 0) is written in the ROM.
		else if (loading_buf) begin
			if(q_rom) begin
				read_red 	<= 8'b0;
				read_green 	<= 8'b0;
				read_blue 	<= 8'b0;
			end else begin
				read_red 	<= 8'd255;
				read_green 	<= 8'd255;
				read_blue 	<= 8'd255;
			end
		// ...and if the slideshow has been loaded,
		// then display the values read from the SDRAM.
		end else begin
			read_red 	<= iREAD_DATA[23:16];
			read_green 	<= iREAD_DATA[15:8];
			read_blue 	<= iREAD_DATA[7:0];
		end
	// If we aren't in the active display area, put at zero
	// the color signals.
	end else begin
		read_red 	<= 8'b0;
		read_green 	<= 8'b0;
		read_blue 	<= 8'b0;
	end
end


//--- Keeping track of x and y positions of the current pixel ------------------
//--- and generating the horiz. and vert. sync. signals ------------------------

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
	begin
		x_cnt <= 11'd0;	
		mhd  <= 1'd0;  
	end	
	else if (x_cnt == (H_LINE-1))
	begin
		x_cnt <= 11'd0;
		mhd  <= 1'd0;
	end	   
	else
	begin
		x_cnt <= x_cnt + 11'd1;
		mhd  <= 1'd1;
	end	
end

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
		y_cnt <= 10'd0;
	else if (x_cnt == (H_LINE-1))
	begin
		if (y_cnt == (V_LINE-1))
			y_cnt <= 10'd0;
		else
			y_cnt <= y_cnt + 10'd1;	
	end
end

always@(posedge iCLK  or negedge iRST_n) begin
	if (!iRST_n)
		mvd  <= 1'b1;
	else if (y_cnt == 10'd0)
		mvd  <= 1'b0;
	else
		mvd  <= 1'b1;
end	

assign oNewFrame = ((x_cnt == 11'd0)   && (y_cnt == 10'd0)  );	
assign oEndFrame = ((x_cnt == 11'd846) && (y_cnt == 10'd503));	
	
	
//--- Retrieving the current loading state based on the iLoading signal --------
	
// - When iLoading is initially at 0, the PIC32 has not sent anything yet, the 
//   no_data_yet and loading_buf signals are at 1 and a white screen is displayed.
// - When iLoading rises to 1, the slideshow is currently loading and no_data_yet
//   falls at zero: the loading screen is displayed.
// - When iLoading falls back to 0, the loading_buf signal falls at zero at the
//   beginning of the next frame. The SDRAM data is then displayed.
always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n) begin
		no_data_yet <= 1'b1;
		loading_buf <= 1'b1;
	end else if (!iLoading && oNewFrame && !no_data_yet) 
		loading_buf <= 1'b0;
	else if (iLoading)
		no_data_yet <= 1'b0;
end	
	

//--- Assigning synchronously the color and sync. signals ------------------

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
		begin
			oHD	<= 1'd0;
			oVD	<= 1'd0;
			oLCD_R <= 8'd0;
			oLCD_G <= 8'd0;
			oLCD_B <= 8'd0;
		end
	else
		begin
			oHD	<= mhd;
			oVD	<= mvd;
			oLCD_R <= read_red;
			oLCD_G <= read_green;
			oLCD_B <= read_blue;
		end		
end

//=============================================================================
// QBERT GAME
//=============================================================================


Qbert_Map2 Beta(
	.CLK_33(iCLK),
	.reset(!iRST_n),
	.red(QBERT_GAME_red),
	.green(QBERT_GAME_green),
	.blue(QBERT_GAME_blue),
	.*
);

	
						
endmodule




