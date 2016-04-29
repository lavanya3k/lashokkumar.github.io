---
layout: post
title: Disabling the GDAL command line utilities which come with Anaconda GDAL
---

I could not get the Anaconda version of GDAL (http://jgomezdans.github.io/new-version-of-gdal-packages-with-hdf-for-anaconda.html) to work with HDF4 datasets but need to retain the Anaconda for Python-GDAL functionality (excepting HDF4). This means that the GDAL command-line utilities which are on the PATH by default don't work with GDAL. However, the version of GDAL already installed in the virtual machine has the HDF4 bindings enabled:

    gdalinfo --formats | grep HDF

To disable the Anaconda-provided GDAL command line binaries go to /home/<user>/miniconda3/bin and run `chmod u-x *gdal*`. 

Check that system-wide binaries now being used:

    which gdalinfo

Python-GDAL will continue to use the Anaconda installation so HDF4 datasets cannot be loaded through the Python-GDAL bindings.

One day I'll figure out how to get the HDF4 bindings for Anaconda Python working on my machine. 

In the meantime if an existing Python script relies on GDAL-Python to open HDF4 and doesn't need any special Anaconda packages then just run the system version of Python instead:
    
    /usr/bin/ipython <myfile>.py
