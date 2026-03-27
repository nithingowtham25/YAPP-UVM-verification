/*-----------------------------------------------------------------
File name     : yapp_tx_agent.sv
Description   : lab03_uvc YAPP Agent
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class yapp_tx_agent extends uvm_agent;

   // Handles for sequencer, driver and monitor
   yapp_tx_sequencer sequencer;
   yapp_tx_driver    driver;
   yapp_tx_monitor   monitor;

   // In-built agent classification
   // uvm_active_passive_enum is_active = UVM_ACTIVE; /* (Active by default) */

   // Component macro
   `uvm_component_utils_begin(yapp_tx_agent)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
   `uvm_component_utils_end

   // Constructor
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase (uvm_phase phase);
      super.build_phase(phase);

      // monitor is always constructed
      monitor = new("monitor", this);

      // Sequencer and driver are constructed only when its ACTIVE agent
      if(is_active == UVM_ACTIVE) begin
         sequencer = new("sequencer", this);
         driver = new("driver", this);
      end
   endfunction : build_phase

   function void connect_phase (uvm_phase phase);
      // Connect driver and sequencer if its an active agent
      if( is_active == UVM_ACTIVE) begin
         driver.seq_item_port.connect(sequencer.seq_item_export);
      end
   endfunction : connect_phase

	// Optional - Start of Simulation phase
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info("LAB3", {"Start of Simulation for ", get_full_name()}, UVM_HIGH)
	endfunction : start_of_simulation_phase

endclass : yapp_tx_agent