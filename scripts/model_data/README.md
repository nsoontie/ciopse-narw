# RPN to netCDF conversion scripts
These are scripts that have been used to convert CIOPSE 3D RPN files to netCDF format. They rely on an ECCC utility called d.cstrpn2cdf. The scripts have been customized to apply to CIOPSE.

* to_netcdf.sh - Script to convert a single 3D rpn file to netCDF format. Loads the ssm module for d.cstrpn2cdf.
* netcdf_wrapper.sh - A wrapper script that calls to_netcdf.sh to convert many files.
* dict_3d.nc - a dictionary for translating RPN variables names to netCDF metadata

## Note - December 23, 2020
These scripts worked for older versions of CIOPSE (e.g. SN1500 and the current version 1.0 operational output) but they aren't working for the EXP24 results. We see the following output when calling d.cstrpn2cdf on one of the EXP24 files:
```
 ------------------------------------------------------
 found           6  nvars in dictionary dict_3d.nc
 reading attributes
 ------------------------------------------------------
 found           5  attributes for var time
 found           7  attributes for var depth
 found          14  attributes for var votemper
 found          14  attributes for var vosaline
 found          14  attributes for var vozocrtx
 found          14  attributes for var vomecrty
 found           7  attributes for var GLOBAL
 ------------------------------------------------------

 CSTRPN2CDF: SCANNING SOURCE VERTICAL GRIDS
 getstdngrid ==> new horizontal grid found for nomvar=UUW
 getstdngrid ==> new horizontal grid found for nomvar=UUW
 --------------------------------------------------
 CSTRPN2CDF: grid number=           1
 CSTRPN2CDF:     ig1s=        1001        1002        1003           0
 CSTRPN2CDF:     nx,ny,nz=        1410         945         102
 CSTRPN2CDF:     number of variable (including @@)=           0
 CSTRPN2CDF:     number of calendars for this grid=           0
 CSTRPN2CDF getstdncalendars => problem no calendar found for this list of variables
 CSTRPN2CDF getstdncalendars => ncal=           0
abort: Exiting now...
```

### Update
I was able to resolve this issue by removing the ip1 fields associated with the surface using editfst. The appropriate changes were made to netcdf_wrapper.sh where the ip1 values associated with the surface are removed from the rpn file before it is passed into to_netcdf.sh.