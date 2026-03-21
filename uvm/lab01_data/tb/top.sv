/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
Developer     : Nithin Gowtham Saravanan
-----------------------------------------------------------------*/

module top;
// import the UVM library
import uvm_pkg::*;
// include the UVM macros
`include "uvm_macros.svh"
// import the YAPP package
import yapp_pkg::*;

// generate 5 random packets and use the print method
// to display the results
initial begin
    yapp_packet pkt;
    repeat(5) begin
        pkt = new();
        if(!pkt.randomize())
            `uvm_error("PKT", "RANDOMIZATION FAILED")
        pkt.print();
    end
end
// experiment with the copy, clone and compare UVM method
endmodule : top
