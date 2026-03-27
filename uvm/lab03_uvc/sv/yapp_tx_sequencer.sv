/*-----------------------------------------------------------------
File name     : yapp_tx_sequencer.sv
Description   : lab03_uvc YAPP Sequencer
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class yapp_tx_sequencer extends uvm_sequencer #(yapp_packet);

	// Component macro
	`uvm_component_utils(yapp_tx_sequencer)

	// Constructor
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	// Optional - Start of simulation phase
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info("LAB3", {"Start of Simulation for ", get_full_name()}, UVM_HIGH)
	endfunction : start_of_simulation_phase

endclass : yapp_tx_sequencer