# Requirements

- requirements.txt installable via pip, most installable via conda
- apt packages for Debian include python-dev fftw3-dev

Installation via conda on Debian

```
sudo apt-get install python-dev fftw3-dev
```

- in ifcb-analysis/python:

```
conda env create -f environment.yml
source activate ifcb-analysis
python setup.py install
```
