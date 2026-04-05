/*-----------------------------------------------------------------
File name     : yapp_pkg.sv
Description   : lab01_data YAPP package file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

package yapp_pkg;

    import uvm_pkg::*;          // import UVM library
    `include "uvm_macros.svh"   // include UVM macros
    `include "yapp_packet.sv"   // include yapp packet definitions

    // Adding UVM components to the YAPP package
    // Note that order of "include" matters!!!!
    `include "yapp_tx_monitor.sv"  
    `include "yapp_tx_sequencer.sv" 
    `include "yapp_tx_seqs.sv" 
    `include "yapp_tx_driver.sv" 
    `include "yapp_tx_agent.sv" 
    `include "yapp_env.sv"

endpackage : yapp_pkg