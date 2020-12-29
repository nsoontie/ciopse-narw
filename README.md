# ciopse-narw

## Model data and runs

The following research runs are available on the gpsc:

### CIOPSE_EXP24
* Path: /home/sdfo000/sitestore4/opp_drift_fa3/share_drift/CIOPSE_EXP24
* Details: 2D files are hourly outputs on C-grid, 3D files are daily outputs on A-grid (converted from RPN to netCDF format)
* Date range: 2016-01-06 to 2019-12-31
* More information: gitlab.science.gc.ca/ocean/coordination-riops-ciops/wikis/CIOPS-E-PA-v2.0---EXP24

### CIOPSE_SN1500_bathy_dfo
* Path: /home/sdfo000/sitestore4/opp_drift_fa3/share_drift/CIOPSE_SN1500_bathy_dfo
* Details: 2D files are hourly outputs on C-grid, 3D files are daily outputs on A-grid (converted from RPN format to netCDF format)
* Date range: 2015-11-07 to 2019-01-09
* More information: gitlab.science.gc.ca/ocean/coordination-riops-ciops/wikis/CIOPS-E-Research-PA-v1.0

### CIOPSE_SN1500_catchup
* Path: /home/sdfo000/sitestore4/opp_drift_fa3/share_drift/CIOPSE_SN1500_catchup
* Details: 3D daily outputs. Originally on C-grid but unstaggered to A-grid
* Date range: 2019-01-10 to 2019-12-31
* Notes: Extension of CIOPSE_SN1500_bathy_dfo but likely contains issues related to tidal restarts every 7 days.

## Supplementary files
* /home/sdfo000/sitestore4/opp_drift_fa3/share_drift/CIOPSE_SN1500/CIOPSE_mesh_files/CIOPSE_mesh_with_angle.nc - contains grid angles for velocity rotation to North/East. Also contains gridspacing information.
  * Note: Between SN1500 and EXP24, more veritical grid cells were added so a new mesh file is needed for EXP24. Howevever, if the horizontal grid is unchanged then the rotation coeffiecients are likely still valid.