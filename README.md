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

2. Navigate to the Lab 1 directory:

   ```bash
   cd uvm/lab01_data
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

* **Parameterized Packet Fields**

  * Address and length fields forming the packet header
  * Dynamic payload array constrained to match packet length
  * Parity field computed automatically after randomization

* **Constrained Randomization**

  * Payload size tied to length field
  * Address restricted to valid values (0–2)
  * Controlled distribution of good vs bad parity packets

* **Parity Generation**

  * Implemented using bitwise XOR across header and payload
  * Supports both valid and intentionally corrupted packets for verification

* **UVM Automation**

  * Used field macros for print, copy, compare, and pack operations
  * Excluded non-functional fields (e.g., packet delay) from comparisons

### Implementation Highlights

* Automatic parity computation using `post_randomize()`
* Error injection using parity control knob
* Dynamic array constraints for realistic packet modeling

### Execution Flow

```text
Create Packet → Randomize → Apply Constraints → Compute Parity → Print
```

---

## 🧪 Verification Methodology

The environment follows a modular UVM architecture:

* Sequence items for packet modeling
* Constrained-random stimulus generation
* Driver and monitor for DUT interaction
* Agent-based modular design
* Scoreboard for functional checking
* TLM-based communication between components
* Register modeling using UVM RAL

---

## 🚀 Features (Planned / In Progress)

* [x] YAPP packet modeling (Lab 1)
* [ ] UVM testbench hierarchy (Lab 2)
* [ ] YAPP UVC (driver, monitor, agent) (Lab 3)
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

