# Lab 6: Virtual Interface Integration

## 📌 Overview

This lab introduces virtual interface integration in UVM, enabling communication between class-based verification components and the DUT’s SystemVerilog interfaces.

The lab connects the YAPP transmit UVC to the DUT interface using the UVM configuration database and virtual interfaces, establishing the foundation for real signal-level DUT interaction.

---

## 🎯 Objectives

* Understand SystemVerilog interfaces
* Connect class-based UVM components to DUT signals
* Use virtual interfaces inside UVM components
* Configure interfaces using the UVM config database
* Drive packet transactions onto DUT-level signals

---

## 🧱 Concepts Implemented

### 1️⃣ SystemVerilog Interface Integration

Connected the DUT to a SystemVerilog interface containing:

* Clock
* Reset
* Packet input signals
* Handshake/control signals

#### Behavior

* Simplifies DUT signal management
* Groups related protocol signals together
* Enables clean DUT-to-UVM connectivity

---

### 2️⃣ Virtual Interface Usage

Added virtual interface handles inside UVM components.

#### Implementation

```systemverilog id="4x9m1s"
virtual yapp_if vif;
```

#### Behavior

* Allows class-based components to access DUT signals
* Bridges static RTL connections with dynamic UVM classes

---

### 3️⃣ Config DB Interface Passing

Passed the virtual interface through the UVM configuration database.

#### Implementation

```systemverilog id="5w8r4t"
uvm_config_db #(virtual yapp_if)::set(
  null,
  "*",
  "vif",
  yapp_if_inst
);
```

#### Behavior

* Shares the interface handle across hierarchy
* Allows driver and monitor access to DUT signals

---

### 4️⃣ Driver Signal-Level Communication

Updated the driver to drive packet data onto interface signals.

#### Behavior

* Converts packet transactions into pin-level activity
* Synchronizes transactions using DUT clocking

---

### 5️⃣ Monitor Interface Observation

Updated the monitor to observe DUT interface activity.

#### Behavior

* Samples DUT transactions from interface signals
* Converts pin activity back into transaction-level information

---

## 🔄 Execution Flow

```text id="d0pxs8"
Test starts
   ↓
Virtual interface configured
   ↓
Driver retrieves vif handle
   ↓
Sequence generates packet
   ↓
Driver drives DUT signals
   ↓
Monitor observes interface activity
```

---

## 🧪 Components Updated

### ✅ `yapp_if`

* Added YAPP protocol interface
* Encapsulates DUT communication signals

---

### ✅ `yapp_tx_driver`

* Retrieves virtual interface using config DB
* Drives packet data onto DUT signals

---

### ✅ `yapp_tx_monitor`

* Accesses DUT signals through virtual interface
* Monitors packet activity

---

### ✅ `hw_top`

* Instantiates DUT and interface
* Connects interface to DUT ports
* Publishes virtual interface into config DB

---

## 🧠 Key Concepts Learned

* Virtual interfaces connect UVM classes to RTL signals
* Config DB distributes interface handles across hierarchy
* Interfaces simplify protocol signal management
* Drivers and monitors communicate with DUT through interfaces

---

## ⚠️ Common Pitfalls

* Forgetting to set the virtual interface in config DB
* Incorrect config DB path causing `get()` failures
* Accessing virtual interface before retrieval
* Interface signal mismatches between DUT and UVC

---

## ▶️ How to Run

```bash id="r8a6qe"
source setup.bash
cd uvm/lab06_vif
xrun -f run.f
```

### Run specific tests:

```bash id="pnj7if"
+UVM_TESTNAME=short_yapp_012_seq
```

---

## 📊 Expected Results

* Driver successfully drives DUT signals
* Monitor observes packet transactions through interface
* Virtual interface retrieved successfully from config DB
* DUT communication occurs through real signal-level interaction

---

## 🧠 Conceptual Understanding

| Concept           | Role                                      |
| ----------------- | ----------------------------------------- |
| Interface         | Groups DUT protocol signals               |
| Virtual Interface | Gives UVM classes access to RTL signals   |
| Config DB         | Shares interface handles across hierarchy |
| Driver            | Drives DUT pin-level activity             |
| Monitor           | Observes DUT signal behavior              |

---

## 🔍 Implementation Highlights

* Clean DUT-to-UVM connectivity using interfaces
* Virtual interface integration through config DB
* Signal-level packet driving and monitoring
* Separation of transaction-level and RTL-level communication

---

## ✅ Outcome

* Successfully integrated virtual interfaces into the YAPP UVM environment
* Enabled real DUT signal interaction from UVM components
* Connected class-based verification components with RTL interfaces
* Established the foundation for advanced DUT-level verification

---
