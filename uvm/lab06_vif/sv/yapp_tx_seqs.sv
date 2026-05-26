/*-----------------------------------------------------------------
File name     : yapp_tx_seqs.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : YAPP UVC simple TX test sequence for labs 2 to 4
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// SEQUENCE: base yapp sequence - base sequence with objections from which 
// all sequences can be derived
//
//------------------------------------------------------------------------------
class yapp_base_seq extends uvm_sequence #(yapp_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_base_seq)

  // Constructor
  function new(string name="yapp_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : yapp_base_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: yapp_5_packets
//
//  Configuration setting for this sequence
//    - update <path> to be hierarchial path to sequencer 
//
//  uvm_config_wrapper::set(this, "<path>.run_phase",
//                                 "default_sequence",
//                                 yapp_5_packets::get_type());
//
//------------------------------------------------------------------------------
class yapp_5_packets extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_5_packets)

  // Constructor
  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask
  
endclass : yapp_5_packets

//------------------------------------------------------------------------------
//
// SEQUENCE 1: yapp_1_seq – single packet to address 1 
//
//------------------------------------------------------------------------------
class yapp_1_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_1_seq)

  // Constructor
  function new(string name="yapp_1_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_1_seq sequence", UVM_LOW)
    `uvm_do_with(req, {req.addr == 2'b01;})
  endtask
  
endclass : yapp_1_seq

//------------------------------------------------------------------------------
//
// SEQUENCE 2: yapp_012_seq – three packets with incrementing addresses 
//
//------------------------------------------------------------------------------
class yapp_012_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_012_seq)

  // Constructor
  function new(string name="yapp_012_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_012_seq sequence", UVM_LOW)
    `uvm_do_with(req, {req.addr == 2'b00;})
    `uvm_do_with(req, {req.addr == 2'b01;})
    `uvm_do_with(req, {req.addr == 2'b10;})
  endtask
  
endclass : yapp_012_seq

//------------------------------------------------------------------------------
//
// SEQUENCE 3: yapp_111_seq – three packets to address 1 
//             ( (do yapp_1_seq three times) )
//
//------------------------------------------------------------------------------
class yapp_111_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_111_seq)

  // Create nested sequence handle to use it in the task body
  yapp_1_seq seq_addr_1;

  // Constructor
  function new(string name="yapp_111_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_111_seq sequence", UVM_LOW)
    repeat(3)
      `uvm_do(seq_addr_1)
  endtask
  
endclass : yapp_111_seq

//------------------------------------------------------------------------------
//
// SEQUENCE 4: yapp_repeat_addr_seq – two packets to the same (random) address 
//             (addr==prev_addr: remember packet address cannot be 3)  
//             Hint: Use a random sequence property with constraint. 
//
//------------------------------------------------------------------------------
class yapp_repeat_addr_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_repeat_addr_seq)

  bit[1:0] seq_addr;

  // Constructor
  function new(string name="yapp_repeat_addr_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_repeat_addr_seq sequence", UVM_LOW)
    `uvm_do(req)  // 1st Packet
    seq_addr = req.addr;  // Store the address of the 1st packet
    `uvm_do_with(req, {req.addr == seq_addr;})
  endtask
  
endclass : yapp_repeat_addr_seq

//------------------------------------------------------------------------------
//
// SEQUENCE 5: yapp_incr_payload_seq
// *Create a single packet to send. 
// *Randomize the packet. 
// *Set the payload values of the single packet to increment from 0 to (length -1). 
// *Update parity. 
// *Send the packet. 
// *Hint: Use `uvm_create and `uvm_send macros.
//------------------------------------------------------------------------------
class yapp_incr_payload_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_incr_payload_seq)

  // Constructor
  function new(string name="yapp_incr_payload_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_incr_payload_seq sequence", UVM_LOW)
    `uvm_create(req)
    if(req.randomize()) begin   // If randomization succeedeed
      foreach(req.payload[i])
        req.payload[i] = i;     // Update the payload values
      req.set_parity();         // Recalculate parity based on updated payload
      `uvm_send(req)            // Send the packet w/o further randomization
    end
  endtask
  
endclass : yapp_incr_payload_seq

//------------------------------------------------------------------------------
//
// SEQUENCE 6: yapp_exhaustive_seq – execute all sequences to test 
//             (To run sequences 1 to 5). 
//------------------------------------------------------------------------------
class yapp_exhaustive_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_exhaustive_seq)

  // Handles for all the sequences
  yapp_1_seq    y1;
  yapp_012_seq  y012;
  yapp_111_seq  y111;
  yapp_repeat_addr_seq  y_rpt_seq;
  yapp_incr_payload_seq y_inc_pl_seq;

  // Constructor
  function new(string name="yapp_exhaustive_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_exhaustive_seq sequence", UVM_LOW)
    `uvm_do(y1)
    `uvm_do(y012)
    `uvm_do(y111)
    `uvm_do(y_rpt_seq)
    `uvm_do(y_inc_pl_seq)
  endtask
  
endclass : yapp_exhaustive_seq
