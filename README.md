# Lotus Repository

This repository contains the official package build scripts for **Lotus Linux**.

Packages are defined using simple PKGBUILD-style scripts used by the **lpm (Lazy Package Manager)** to fetch sources, resolve dependencies, build software, and install it into the system.

All packages are built from source.

---

# Package Manager

Lotus Linux uses **lpm (Lazy Package Manager)**.

Source code:

https://github.com/draconmc1337/lpm

lpm is responsible for:

* resolving dependencies
* downloading sources
* building packages from source
* installing files into the system

---

# Repository Layout

```text
lotus-repository/
├── base/
├── extra/
└── lotus/
```

### base

Core packages required for the system to function.

Examples include:

* glibc
* gcc
* init system
* build tools

---

### extra

Additional packages that are not required for the base system but are commonly used.

---

### lotus

Packages specific to **Lotus Linux**.

---

# Package Lookup Order

lpm searches packages in this order:

```
base → extra → lotus
```
