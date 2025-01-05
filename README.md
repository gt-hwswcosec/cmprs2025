Artifacts for the foundational paper on CMPRs "Scalable Nonlinear Sequence Generation using Composite Mersenne Product Registers", published in the IACR CiC journal.

In this repository, we include the version of the Product Registers Library used to conduct experiments for the stream ciphers above journal paper, along with the source code used in our experiments.

The library is lacking in documentation and missing guard rails, but we hope to improve this in the future. We have commented the library and code in this repository to the best of our ability.

**Library Installation**

The library is contained in the `ProductRegisters` directory. Dependencies are `memoization numba numpy galois python-sat`. The library is compatible with Python 3.12 and newer.

We have also included a `requirements.txt` file, which can be called using `pip install -r requirements.txt`. Depending on your development environment, the package versions in `requirements.txt` may or may not be suitable.
