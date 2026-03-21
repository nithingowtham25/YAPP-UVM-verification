/*-----------------------------------------------------------------
File name     : router_tb.sv
Description   : lab02_test Testbench creation
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class router_tb extends uvm_env;

	// Add the uvm_componet_utils macro
	`uvm_component_utils(router_tb)

	// Component constructor
	function new (string name, uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	// Build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("LAB2", "Executing testbench build phase....", UVM_HIGH)
	endfunction : build_phase

endclass