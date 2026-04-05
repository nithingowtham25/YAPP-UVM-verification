# Lab 3: YAPP UVC (Transmit Agent)

## 📌 Overview

This lab focuses on building a reusable UVM Verification Component (UVC) for the YAPP protocol. The implementation includes the creation of driver, sequencer, monitor, agent, and environment to model the transmit (TX) side of the YAPP router.

---

## 🎯 Objectives

* Build a complete UVM agent (UVC) from scratch
* Understand communication between sequencer and driver
* Implement component hierarchy and connectivity
* Execute sequences to generate transaction-level stimulus

---

## 🧱 Components Implemented

### 1️⃣ Driver (`yapp_tx_driver`)

* Extends `uvm_driver #(yapp_packet)`
* Receives transactions from sequencer
* Sends packets to DUT (currently prints packets)

**Key Features:**

* Uses `seq_item_port.get_next_item()` and `item_done()`
* Implements `send_to_dut()` task
* Displays packet using `sprint()`

---

### 2️⃣ Sequencer (`yapp_tx_sequencer`)

* Extends `uvm_sequencer #(yapp_packet)`
* Controls flow of sequence items to driver

---

### 3️⃣ Monitor (`yapp_tx_monitor`)

* Extends `uvm_monitor`
* Observes DUT interface (currently prints activity)

---

### 4️⃣ Agent (`yapp_tx_agent`)

* Extends `uvm_agent`
* Encapsulates:

  * Driver
  * Sequencer
  * Monitor

**Key Features:**

* Uses `is_active` flag:

  * `UVM_ACTIVE` → driver + sequencer + monitor
  * `UVM_PASSIVE` → monitor only
* Connects driver and sequencer in `connect_phase`

---

### 5️⃣ Environment (`yapp_env`)

* Extends `uvm_env`
* Instantiates the YAPP TX agent

---

## 🔄 UVM Hierarchy

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

## ⚙️ Phase Execution Flow

```text
run_test()
   ↓
test.build_phase()
   ↓
env.build_phase()
   ↓
agent.build_phase()
   ↓
driver / monitor / sequencer
```

---

## 🔗 Component Connectivity

* Sequencer → Driver

  * Connected using:

    ```systemverilog
    driver.seq_item_port.connect(sequencer.seq_item_export);
    ```

---

## 🧪 Sequence Execution

* Used pre-defined sequence: `yapp_5_packets`
* Configured using:

```systemverilog
uvm_config_wrapper::set(this,
  "tb.yapp.agent.sequencer.run_phase",
  "default_sequence",
  yapp_5_packets::get_type());
```

---

## ▶️ How to Run

```bash
source setup.bash
cd uvm/lab03_uvc
xrun -f run.f
```

---

## 📊 Expected Output

* UVM topology print
* Driver prints randomized YAPP packets
* Multiple packets generated per simulation

---

## 🧠 Key Concepts Learned

* UVC (UVM Verification Component) design
* Separation of stimulus generation and execution
* Transaction flow:

  ```text
  Sequence → Sequencer → Driver → DUT
  ```
* Active vs Passive agent configuration
* Phase-based construction and connectivity

---

## 🧠 Conceptual Analogy

| UVM Component | Real-World Analogy |
| ------------- | ------------------ |
| Testbench     | Laboratory 🧪      |
| Test          | Experiment         |
| UVC (Agent)   | Equipment          |
| Driver        | Operator           |
| Sequencer     | Control system     |
| Monitor       | Observer           |
| DUT           | Device under test  |

---

## 🔍 Implementation Highlights

* Modular UVC design for reusability
* Factory-based component creation
* Clean separation of responsibilities across components
* Scalable architecture for future labs

---

## ✅ Outcome

* Successfully built a complete YAPP TX UVC
* Verified component hierarchy and connectivity
* Executed sequences to generate and observe packet transactions
* Established foundation for full system-level verification

---
