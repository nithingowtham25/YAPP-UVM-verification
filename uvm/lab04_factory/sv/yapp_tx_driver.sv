/*-----------------------------------------------------------------
File name     : yapp_tx_driver.sv
Description   : lab03_uvc YAPP driver
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class yapp_tx_driver extends uvm_driver #(yapp_packet);

	// yapp_packet req; /* Why is this commented? Because parameterization generated in-built handle 'req'*/

	// Component macro
	`uvm_component_utils(yapp_tx_driver)

	// Constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	// Optional - Start of Simulation phase
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info("LAB3", {"Start of Simulation for ", get_full_name()}, UVM_HIGH)
	endfunction : start_of_simulation_phase

	task run_phase (uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);	// Get next item
			send_to_dut(req);									// To drive the packet to DUT
			seq_item_port.item_done();				// handshake to sequencer that item is done
		end
	endtask : run_phase

	// Task to drive the DUT - Just print the UVM info
	task send_to_dut(yapp_packet pkt);
		`uvm_info("LAB3", $sformatf("Packet is \n%s", pkt.sprint()), UVM_LOW)	
		/* Note: sprint()creates the print string, but does not write it to the output */

		#10;	// Intentional delay
	endtask : send_to_dut

endclass : yapp_tx_driver