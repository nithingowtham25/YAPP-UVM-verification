/*-----------------------------------------------------------------
File name     : router_test_lib.sv
Description   : lab04_test Test creation
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

class base_test extends uvm_test;
    // Component macro
    `uvm_component_utils(base_test)

    router_tb tb;   // handle for the testbench class

    // Constructor
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // To enable transaction recording
        uvm_config_int::set(this, "*", "recording detail", 1);
        
        // uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
        //                               "default_sequence",
        //                               yapp_5_packets::get_type());
        tb = router_tb::type_id::create("tb", this);
        `uvm_info("LAB4", "Executing test build phase...", UVM_HIGH)
    endfunction : build_phase

    // End of elaboration
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

	// Optional - Start of simulation phase
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info("LAB4", {"Start of Simulation for ", get_full_name()}, UVM_HIGH)
	endfunction : start_of_simulation_phase

    // Set a drain time for objection mechanism
    task run_phase(uvm_phase phase);
        uvm_objection obj = phase.get_objection();
        obj.set_drain_time(this, 200ns);
    endtask : run_phase

    // Check phase to debug configuration errors
    function void check_phase (uvm_phase phase);
        check_config_usage();   // reports any unmatched settings
    endfunction : check_phase

endclass : base_test


class test2 extends base_test;
    // Component macro
    `uvm_component_utils(test2)

    // constructor
    function new(string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

endclass : test2

/*******************************************************************************
*********************** SHORT PACKET TEST **************************************
*******************************************************************************/
class short_packet_test extends base_test;
    // Component macro
    `uvm_component_utils(short_packet_test)

    // Constructor
    function new (string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    function void build_phase (uvm_phase phase);
        // Whenever someone asks for yapp_packet → give short_yapp_packet instead
        yapp_packet::type_id::set_type_override(short_yapp_packet::get_type());

        // When run_phase starts, run this sequence on this sequencer
        uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
                                "default_sequence",
                                yapp_5_packets::get_type());

        super.build_phase(phase);
    endfunction : build_phase

endclass : short_packet_test

/*******************************************************************************
*********************** NEW CONFIGURATION TEST *********************************
*******************************************************************************/
class set_config_test extends base_test;
    // Component macro
    `uvm_component_utils(set_config_test)

    // Constructor
    function new (string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    function void build_phase (uvm_phase phase);
        // To set uvm agent as passive before building the uvm environment
        uvm_config_int::set(this, "tb.yapp.tx_agent", "is_active", UVM_PASSIVE);
        
        super.build_phase(phase);
    endfunction : build_phase

endclass : set_config_test


/*******************************************************************************
************* LAB 5 - RUNNING A TEST USING A NEW SEQUENCE **********************
*******************************************************************************/
class incr_payload_test extends base_test;
    // Component macro
    `uvm_component_utils(incr_payload_test)

    // Constructor
    function new (string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    function void build_phase (uvm_phase phase);
        // Whenever someone asks for yapp_packet → give short_yapp_packet instead
        yapp_packet::type_id::set_type_override(short_yapp_packet::get_type());
        
        // When run_phase starts, run this sequence on this sequencer
        uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
                                "default_sequence",
                                yapp_incr_payload_seq::get_type());

        super.build_phase(phase);
    endfunction : build_phase

endclass : incr_payload_test

/*******************************************************************************
************* LAB 5 - Test to run all the created sequences ********************
*******************************************************************************/
class exhaustive_seq_test extends base_test;
    // Component macro
    `uvm_component_utils(exhaustive_seq_test)

    // Constructor
    function new (string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    function void build_phase (uvm_phase phase);
        // Whenever someone asks for yapp_packet → give short_yapp_packet instead
        yapp_packet::type_id::set_type_override(short_yapp_packet::get_type());
        
        // When run_phase starts, run this sequence on this sequencer
        uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
                                "default_sequence",
                                yapp_exhaustive_seq::get_type());

        super.build_phase(phase);
    endfunction : build_phase

endclass : exhaustive_seq_test


/*******************************************************************************
************* LAB 6 - Testing DUT with short yapp 012 seq **********************
*******************************************************************************/
class short_yapp_012_seq extends base_test;
    // Component macro
    `uvm_component_utils(short_yapp_012_seq)

    // Constructor
    function new (string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    function void build_phase (uvm_phase phase);
        // Whenever someone asks for yapp_packet → give short_yapp_packet instead
        yapp_packet::type_id::set_type_override(short_yapp_packet::get_type());
        
        // When run_phase starts, run this sequence on this sequencer
        uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
                                "default_sequence",
                                yapp_012_seq::get_type());

        super.build_phase(phase);
    endfunction : build_phase

endclass : short_yapp_012_seq