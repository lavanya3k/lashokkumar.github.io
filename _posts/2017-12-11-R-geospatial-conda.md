---
layout: post
title: Installing R with geospatial packages using Conda
---

I recently needed to install a R environment with several geospatial dependencies. There were conflicts with the base operating system's configuration of geospatial libraries, so I used the environment manager [Miniconda](https://conda.io/miniconda.html) in order to install R into a clean, completely separated environment.

The procedure is as follows:

```bash
# Create a new conda environment named r-gis
conda create -n r-gis
# Activate it
source activate r-gis
# Install R and geospatial dependencies
conda install -c conda-forge r-essentials geos r-rgeos r-rgdal
```

Note that it is important to install all the packages from the `conda-forge` channel in order for the dependencies to be resolved. Note also that the package  `geos` has to be installed as well as `r-rgeos`. This is because `r-rgeos` only provides an interface to an existing `geos` library installation.

With the main dependencies installed via conda, you can now start an R shell an install any remaining geospatial dependencies such as `raster` and `GISTools`:

```R
install.packages('raster')
install.packages('GISTools', dep=T)
```




