/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/
// Global definitions
`define ADDR_FIELD  2
`define LENGTH      6
`define WIDTH       8

// Define your enumerated type(s) here
typedef enum bit {BAD_PARITY, GOOD_PARITY} parity_type_e;

class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:

  // Define protocol data
  rand bit [`ADDR_FIELD-1:0] addr;
	rand bit [`LENGTH-1:0] length;
	rand bit [`WIDTH-1:0] payload[];	// 1 <= N <= 63
	bit [`WIDTH-1:0] parity;					// Last byte in the packet structure

  // Control knobs
	rand parity_type_e parity_type;
	rand int packet_delay;

  // Register with UVM factory to enable automation of the packet's fields
	`uvm_object_utils_begin(yapp_packet)
		`uvm_field_int(addr, UVM_ALL_ON)
		`uvm_field_int(length, UVM_ALL_ON)
		`uvm_field_array_int(payload, UVM_ALL_ON)
		`uvm_field_int(parity, UVM_ALL_ON)
		`uvm_field_enum(parity_type_e, parity_type, UVM_ALL_ON)
		`uvm_field_int(packet_delay, UVM_ALL_ON | UVM_DEC | UVM_NOCOMPARE )	// Why NO COMPARE? because its not part of the packet data
	`uvm_object_utils_end

	// Constructor
	function new(string name = "yapp_packet");
		super.new(name);
	endfunction : new

	// Constraints
	constraint valid_addr { addr != 2'b11; }	// Addresses 0,1,2 are only valid
	constraint pkt_length { length inside {[1:63]}; }	// Since 1 <= N <= 63
	constraint payload_size { length == payload.size(); }	// Payload should be equal to the size of length
	constraint parity_dist { parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1}; }	// Favoring good parity randomization
	constraint pkt_delay { packet_delay inside {[1:20]}; }	// To insert clock cycle delays

	/* Calculate parity - the parity should be a byte of even, bitwise parity, 
		 calculated over the header and payload bytes of the packet.*/

	/******************* Interesting fact!!!!! ******************************
		 This function does not have a return statement but returns calc_parity 
		 because calc_parity itself acts as a return value
	 ************************************************************************/
	function bit [7:0] calc_parity();
		calc_parity = {length, addr};	// Add the header first
		foreach(payload[i])
			calc_parity ^= payload[i];	// Then XOR with each payload data
	endfunction : calc_parity

	// Function to assign parity
	function void set_parity();
		parity = calc_parity();	// This calculated parity will be a 8 bit value

		// If the parity type is randomized to BAD parity, inject an error data to parity by incrementing its value by 1
		if (parity_type == BAD_PARITY)
			parity++;
	endfunction : set_parity

	// Post-randomize method to set parity
	function void post_randomize();
		set_parity();
	endfunction : post_randomize

endclass: yapp_packet
