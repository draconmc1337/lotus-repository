# Lotus Repository

This repository contains the official package scripts for **Lotus Linux**.

Packages are defined using simple **PKGBUILD-style build scripts** used by the **lpm (Lazy Package Manager)** to fetch sources, resolve dependencies, build software, and install it into the system.

All packages are built from source.

---

# Repository Layout

The repository is organized into three main sections:

```text
lotus-repository/
├── base/
├── extra/
└── lotus/
```

### base

Core packages required for the system to function.

These typically include the toolchain and essential system components such as:

* glibc
* gcc
* core utilities
* init system
* build tools

Packages in this section are considered **critical** and should not be removed from a running system.

---

### extra

Additional packages that are not required for the base system but are commonly used.

Examples include:

* libraries
* development tools
* system utilities

---

### lotus

Packages specific to **Lotus Linux** itself.

This section may include:

* templates
* system configuration packages
* Lotus-specific tools

---

# Package Format

Packages are defined using simple PKGBUILD-style scripts:

```
pkgbuild_<name>
```

Each script describes:

* package name and version
* source archives
* dependencies
* build instructions
* installation steps

The **lpm** package manager automatically searches for packages in the following order:

```
base → extra → lotus
```

---

# Philosophy

The Lotus repository follows the same design philosophy as the package manager itself:

**SIMF — Simple Is More Functional**

The repository structure is intentionally minimal and avoids unnecessary complexity. Packages are simple build scripts that clearly describe how software is built and installed.

---

# License

Open source. See the LICENSE file for details.
