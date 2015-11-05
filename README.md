The CSDMS Software Stack
========================

Installation
------------

Install the Anaconda Python distribution.
``` bash
$ wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
$ bash Miniconda-latest-Linux-x86_64.sh -f -b -p <prefix>
$ export PATH=<prefix>/bin:$PATH
```

Install the CSDMS software stack.
``` bash
$ conda create -n csdms python=2.7
$ source activate csdms
$ conda install -c https://conda.anaconda.org/csdms csdms
$ conda install ipython
```

For Macs, the link to the miniconda installer is: http://repo.continuum.io/miniconda/Miniconda-latest-MacOSX-x86_64.sh

The full archive is at: http://repo.continuum.io/miniconda/index.html

To Build the Stack
------------------

Get a fresh Python installation.
``` bash
$ wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
$ bash Miniconda-latest-Linux-x86_64.sh -f -b -p <prefix>
$ export PATH=<prefix>/bin:$PATH
```

Run the build script.
``` bash
$ cd conda-recipes
$ bash ./build-stack.sh # Go for coffee.
```

You will need a fortran compiler to build everything. On Mac, I use the fortran compilers here: https://gcc.gnu.org/wiki/GFortranBinaries. These are installed under ``/usr/local/gfortran`` so make sure that is in your path when building.
