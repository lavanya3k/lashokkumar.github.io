---
layout: post
title: Query USGS satellite data footprints which fall within a specified area using GeoPandas
---

Whilst USGS EarthExplorer provides a basic ability to upload a bounding shapefile with up to 30 points, the size of some search areas such as the Greenland Ice Sheet make it simpler to download metadata of all tiles over a simple Greenland-wide rectangle first. These metadata can be easily queried using GeoPandas to find which tile footprints fall within a more detailed shapefile of your choosing.


## Download footprints shapefile from USGS Earth Explorer

Carry out a search with the search criteria that you desire. Once on the Results tab, select 'Click here to export your results'. Select Export Type "Non-Limited Results" and Format "Shapefile". Download the file from the link that EarthExplorer will email to you.


## Create ice mask to search within

If you do not already have a mask area polygon to search within, these instructions will help you to produce one using the Greenland Ice Mapping Project ice mask as an example.

Download 90 m GIMP ice mask from the [Byrd Glacier Dynamics Group](https://bpcrc.osu.edu/gdg/data/icemask). 
Convert to 0.1 degrees resolution (i.e. simplified) and WGS84:

	   gdalwarp -tr 0.1 0.1 -t_srs "EPSG:4326" gimp90m.tif gimp0.1deg.tif

Create polygons from the WGS84 ice mask and save to shapefile:

	   gdal_polygonize.py gimp1km.tif -f "ESRI Shapefile" GimpIceMask_1km

Open the shapefile and cull out all polygons except the main Greenland Ice Sheet one, then save back to a new shapefile. It's probably easiest to do this based on area initially:
      
```python
import geopandas
gimp = geopandas.read_file('GimpIceMask_1km.shp')
gimp[gimp.area > 500]
```

For Greenland, two polygons get returned - in this case the correct polygon has the ID number 6641.
        
```python
outline = gimp[gimp.index == 6641]
```

Save the outline to a new shapefile.

```python
outline.save_file('gris_outline.shp')
```


## Find satellite footprints within the ice sheet mask

Assuming that you have installed GeoPandas and its dependencies without problems then this task is very straightforward.

First load in the files:

```python
import geopandas
outline = geopandas.read_file('gris_outline.shp')
footprints = geopandas.read_file('EarthExplorer_footprints.shp')
```

Get the Shapely geometry of the mask area to search within. If you generated the mask according to the instructions above then there will be only one item in the shapefile and it can therefore be indexed directly:

```python
mask = outline.ix[0].geometry
```

Now identify the footprints which fall within the ice area's geometry and save True/False labels to a new column in footprints called `on_ice`. 

```python
footprints = footprints.assign(on_ice=footprints.within(mask))
```

Finally, generate a list of scene identifiers to save to a text file:

```python
tile_ids = footprints[footprints.on_ice == True]['ENTITY_ID']
tile_ids.to_csv('to_download.txt', index=False)
```

Note that you may need to substitute `ENTITY_ID` for the name of the scene identifier in the particular product that you are interested in.


## Download the data

Go to the [USGS EarthExplorer File List page](http://earthexplorer.usgs.gov/filelist), select your dataset and the 'Scene List' file format then upload your text file of scene IDs. Either order the data for bulk download or download them all immediately depending on your preference.

