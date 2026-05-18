# Lab 4: Factory Overrides and Configuration Database

## 📌 Overview

This lab introduces two of the most powerful and fundamental concepts in UVM: **factory overrides** and the **configuration database (config_db)**. These mechanisms enable dynamic control over testbench behavior without modifying existing code.

---

## 🎯 Objectives

* Understand and apply factory overrides
* Use the UVM configuration database to control component behavior
* Dynamically modify testbench functionality through test-level control
* Learn best practices for scalable and reusable verification environments

---

## 🧱 Concepts Implemented

### 1️⃣ Factory Override

Factory override allows replacing a base class with a derived class **at runtime**, without modifying the original code.

#### Implementation

```systemverilog id="3u6jzx"
set_type_override_by_type(
  yapp_packet::get_type(),
  short_yapp_packet::get_type()
);
```

#### Behavior

* All `yapp_packet` creations are replaced with `short_yapp_packet`
* Sequences remain unchanged
* Test behavior is modified dynamically

---

### 2️⃣ Configuration Database (config_db)

The configuration database is used to pass configuration settings from higher-level components (like tests) to lower-level components (like agents).

#### Example: Setting Agent Mode

```systemverilog id="1g3t6d"
uvm_config_int::set(this, "tb.yapp.agent", "is_active", UVM_PASSIVE);
```

#### Behavior

* Sets the agent to **PASSIVE mode**
* Disables:

  * Driver
  * Sequencer
* Keeps:

  * Monitor active

---

### 3️⃣ Default Sequence Configuration

Used to automatically start a sequence during the `run_phase`.

```systemverilog id="j4zq8y"
uvm_config_wrapper::set(
  this,
  "tb.yapp.agent.sequencer.run_phase",
  "default_sequence",
  yapp_5_packets::get_type()
);
```

#### Behavior

* Automatically runs `yapp_5_packets` sequence
* No explicit `start()` call required

---

## 🔄 Execution Flow

```text id="p9xk3d"
Test starts
   ↓
Factory override applied
   ↓
Config DB settings applied
   ↓
Components built
   ↓
Sequence starts automatically
   ↓
Packets generated and processed
```

---

## 🧪 Tests Implemented

### ✅ `short_packet_test`

* Uses factory override
* Replaces `yapp_packet` with `short_yapp_packet`
* Generates shorter packets dynamically

---

### ✅ `set_config_test`

* Uses config_db
* Sets agent to `UVM_PASSIVE`
* Only monitor is active (no stimulus generation)

---

## 🧠 Key Concepts Learned

* Factory enables **dynamic type substitution**
* Config DB enables **hierarchical configuration**
* Tests control behavior without modifying components
* Separation of **structure vs behavior**

---

## ⚠️ Common Pitfalls

* Factory override must be set **before `super.build_phase()`**
* Incorrect component path in config_db leads to no effect
* Every `set()` should ideally have a corresponding `get()`
* Typos in field names (e.g., `"recording_detail"`) cause silent issues

---

## ▶️ How to Run

```bash id="z2vql1"
source setup.bash
cd uvm/lab04_factory
xrun -f run.f
```

### Run specific tests:

```bash id="3b3x7g"
+UVM_TESTNAME=short_packet_test
+UVM_TESTNAME=set_config_test
```

---

## 📊 Expected Results

* **short_packet_test**

  * Packets generated with modified constraints
  * Same sequence, different behavior

* **set_config_test**

  * No packets driven
  * Monitor activity only
  * Agent operates in passive mode

---

## 🧠 Conceptual Understanding

| Concept   | Role                               |
| --------- | ---------------------------------- |
| Factory   | Controls **what gets created**     |
| Config DB | Controls **how components behave** |

---

## 🔍 Implementation Highlights

* Non-intrusive behavior modification using factory
* Hierarchical configuration using config_db
* Clean separation between test logic and component implementation
* Improved reusability and scalability of UVM environment

---

## ✅ Outcome

* Successfully implemented factory overrides and config_db usage
* Demonstrated dynamic behavior control across multiple tests
* Established foundation for advanced UVM features in future labs

---
