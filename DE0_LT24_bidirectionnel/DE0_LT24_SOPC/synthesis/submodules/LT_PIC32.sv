// LT24_PIC32.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module LT_PIC32 (
		input  wire [31:0] writedata, //     avalon_slave.writedata
		output wire [31:0] readdata,  //                 .readdata
		input  wire        write,     //                 .chipselect
		input  wire        read,      //                 .read
		input  wire [7:0] address,   //                 .address
		input  wire        SPI_CS,    //         LT24_SPI.cs
		input  wire        SPI_SDI,   //                 .sdi
		output wire        SPI_SDO,   //                 .sdo
		input  wire        SPI_SCLK,  //                 .sclk
		input  wire        clk,       //              clk.clk
		input  wire        reset,     //            reset.reset
		output wire        SPI_INT    // interrupt_sender.irq
	);

	// TODO: Auto-generated HDL template
	
	//=======================================================
//  REG/WIRE declarations
//=======================================================

parameter Data_1  = 8'b01;
parameter Data_2  = 8'b10;


logic [7:0] Data_In;
logic [7:0] Data_Out;

//reg [31:0] DATA;
//reg 		  irqCS;
//reg 		  preCS = 1'b1;
		
always @ (posedge clk)
begin
	if (reset) begin
		Data_In <= 8'b0;
//		Data_Out <= 8'b0;
	end
	else begin 
		if (write) begin 
			case(address)
				Data_1: Data_In <= writedata[7:0];
				default;
			endcase
		end

	 	if (read) begin 
			case(address)
				Data_1: readdata <= {24'b0,Data_In};
				Data_2: readdata <= {24'b0,Data_Out};
				default;
			endcase
		end				 
	end
end

//always @(posedge clk)
//begin
//	if(!preCS & SPI_CS) begin irqCS <= 1; end
//		else begin preCS <= SPI_CS; end  
//end	


LT_SPI surf (
		.theClock (clk), 
		.theReset (reset), 
		.MySPI_clk (SPI_SCLK), 
		.MySPI_cs (SPI_CS), 
		.MySPI_sdi (SPI_SDI), 
		.MySPI_sdo (SPI_SDO),  
		.Data_In (Data_In), 
		.Data_Out (Data_Out)
		);
		
assign SPI_INT = write;
//assign readdata = DATA;

endmodule
