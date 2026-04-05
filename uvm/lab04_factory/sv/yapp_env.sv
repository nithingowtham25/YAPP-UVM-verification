/*-----------------------------------------------------------------
File name     : yapp_env.sv
Description   : lab03_uvc YAPP environment
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class yapp_env extends uvm_env;

    yapp_tx_agent   tx_agent;   //handle for yapp_tx_agent

    // Component macro
    `uvm_component_utils(yapp_env)

    // Constructor
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        tx_agent = new("tx_agent", this);
    endfunction : build_phase

	// Optional - Start of Simulation phase
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info("LAB3", {"Start of Simulation for ", get_full_name()}, UVM_HIGH)
	endfunction : start_of_simulation_phase


endclass : yapp_env