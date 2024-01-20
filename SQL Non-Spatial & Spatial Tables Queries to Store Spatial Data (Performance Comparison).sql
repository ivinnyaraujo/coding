--- Author: Ivy Araujo

---     SQL Non-Spatial & Spatial Tables. Comparing size and run time.
--- (a) Non Spatial table size: 227.898 MB and Run Time = 11s
--- (b) Spatial table size: 346.680 MB and Run Time = 11s
--- (c) Dataset for testing: ~1.6 million rows

SELECT [name]
      ,[datasetname]
      ,[latitude]
      ,[longitude]
 FROM [Training_dbo].[dbo].[Dataset_NonSpatial]


--- 1) Non-Spatial Table: Calculate geospatial data on the fly from a Non Spatial table that contain Latitude and Longitude attributes. The query below des not add
---    add a permanent GEOM attribute type to the table. However, this will increase the run time in 3s (total run time: 14s).
---    This technique would give us all asset types as points, not the original geometry

SELECT [name]
      ,[datasetname]
      ,[latitude]
      ,[longitude]
      ,geometry::STPointFromText('POINT(' + CAST([longitude] AS VARCHAR(20)) 
              + ' ' + CAST([latitude] AS VARCHAR(20)) + ')', 4326) 
              AS LocationGeometry
  FROM [Training_dbo].[dbo].[Dataset_NonSpatial]

--- 2) If add WKT values as a new attribute to the non-spatial table, its size would increase ~38% (from 227.898 MB to 314.898 MB), which is similar to the geometry table size (346.680 MB).
---   The total run time increases from 11s to 14s.

--- 3) For Non Spatial Table with Latitude and Longitude attributes + WKT attribute, a geometry attribute can be derivated using the geometry::STGeomFromText method to create the geometry field 
---    from the WKT values. This gives the flexibility to use lat/long for points only, however, it would allow to derivate the geometry type from WKT if required. 
---    However, the run time increases significantly (from 14s to 1min08s).

SELECT 
    [name],
    [datasetname],
    [latitude],
    [longitude],
    [wkt],
    geometry::STGeomFromText([wkt], 0) AS geom
FROM [Training_dbo].[dbo].[dataset_nonspatial_wkt];

--- OBS: Even though the geometry table (b) occupies more space in relation to the non-spatial lat/long + WKT table (3), the run time for the geometry table is faster than creating the geometry in the flight from WKT values.

--- 4) Extracting centroid values from geometries: SQL Server's spatial functionality STCentroid() is primarily used for calculating the centroid of polygonal geometries, such as polygons and multipolygons.
---    It is not used for calculating the centroid of linear geometries like lines or multilines. 

--- 5) Extracting X and Y coordinates separately using .STCentroid().STX and .STCentroid().STY. 
---    Also getting the full centroid geometry using .STCentroid(). This allows to work with the centroid coordinates in different ways based on the project needs
---    However, the query below will return centroid values for polygons only. Points and Lines will be Null.
 
SELECT
    [name],
    [datasetname],
    CASE
        WHEN [geom].STIsValid() = 1 THEN
            [geom].STCentroid()
        ELSE
            [geom].MakeValid().STCentroid() --- MakeValid() method to convert the invalid geometries to valid ones before calculating the centroid.
    END AS FullCentroid,
    CASE
        WHEN [geom].STIsValid() = 1 THEN
            [geom].STCentroid().STX
        ELSE
            [geom].MakeValid().STCentroid().STX --- MakeValid() method to convert the invalid geometries to valid ones before calculating the centroid.
    END AS CentroidX,
    CASE
        WHEN [geom].STIsValid() = 1 THEN
            [geom].STCentroid().STY
        ELSE
            [geom].MakeValid().STCentroid().STY --- MakeValid() method to convert the invalid geometries to valid ones before calculating the centroid.
    END AS CentroidY
FROM [Training_dbo].[dbo].[geomcentroid]


--- 6) To retrieve center points for lines and points as well, all three geometry types (lines, points, and polygons) needs to be handled.
---    For lines and points, use the existing geometry as the center point for points and the midpoint for lines. Total run time = 17s.

SELECT
    [name],
    [datasetname],
    CASE
        WHEN [geom].STIsValid() = 1 AND [geom].STGeometryType() = 'POLYGON' THEN
            [geom].STCentroid()
        ELSE
            [geom] -- For lines and points, use the existing geometry as the center
    END AS CenterPoint
FROM [Training_dbo].[dbo].[dataset_spatial_geomcentroid]

--- 7) To retrieve X and Y values as center points in different columns, see query below. Run time increases from 17s to 51s.

SELECT
    [name],
    [datasetname],
    CASE
        WHEN [geom].STIsValid() = 1 AND [geom].STGeometryType() = 'POLYGON' THEN
            [geom].STCentroid()
        ELSE
            [geom] -- For lines and points, use the existing geometry as the center
    END AS CenterPoint,
    CASE
        WHEN [geom].STIsValid() = 1 AND [geom].STGeometryType() = 'POLYGON' THEN
            [geom].STCentroid().STX
        ELSE
            [geom].STX -- X-coordinate for lines and points
    END AS CenterPointX,
    CASE
        WHEN [geom].STIsValid() = 1 AND [geom].STGeometryType() = 'POLYGON' THEN
            [geom].STCentroid().STY
        ELSE
            [geom].STY -- Y-coordinate for lines and points
    END AS CenterPointY
FROM [Training_dbo].[dbo].[dataset_spatial_latlong]
