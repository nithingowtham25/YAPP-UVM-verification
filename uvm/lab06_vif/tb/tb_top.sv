/*-----------------------------------------------------------------
File name     : tb_top.sv
Description   : lab02_test tb_top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

module tb_top;

	import uvm_pkg::*;              // import the UVM library
	`include "uvm_macros.svh"       // include the UVM macros
	import yapp_pkg::*;             // import the YAPP package
	`include "router_tb.sv"         // include the router testbench
	`include "router_test_lib.sv"   // include the router base test

	initial begin
		// To set the YAPP ifc instance into the config database
		yapp_vif_config::set(null,"*.tb.yapp.tx_agent.*","vif", hw_top.in0);
		run_test();	// To start the test
	end

endmodule : tb_top
