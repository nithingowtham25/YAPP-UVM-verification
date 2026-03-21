/*-----------------------------------------------------------------
File name     : router_test_lib.sv
Description   : lab02_test Test creation
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
        tb = new("tb", this);
        `uvm_info("LAB2", "Executing test build phase...", UVM_HIGH)
    endfunction : build_phase

    // End of elaboration
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

endclass : base_test


class test2 extends base_test;
    // Component macro
    `uvm_component_utils(test2)

    // constructor
    function new(string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

endclass : test2