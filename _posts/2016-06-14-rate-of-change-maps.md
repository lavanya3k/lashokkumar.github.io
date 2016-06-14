---
layout: post
title: Creating trend maps from spatio-temporal datasets
---

A common task in the analysis of remotely-sensed datasets is to calculate rates of change over time in, for example, ice motion or melt rates. But we don't just want to do this for a single point, instead we want to compute the trend at every single pixel inside our analysis area. Implemented inefficiently, our analysis could take several hours to run - but done right we can get results in seconds.


## Load in the data

In this example I'm simply going to consider changes in surface melt rates over the Greenland Ice Sheet. There's nothing novel about this analysis. Specifically, I'm working with daily outputs from the regional climate model *MAR*, which are provided in NetCDF format.

Let's use the power of xarray, which can do out-of-memory computation on large datasets through dask, to load in the surface melt rate time series from 2000 to present.

```python
import xarray as xr
mar = xr.open_mfdataset('/data/mar_data/*.nc')
```


## Do some data reduction 

We're only interested in looking at surface melting which occurs during June, July and August each year, so now let's calculate the annual surface melt rate which occurs at each point in the model domain during each June-July-August period.

```python
JJA_annual = mar['MELT'].where(mar['MELT']['TIME.season'] == 'JJA').groupby('TIME.year').mean(dim='TIME')
```

We've now reduced the data to a manageable size - one that should easily fit into memory on most computers - unlike the data set we started off with.

As we're only loading in 15 years in this example we can easily visualise the maps of JJA melting each year by producing a facet plot:

```python
JJA_annual.plot(col='year', col_wrap=5)
```


## Compute the trends

Now we're going to compute the temporal trend in melting at each point in the model domain using regression. We need to use numpy for this so first let's pull out a 3-dimensional numpy array of values from xarray together with the years, which will be our *x* coordinate for the regression calculation:

```python
vals = JJA_annual['CC'].values 
years = JJA_annual.year.values
```

For the next bit we are assuming that our `vals` variable has the dimensions `[TIME, Y, X]`, which is what xarray outputs for the particular data set that I am using. 

To compute the trend at each point in the model domain there are just a few steps, which are quick to run:

```python
# Reshape to an array with as many rows as years and as many columns as there are pixels
vals2 = vals.reshape(len(years), -1)
# Do a first-degree polyfit
regressions = np.polyfit(years, vals2, 1)
# Get the coefficients back
trends = regressions[0,:].reshape(vals.shape[1], vals.shape[2])
```

Regarding the speed of execution, the important thing to note here is that `np.polyfit` is incredibly rapid and will execute 38,000 calculations (the number of pixels in my dataset) within a couple of seconds on a reasonably powerful desktop machine. On the other hand, if we were iterating through the numpy arrange pixel-by-pixel in order to run a function such as `numpy.linregress` or `numpy.linalg.lstsq` then this procedure would take several hours.

You can visualise the `trends` output variable to see your trend map. You should also check out the goodness-of-fit using the second row of outputs in `regressions`. Do some nice plotting using basemap or cartopy to produce a map and then you're finished.