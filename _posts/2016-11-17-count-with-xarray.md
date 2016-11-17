---
layout: post
title: Counting occurences of phenomena in xarray Datasets using dask
---

Utilising daily satellite data, I'm interesting in counting the number of days each year where each pixel fulfills certain criteria, for instance the number of cloudy days at a pixel each year.

The dataset is too big to fit in memory and so it needs to be crunched using dask, by specifying the ['chunks'](http://xray.readthedocs.io/en/stable/dask.html) when opening up the dataset:

```python
import xarray as xr
data = xr.open_mfdataset('/path/to/data/*.nc', chunks={'TIME':5})
```

In my case I'm loading up a dataset of MODIS MOD10A1 daily surface albedo data that looks like the following:

```python
In [22]: data
Out[22]: 
<xarray.Dataset>
Dimensions:                 (TIME: 3111, X: 542, Y: 1659)
Coordinates:
  * Y                       (Y) float64 -9.49e+05 -9.484e+05 -9.478e+05 ...
  * X                       (X) float64 -5.867e+05 -5.861e+05 -5.855e+05 ...
  * TIME                    (TIME) datetime64[ns] 2000-04-01 2000-04-02 ...
Data variables:
    Snow_Albedo_Daily_Tile  (TIME, Y, X) float64 139.0 139.0 139.0 139.0 ...
```

The values in `Snow_Albedo_Daily_Tile` scale from `0` to `100` for albedo. Clouds have a value of `150`. 

A sensible way to count the annual occurence of cloudy days might look like this:

```python
cloud_count = data.Snow_Albedo_Daily_Tile
                .where(data.Snow_Albedo_Daily_Tile == 150)
                .notnull()
                .resample('AS', 'TIME', how='sum') 
```

However, there's a problem with this strategy. The addition of `notnull()` (to change the values of `150` to `True`, enabling the instances to be summed using the `resample` `sum` operation) causes xarray to greedily load the entire dataset into memory - it ignores the dask chunking. this particular dataset takes whatever remains of the 20 Gb of RAM allocated to the virtual machine and then crashes the IPython session. 

The solution is to use combine `groupby()` and `count()` instead:

```python
cloud_count = data.Snow_Albedo_Daily_Tile \
                .where(data.Snow_Albedo_Daily_Tile == 150) \
                .groupby('TIME.year') \
                .count(dim='TIME') 
```             

This yields a new representation of the dataset. Because dask is lazy this new representation is not evaluated until an operation such as plotting is requested, and when it is evalulated this occurs chunk-by-chunk:

```python
# Produce a facet plot
cloud_count.sel(year=slice(2010,2016)).plot(col='year')
```

