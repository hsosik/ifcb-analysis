# Overview

This module provides image processing capabilities for Imaging FlowCytobot data.
It performs image segmentation and feature extraction.

This Python implementation produces identical results to the MATLAB implementation
provided elsewhere in this repository.

## Installation via conda on Debian

```
sudo apt-get install python-dev fftw3-dev
```

In `ifcb-analysis/python`:

```
conda env create -f environment.yml
source activate ifcb-analysis
python setup.py install
```

For batch processing, this module also requires pyifcb. See the following repository for details on how to install pyifcb:

https://github.com/joefutrelle/pyifcb
