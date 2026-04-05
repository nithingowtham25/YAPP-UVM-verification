/*-----------------------------------------------------------------
File name     : router_tb.sv
Description   : lab02_test Testbench creation
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class router_tb extends uvm_env;

	// Add the uvm_componet_utils macro
	`uvm_component_utils(router_tb)

	yapp_env yapp;	// Declare a handle for the YAPP UVC class

	// Component constructor
	function new (string name, uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	// Build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		yapp = new("yapp", this);
		`uvm_info("LAB3", "Executing testbench build phase....", UVM_HIGH)
	endfunction : build_phase

	// Optional - Start of Simulation phase
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info("LAB3", {"Start of Simulation for ", get_full_name()}, UVM_HIGH)
	endfunction : start_of_simulation_phase

endclass