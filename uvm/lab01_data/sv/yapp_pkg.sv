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
endpackage : yapp_pkg