#!/bin/bash

exec > >(awk '{print strftime("%Y-%m-%d %H:%M:%S [1] "),$0; fflush();}')
exec 2> >(awk '{print strftime("%Y-%m-%d %H:%M:%S [2] "),$0; fflush();}' >&2)

starttime=$(date +%s)

echo "Downloading shapefiles..."

[ ! -d mapnik/data ] && mkdir mapnik/data
cd mapnik/data
rm -f water-polygons-generalized-3857.zip*
rm -f water-polygons-split-3857.zip*
wget --progress=dot:giga -O water-polygons-generalized-3857.zip http://data.openstreetmapdata.com/water-polygons-generalized-3857.zip
wget --progress=dot:giga -O water-polygons-split-3857.zip http://data.openstreetmapdata.com/water-polygons-split-3857.zip
unzip -o water-polygons-generalized-3857.zip
rm -f water-polygons-generalized-3857.zip
unzip -o water-polygons-split-3857.zip
rm -f water-polygons-split-3857.zip

endtime=$(date +%s)
echo "Done in $[${endtime}-${starttime}] seconds! All your Maps Belong to Us!"