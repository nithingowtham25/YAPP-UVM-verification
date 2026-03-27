/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab02_test top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

module top;

	import uvm_pkg::*;              // import the UVM library
	`include "uvm_macros.svh"       // include the UVM macros
	import yapp_pkg::*;             // import the YAPP package
	`include "router_tb.sv"         // include the router testbench
	`include "router_test_lib.sv"   // include the router base test

	initial begin
		run_test();	// To start the test
	end

endmodule : top
