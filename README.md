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

   This configures tool paths, environment variables, and UVM settings.

2. Compile and run simulation:

   ```bash
   xrun -f run.f
   ```

   The `run.f` file specifies all source files, include directories, and simulation options.

### Notes

* Ensure the correct UVM version is set before running simulations.
* Simulation logs and outputs are generated during execution.

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

## 🧱 Project Structure

```
yapp_uvm_project/
├── rtl/        # YAPP router DUT
├── tb/         # UVM testbench
├── sv/         # UVM components (agents, sequences, env)
├── sim/        # Simulation outputs
├── scripts/    # Run scripts / automation
├── docs/       # Documentation
└── README.md
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

* [ ] YAPP packet modeling (Lab 1)
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

## 📚 Reference

Based on Cadence UVM training labs for YAPP router verification.
