/*-----------------------------------------------------------------
File name     : run.f
Description   : lab04_data simulator run template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
              : Set $UVMHOME to install directory of UVM library
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/
// 64 bit option for AWS labs
-64

 -uvmhome $UVMHOME

// include directories
-incdir ../sv

// compile files
// UVC package
../sv/yapp_pkg.sv

// UVC interfaces
../sv/yapp_if.sv 

// clock generator module
clkgen.sv
// top module for UVM test environment
tb_top.sv
// accelerated top module for interface instance
hw_top.sv

// simulation paramters
// +UVM_TESTNAME=base_test
// +UVM_TESTNAME=short_packet_test
// +UVM_TESTNAME=set_config_test
// +UVM_TESTNAME=test2
// +UVM_TESTNAME=exhaustive_seq_test
+UVM_TESTNAME=short_yapp_012_seq

// +UVM_VERBOSITY=UVM_HIGH

// default timescale
-timescale 1ns/1ns