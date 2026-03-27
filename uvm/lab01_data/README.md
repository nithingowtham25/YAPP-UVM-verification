# Lab 1: YAPP Packet Modeling

## 📌 Overview

This lab focuses on developing a transaction-level model of the YAPP (Yet Another Packet Protocol) packet using UVM. The packet is implemented as a `uvm_sequence_item` with constrained randomization and automatic parity generation.

---

## 🎯 Objectives

* Model a protocol packet using SystemVerilog and UVM
* Apply constrained randomization for realistic stimulus generation
* Implement parity calculation logic
* Enable UVM automation for debugging and verification

---

## 📦 Packet Structure

Each YAPP packet consists of:

* **Header**

  * 2-bit address (valid: 0–2)
  * 6-bit length (1 to 63 bytes)

* **Payload**

  * Dynamic array of bytes
  * Size equals the length field

* **Parity**

  * Even parity computed over header and payload

---

## 🧠 Key Concepts

### Constrained Randomization

* Payload size tied to length field
* Address restricted to valid values
* Packet delay randomized within bounds
* Weighted distribution for good vs bad parity

---

### Parity Generation

* Parity computed using bitwise XOR across:

  * Header (`{length, addr}`)
  * Payload bytes

* Supports:

  * **GOOD_PARITY** → correct parity
  * **BAD_PARITY** → injected error

---

### UVM Automation

* Used field macros for:

  * `print()`
  * `copy()`
  * `compare()`
  * `pack()`

* Excluded non-functional fields from comparison

---

## 🔧 Implementation Highlights

* `post_randomize()` used to automatically compute parity
* Dynamic array constraints ensure realistic packet structure
* Clean separation of data fields and control knobs

---

## ▶️ How to Run

```bash
source setup.bash
cd uvm/lab01_data
xrun -f run.f
```

---

## 📊 Execution Flow

```text
Create Packet → Randomize → Apply Constraints → Compute Parity → Print
```

---

## ✅ Outcome

* Successfully modeled a protocol packet using UVM
* Verified constraint behavior and parity correctness
* Established foundation for transaction-level verification
