Abstract
	Ocean color products derived from  the Ocean Colour Land Imager (OLCI) aboard the European Space Agency's Sentinel-3 satellite. Products are calculated from Remote Sensing Reflectance (Rrs) and/or top of atmosphere reflectance corrected for Rayleigh scattering and molecular absorption (Rhos).

Purpose
	For use in estimating water quality and detecting algal blooms in the Continental US.

Extents
	Extent - Geographic
	West longitude -73.779998
	East longitude -72.749052
	North latitude 45.400288
	South latitude 43.371735

	Extent - GeoTiFF coordinate system
	West coordinate 598816.199246
	East coordinate 676216.199246
	North coordinate 5028194.210800
	South coordinate 4804394.210800

Spatial Representation - Grid
	Number of Dimensions 2
	Axis dimension properties
		Dimension
			Dimension name: column
			Dimension size: 258
			Resolution
				Distance 300.0
		Dimension
			Dimension name: row
			Dimension size: 746
			Resolution
				Distance 300.0

	Corner points
		CornerPoint 598816.199246 5028194.210800
		CornerPoint 598816.199246 4804394.210800
		CornerPoint 676216.199246 5028194.210800
		CornerPoint 676216.199246 4804394.210800

Content Information
	Feature Catalog Description
		Files listed in this catalog contain a collection of daily products in GeoTIFF format. Details of each product may be found below.
		Filenames follow the following naming conventention:
			<sat>.yyyyjjj.mmdd.hhmm...hhmmC.L3.<areacode>.<srccode><version>.<productname>.tif
				<sat>		name of satellite
				yyyy		4-digit year
				jjj		julian day (zero-prefixed)
				mm		month of year (zero-prefixed)
				dd		day of month (zero-prefixed)
				hh		hour (zero-prefixed)
				mm		minute (zero-prefixed)
				<areacode>		areacode
				<srccode>		level 2 source code (v=SAPS,n=NASA,e=ESA)
				<l2genversion>		level 2 generating software version
				<SAPSversion>		SAPS software version
				<prodscriptversion>		product generating script version
				<productname>		standard product name

		Products
			Product name: CI
			Version: 1.1
			Description: Chlorophyll Cyanobacteria Index with Kd clear water correction and CInoMCI adjacency flagging
			Scaling: round(83.3 * (log10(ci[ci>0]) + 4.2))
			Reverse scaling: 10**(3.0 / 250.0 * DN - 4.2) (for example: DN=100 translates to original value = 0.0010)
			Type: 1-band data
			Data key:
				0 - no detection
				250 - above range
				251 - adjacency
				252 - land
				253 - cloud
				254 - mixed or invalid
				255 - no data coverage
				1 - 249: scaled valid data

			Product name: CIcyano
			Version: 1.1
			Description: Chlorophyll Cyanobacteria Index - cyano only with Kd clear water correction and CInoMCI adjacency flagging
			Scaling: round(83.3 * (log10(ci[ci>0]) + 4.2))
			Reverse scaling: 10**(3.0 / 250.0 * DN - 4.2) (for example: DN=100 translates to original value = 0.0010)
			Type: 1-band data
			Data key:
				0 - no detection
				250 - above range
				251 - adjacency
				252 - land
				253 - cloud
				254 - mixed or invalid
				255 - no data coverage
				1 - 249: scaled valid data

			Product name: CInoncyano
			Version: 1.1
			Description: Chlorophyll Cyanobacteria Index - noncyano only with Kd clear water correction and CInoMCI adjacency flagging
			Scaling: round(83.3 * (log10(ci[ci>0]) + 4.2))
			Reverse scaling: 10**(3.0 / 250.0 * DN - 4.2) (for example: DN=100 translates to original value = 0.0010)
			Type: 1-band data
			Data key:
				0 - no detection
				250 - above range
				251 - adjacency
				252 - land
				253 - cloud
				254 - mixed or invalid
				255 - no data coverage
				1 - 249: scaled valid data

			Product name: truecolor
			Version: 1.0
			Description: RGB true color image
			Scaling: round(1.0 * <band> * 255 / 0.2)
			Type: 3-band RGB


Reference System Information
	Spatial reference:
		PROJCS["WGS 84 / UTM zone 18N",
		    GEOGCS["WGS 84",
		        DATUM["WGS_1984",
		            SPHEROID["WGS 84",6378137,298.257223563,
		                AUTHORITY["EPSG","7030"]],
		            AUTHORITY["EPSG","6326"]],
		        PRIMEM["Greenwich",0,
		            AUTHORITY["EPSG","8901"]],
		        UNIT["degree",0.0174532925199433,
		            AUTHORITY["EPSG","9122"]],
		        AUTHORITY["EPSG","4326"]],
		    PROJECTION["Transverse_Mercator"],
		    PARAMETER["latitude_of_origin",0],
		    PARAMETER["central_meridian",-75],
		    PARAMETER["scale_factor",0.9996],
		    PARAMETER["false_easting",500000],
		    PARAMETER["false_northing",0],
		    UNIT["metre",1,
		        AUTHORITY["EPSG","9001"]],
		    AXIS["Easting",EAST],
		    AXIS["Northing",NORTH],
		    AUTHORITY["EPSG","32618"]]

Contact Information
	Name: Richard Stumpf
	Organization: US DOC; NOAA; NOS; National Centers for Coastal Ocean Science
	Email: Richard.Stumpf@noaa.gov
	Role: Principal Investigator

	Name: Michelle Tomlinson
	Organization: US DOC; NOAA; NOS; National Centers for Coastal Ocean Science
	Email: Michelle.Tomlinson@noaa.gov
	Role: Collaborator


Credit
	Contains modified Copernicus Sentinel-3a data from EUMETSAT.

Usage Constraints Information
	Provisional products subject to change.

Metadata Information
	Creation date: 2018-08-29
