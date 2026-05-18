# Lab 5: UVM Sequences and Stimulus Generation

## 📌 Overview

This lab introduces sequence-based stimulus generation in UVM. Multiple reusable sequences were implemented to generate constrained-random YAPP packet traffic and exercise the verification environment using different packet scenarios.

The lab also demonstrates automatic sequence execution using sequencer configuration and highlights the importance of runtime randomization handling during exhaustive testing.

---

## 🎯 Objectives

* Create reusable UVM sequences
* Generate constrained-random packet stimulus
* Configure automatic sequence execution
* Understand runtime randomization failures
* Apply exhaustive packet testing scenarios

---

## 🧱 Concepts Implemented

### 1️⃣ UVM Sequence Creation

Implemented reusable sequences extending `uvm_sequence #(yapp_packet)`.

#### Implementation

```systemverilog id="1ndu6u"
class yapp_5_packets extends uvm_sequence #(yapp_packet);
```

#### Behavior

* Generates transaction-level packet stimulus
* Enables reusable traffic scenarios
* Integrates with the YAPP sequencer

---

### 2️⃣ Sequence Item Generation

Used UVM sequence macros for packet creation and execution.

#### Implementation

```systemverilog id="pm4m0p"
`uvm_create(req)
`uvm_send(req)
```

#### Behavior

* Creates packet transactions using the factory
* Sends randomized packets through the sequencer-driver path

---

### 3️⃣ Default Sequence Configuration

Configured sequences to start automatically during `run_phase`.

#### Implementation

```systemverilog id="n4p7el"
uvm_config_wrapper::set(
  this,
  "tb.yapp.agent.sequencer.run_phase",
  "default_sequence",
  yapp_5_packets::get_type()
);
```

#### Behavior

* Automatically starts the configured sequence
* Eliminates manual `start()` calls inside tests

---

### 4️⃣ Constrained Random Packet Generation

Generated randomized packets with:

* Variable payload sizes
* Valid destination addresses
* Good and bad parity combinations
* Incrementing payload patterns

---

### 5️⃣ Exhaustive Stimulus Testing

Implemented exhaustive packet generation across multiple packet combinations.

#### Behavior

* Exercises multiple packet scenarios
* Demonstrates runtime randomization checking
* Validates sequence-level packet generation behavior

---

## 🔄 Execution Flow

```text id="xz0y7f"
Test starts
   ↓
Default sequence configured
   ↓
Sequence starts on sequencer
   ↓
Packet randomized
   ↓
Driver sends transaction
   ↓
Monitor observes packet activity
```

---

## 🧪 Sequences Implemented

### ✅ `yapp_5_packets`

* Generates 5 randomized YAPP packets
* Used as the default sequence in multiple tests

---

### ✅ `yapp_012_seq`

* Generates packets targeting addresses 0, 1, and 2
* Exercises valid routing paths through the DUT

---

### ✅ `yapp_1_seq`

* Generates packets directed only to address 1
* Used for focused single-destination testing

---

### ✅ `yapp_incr_payload_seq`

* Generates packets with incrementing payload data
* Exercises payload handling scenarios

---

### ✅ `yapp_exhaustive_seq`

* Exercises multiple packet combinations exhaustively
* Initial runtime randomization failures were observed during simulation
* The issue occurred due to address constraint conflicts while generating short packets
* The issue was resolved by removing the address constraint in `short_yapp_packet`
* This allowed the exhaustive sequence to complete without randomization violations

---

## 🧠 Key Concepts Learned

* Sequences generate transaction-level stimulus
* Sequencers control sequence execution
* Factory-created packets integrate seamlessly with sequences
* Automatic sequence execution improves test scalability
* Runtime randomization failures help identify constraint conflicts

---

## ⚠️ Common Pitfalls

* Constraint conflicts can cause runtime randomization failures
* Randomization failures occur during simulation, not compilation
* Incorrect sequence constraints can block exhaustive testing scenarios
* Factory-created packet types must remain compatible with sequence behavior

---

## ▶️ How to Run

```bash id="a9ny4f"
source setup.bash
cd uvm/lab05_sequences
xrun -f run.f
```

### Run specific tests:

```bash id="u7j6w7"
+UVM_TESTNAME=short_packet_test
+UVM_TESTNAME=set_config_test
```

---

## 📊 Expected Results

* Multiple packet sequences generated successfully
* Automatic sequence execution through the sequencer
* Randomized packet traffic observed in simulation
* Exhaustive sequence runs without runtime constraint violations after fixes

---

## 🧠 Conceptual Understanding

| Concept     | Role                                        |
| ----------- | ------------------------------------------- |
| Sequence    | Generates transaction-level stimulus        |
| Sequencer   | Controls sequence execution flow            |
| Driver      | Converts transactions into DUT activity     |
| Constraints | Control legal packet randomization behavior |

---

## 🔍 Implementation Highlights

* Reusable sequence architecture
* Constrained-random packet generation
* Automatic sequence execution using `default_sequence`
* Exhaustive packet stimulus testing
* Runtime constraint validation during simulation

---

## ✅ Outcome

* Successfully implemented reusable UVM sequences
* Integrated sequence execution into the YAPP verification environment
* Applied constrained-random stimulus generation techniques
* Resolved runtime randomization conflicts during exhaustive testing

---
