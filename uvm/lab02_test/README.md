## 🧪 Lab 2: UVM Testbench Architecture (Completed)

This lab focuses on building the foundational UVM hierarchy by introducing the test and testbench (environment) structure.

### Key Concepts Implemented

* **UVM Test Creation**

  * Defined a base test (`base_test`) extending `uvm_test`
  * Implemented factory registration using `uvm_component_utils`
  * Created a derived test (`test2`) for extensibility

* **Testbench (Environment) Construction**

  * Implemented `router_tb` extending `uvm_env`
  * Instantiated the testbench inside the test using hierarchical construction
  * Established the parent-child relationship between test and environment

* **UVM Phase Mechanism**

  * Implemented `build_phase` for component creation
  * Observed top-down phase execution:

    * Test builds first
    * Testbench builds next
  * Used `end_of_elaboration_phase` to print UVM topology

### UVM Hierarchy (Lab 2)

```text
uvm_test_top (base_test)
 └── tb (router_tb)
```

### Execution Flow

```text
top module → run_test()
           ↓
       base_test.build_phase()
           ↓
       router_tb.build_phase()
```

### Key Observations

* The **test is the top-level UVM component**, not the testbench
* The test is responsible for constructing the testbench
* UVM phases execute in a **top-down hierarchical order**

---

## 🧠 UVM Conceptual Analogy

To better understand the architecture:

| UVM Component | Real-World Analogy |
| ------------- | ------------------ |
| Testbench     | Laboratory 🧪      |
| Test          | Experiment         |
| UVC           | Equipment          |
| DUT           | Device under test  |

### Interpretation

* The **laboratory (testbench)** provides the infrastructure
* The **experiment (test)** controls how the system is exercised
* The **equipment (UVCs)** interact with the DUT
* The **device under test (DUT)** is the system being verified

---

## 🔍 Implementation Highlights

* Hierarchical component creation using parent-child relationships
* Factory-based component registration for scalability
* Clear separation of control (test) and structure (environment)
* Topology visualization using `uvm_top.print_topology()`

---

## 🚀 Features Status Update

* [x] YAPP packet modeling (Lab 1)
* [x] UVM testbench hierarchy (Lab 2)
* [ ] YAPP UVC (driver, monitor, agent) (Lab 3)
* [ ] Factory-based configuration (Lab 4)
* [ ] Sequence library and stimulus generation (Lab 5)
* [ ] Virtual interface integration (Lab 6)
* [ ] Multi-UVC system integration (Lab 7)
* [ ] Virtual sequences (Lab 8)
* [ ] Scoreboard and TLM analysis (Lab 9)
* [ ] Register model integration (Lab 11)
