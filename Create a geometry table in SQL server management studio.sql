--- Author: Ivy Araujo
--- Sept 2023
--- Create a geometry table to store spatial data in SQL management studio.
--- This query has 'id' field as the primary key
--- 'geom' field has an index to optimise data retrieval
--- Coordinate System: NZTM  (SRID = 2193)
--- Bounding Box needs to be added. Otehrwise, an error might occur when creating the spatial index.

-- Check if the table exists and drop it if it does
IF OBJECT_ID('Training_dbo.spatial_3waters', 'U') IS NOT NULL
    DROP TABLE [Training_dbo].[dbo].[spatial_3waters];

-- Create the spatial_3waters table in the Training_dbo schema with NZTM coordinate system
CREATE TABLE [Training_dbo].[dbo].[spatial_3waters]
(
    id INT,
    name VARCHAR(50),
    type VARCHAR(50),
    status VARCHAR(50),
    sap VARCHAR(80),
    wkt VARCHAR(MAX),
    geom GEOMETRY,

    CONSTRAINT PK_id_spatial3waters PRIMARY KEY (id)
);

-- Set the coordinate system to NZTM (SRID 2193)
DECLARE @nztm_srid INT = 2193;
UPDATE [Training_dbo].[dbo].[spatial_3waters]
SET geom = geometry::STGeomFromText(geom.STAsText(), @nztm_srid);

-- Create a spatial index on the geom column with the specified name
CREATE SPATIAL INDEX SI_geo_spatial3waters
ON Training_dbo.spatial_3waters (geom) USING GEOMETRY_AUTO_GRID
WITH (BOUNDING_BOX = (1100000, 4700000, 3250000, 6200000));