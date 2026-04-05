/*-----------------------------------------------------------------
File name     : yapp_tx_monitor.sv
Description   : lab03_uvc YAPP Monitor
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class yapp_tx_monitor extends uvm_monitor;
  
  // Component macro
  `uvm_component_utils(yapp_tx_monitor)

  // Constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

	// Optional - Start of simulation phase
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info("LAB3", {"Start of Simulation for ", get_full_name()}, UVM_HIGH)
	endfunction : start_of_simulation_phase

  task run_phase (uvm_phase phase);
    `uvm_info("LAB3", "Inside run_phase of MONITOR", UVM_LOW)
  endtask : run_phase

endclass : yapp_tx_monitor