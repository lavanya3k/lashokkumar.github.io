---
layout: post
title: Sentinel-2 - Downloading, Conversion to L2A (reflectance) and reprojecting
---

Sentinel-2 is a European Space Agency (ESA) satellite observation program which provides multispectral imagery at 10-60 m resolution with a repeat time of ~5 days. 

## Downloading
The obvious way of downloading the data is to use the [Copernicus SciHub](https://scihub.copernicus.eu/). However, this method is very slow and often downloads time-out before they have finished.

If you are comfortable on the command line then there is a more efficient way to obtain Sentinel-2 data: [Sentinel-Hub](https://www.sentinel-hub.com/). This service is provided by a private company called Sinergise but, at the time of writing, is free of charge.

Use pip to install their [command-line interface and Python bindings](https://github.com/sentinel-hub/sentinelhub-py):

```bash
pip install sentinelhub
```

This package provides a variety of options for downloading Sentinel-2 data from Sentinel-Hub. We are interested in downloading data from their Amazon Web Services interface, so we will use the command line interface called [`sentinelhub.aws`](http://sentinelhub-py.readthedocs.io/en/latest/aws_cli.html).

There are a variety of ways to search for data based on their acquisition date and location. The simplest method, shown here, is to download an image of a single tile for a single date. The Sentinel-2 grid scheme can be found on the [ESA website](https://sentinel.esa.int/web/sentinel/missions/sentinel-2/data-products) as a [KML file](https://sentinel.esa.int/documents/247904/1955685/S2A_OPER_GIP_TILPAR_MPC__20151209T095117_V20150622T000000_21000101T000000_B00.kml).

This example downloads imagery acquired on 2016-06-01 in tile 22WEV:

```bash
sentinelhub.aws --tile T22WEV 2016-06-01 -e
```

The -e flag specifies download of the entire product. The product will be delivered in ESA's SAFE format, which means we can now convert it from top-of-atmosphere radiance (L1C) to bottom-of-atmosphere reflectance (L2A).


## Conversion to L2A (reflectance)

This requires the ESA Sen2Cor processor, which can be found as part of SNAP but is also provided as a standalone program. 

[Download](http://step.esa.int/main/third-party-plugins-2/sen2cor/) and install the processor, then process an image to L2A as follows:

```bash
~/Sen2Cor-2.4.0-Linux64/bin/L2A_Process S2A_OPER_PRD_MSIL1C_PDMC_20160607T020144_R125_V20160605T145923_20160605T145923.SAFE
```

This takes a while to complete but produces an L2A image in SAFE format.


## Reprojection

This requires GDAL >= 2.1 to be installed in your environment.

GDAL can convert any of the 10 m, 20 m or 60 m sub-datasets into a multi-band geotiff.

In this example, reproject the 10 m subdataset to a North Polar Stereographic (EPSG:3413) geoTIFF:

```bash
gdalwarp -t_srs EPSG:3413 SENTINEL2_L2A:S2A_USER_PRD_MSIL2A_PDMC_20160607T020144_R125_V20160605T145923_20160605T145923.SAFE/S2A_USER_MTD_SAFL2A_PDMC_20160607T020144_R125_V20160605T145923_20160605T145923.xml:10m:EPSG_32622 S2A_USER_MTD_SAFL2A_PDMC_20160607T020144_R125_V20160605T145923_20160605T145923_10m_EPSG3413.tif
```








