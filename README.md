The CSDMS Software Stack
========================

Installation (Mac)
------------------

Create a new folder to hold the Python installation, will contain the
CSDMS stack, and grab the Miniconda installer.

``` bash
$ mkdir py-csdms
$ cd py-csdms
$ curl http://repo.continuum.io/miniconda/Miniconda-latest-MacOSX-x86_64.sh -o miniconda.sh
```

Install a fresh Python and add it to your path,
``` bash
$ bash miniconda.sh -f -b -p $(pwd)/conda
$ export PATH=$(pwd)/conda/bin:$PATH
```
Remember this only changes your path for this session. You will have to
either add this Python to your `PATH` whenever you start a new shell or add
it to your startup rc file (`.bashrc`, or `.bash_profile`, etc.).

Install CSDMS packages into this new Python,
``` bash
$ conda install csdms-rafem csdms-cem -c csdms
```

For Linux, the link to the miniconda installer is: http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh

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
