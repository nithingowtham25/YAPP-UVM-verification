# YAPP UVM Verification Environment

## 📌 Project Overview

This project implements a complete UVM-based verification environment for a YAPP (Yet Another Packet Protocol) router design. The environment is built from scratch following industry-standard verification methodologies and progressively enhanced across multiple labs.

The YAPP router accepts packetized data on a single input interface and routes it to one of three output channels based on the packet header. The verification environment validates functional correctness, protocol compliance, and system-level behavior.

---

## ⚙️ Setup Environment

### Prerequisites

* Linux-based environment
* Cadence Xcelium simulator (`xrun`)
* UVM library configured via environment variables

### Setup Steps

1. Source the setup script:

   ```bash
   source setup.bash
   ```

2. Navigate to the desired lab directory:

   ```bash
   cd uvm/lab01_data   # Lab 1
   cd uvm/lab02_test   # Lab 2
   cd uvm/lab03_uvc    # Lab 3
   ```

3. Compile and run simulation:

   ```bash
   xrun -f run.f
   ```

### Notes

* Ensure the correct UVM version is set before running simulations
* Simulation logs and outputs are generated during execution

---

## 📦 Packet Structure

Each YAPP packet consists of:

* **Header**

  * 2-bit address (routing information)
  * 6-bit length (payload size)

* **Payload**

  * Variable size (1 to 63 bytes)

* **Parity**

  * Even parity computed over header and payload

---

## 🧪 Lab 1: Packet Modeling (Completed)

This lab focuses on building a transaction-level model of the YAPP packet using UVM.

### Key Features

* Parameterized packet fields and dynamic payload
* Constrained randomization with valid address and size limits
* Parity generation using bitwise XOR
* UVM field automation for print, copy, and compare

### Execution Flow

```text
Create Packet → Randomize → Apply Constraints → Compute Parity → Print
```

---

## 🧪 Lab 2: UVM Testbench Architecture (Completed)

This lab establishes the foundational UVM hierarchy by introducing the test and testbench (environment) structure.

### Key Features

* Implemented `base_test` and derived `test2`
* Built `router_tb` environment
* Established parent-child hierarchy
* Observed top-down `build_phase` execution
* Printed UVM topology

### UVM Hierarchy

```text
uvm_test_top (base_test)
 └── tb (router_tb)
```

---

## 🧪 Lab 3: YAPP UVC (Transmit Agent) (Completed)

This lab implements a complete UVM Verification Component (UVC) for the YAPP transmit interface, including driver, sequencer, monitor, agent, and environment.

### Key Features

* **Driver (`yapp_tx_driver`)**

  * Extends `uvm_driver #(yapp_packet)`
  * Retrieves transactions from sequencer
  * Sends packets to DUT (currently prints packets)

* **Sequencer (`yapp_tx_sequencer`)**

  * Controls transaction flow between sequence and driver

* **Monitor (`yapp_tx_monitor`)**

  * Observes interface activity
  * Provides transaction-level visibility

* **Agent (`yapp_tx_agent`)**

  * Encapsulates driver, sequencer, and monitor
  * Supports active/passive operation via `is_active`

* **Environment (`yapp_env`)**

  * Instantiates and manages the YAPP TX agent

---

### UVM Hierarchy (Lab 3)

```text
uvm_test_top (base_test)
 └── tb (router_tb)
     └── yapp (yapp_env)
         └── agent (yapp_tx_agent)
             ├── driver
             ├── monitor
             └── sequencer
```

---

### Transaction Flow

```text
Sequence → Sequencer → Driver → DUT
```

---

### Sequence Execution

* Configured default sequence (`yapp_5_packets`) using:

```systemverilog
uvm_config_wrapper::set(this,
  "tb.yapp.agent.sequencer.run_phase",
  "default_sequence",
  yapp_5_packets::get_type());
```

* Generates randomized YAPP packets during simulation

---

## 🧠 UVM Conceptual Analogy

| UVM Component | Real-World Analogy |
| ------------- | ------------------ |
| Testbench     | Laboratory 🧪      |
| Test          | Experiment         |
| UVC           | Equipment          |
| DUT           | Device under test  |

### Interpretation

* The **experiment (test)** controls execution
* The **laboratory (testbench)** provides infrastructure
* The **equipment (UVCs)** interact with the DUT
* The **device under test (DUT)** is the system being verified

---

## 🧪 Verification Methodology

The environment follows a modular UVM architecture:

* Sequence items for packet modeling
* Constrained-random stimulus generation
* Driver and monitor for DUT interaction
* Agent-based modular design
* TLM-based communication between components
* Scoreboard for functional checking
* Register modeling using UVM RAL

---

## 🚀 Features (Planned / In Progress)

* [x] YAPP packet modeling (Lab 1)
* [x] UVM testbench hierarchy (Lab 2)
* [x] YAPP UVC (driver, monitor, agent) (Lab 3)
* [ ] Factory-based configuration (Lab 4)
* [ ] Sequence library and stimulus generation (Lab 5)
* [ ] Virtual interface integration (Lab 6)
* [ ] Multi-UVC system integration (Lab 7)
* [ ] Virtual sequences (Lab 8)
* [ ] Scoreboard and TLM analysis (Lab 9)
* [ ] Register model integration (Lab 11)

---

## 🎯 Objectives

* Build a complete UVM verification environment from scratch
* Understand and apply industry-standard verification practices
* Develop reusable and scalable verification components
* Gain hands-on experience with constrained random verification and debugging

---

## 🛠️ Tools & Technologies

* SystemVerilog
* UVM (Universal Verification Methodology)
* Cadence Xcelium (`xrun`)

---

## 📚 Reference Materials

The following training documents are included in the `/docs` directory for reference:

* [UVM Training Lecture Notes](docs/UVMA_1_2_6.secured.lect.pdf)
* [UVM Lab Guide](docs/UVMA_1_2_6_rev2.lab.pdf)

These documents provide detailed guidance and background for the implementation of the YAPP UVM verification environment.
