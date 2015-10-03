The CSDMS Software Stack
========================

Installation
------------

First install the Anaconda Python distribution.

``` bash
$ wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
$ bash Miniconda-latest-Linux-x86_64.sh -f -b -p <prefix>
$ export PATH=<prefix>/bin:$PATH
```

Now install the CSDMS software stack.

``` bash
$ conda create -n csdms python=2.7
$ source activate csdms
$ conda install -c https://conda.binstar.org/mcflugen csdms-stack
$ conda install ipython
```