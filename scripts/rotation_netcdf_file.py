# Script to make the rotation angle file in netcdf
# Run with python environment stored in: /home/sdfo000/sitestore4/opp_drift_fa3/software/drift-tool-miniconda/bin
# Nancy Soontiens

import xarray as xr
from driftutils import rotate_fields

gridfile='/home/sdfo000/sitestore4/opp_drift_fa3/share_drift/CIOPSE_SN1500/CIOPSE_mesh_files]mesh_mask_NWA36_Bathymetry_flatbdy_20181109_3_filter_min_7p5.nc'

coeffs = rotate_fields.opa_angle_2016_p(gridfile)
 
mesh=xr.open_dataset(gridfile)
new_mesh='CIOPSE_mesh_with_angle.nc'

mesh['gsint'] = (['y', 'x'], coeffs[0],
                 {'long_name': 'sin(alpha) on T grid',
                  'description': ('sin of angle between north-south axis '
                                  'and ocean model j direction on T grid')}
                 )
mesh['gcost'] = (['y', 'x'], coeffs[1],
                 {'long_name': 'cos(alpha) on T grid',
                  'description': ('cosine of angle between north-south axis '
                                  'and ocean model j direction on T grid')}
                 )
mesh['gsinu'] = (['y', 'x'], coeffs[2],
                 {'long_name': 'sin(alpha) on U grid',
                  'description': ('sin of angle between north-south axis '
                                  'and ocean model j direction on U grid')}
                 )
mesh['gcosu'] = (['y', 'x'], coeffs[3],
                 {'long_name': 'cos(alpha) on U grid',
                  'description': ('cosine of angle between north-south axis '
                                  'and ocean model j direction on U grid')}
                 )
mesh['gsinv'] = (['y', 'x'], coeffs[4],
                 {'long_name': 'sin(alpha) on V grid',
                  'description': ('sin of angle between north-south axis '
                                  'and ocean model j direction on V grid')}
                 )
mesh['gcosv'] = (['y', 'x'], coeffs[5],
                 {'long_name': 'cos(alpha) on V grid',
                  'description': ('cosine of angle between north-south axis '
                                  'and ocean model j direction on V grid')}
                 )
mesh['gsinf'] = (['y', 'x'], coeffs[6],
                 {'long_name': 'sin(alpha) on F grid',
                  'description': ('sin of angle between north-south axis '
                                  'and ocean model j direction on F grid')}
                 )
mesh['gcosf'] = (['y', 'x'], coeffs[7],
                 {'long_name': 'cos(alpha) on F grid',
                  'description': ('cosine of angle between north-south axis '
                                  'and ocean model j direction on F grid')}
                 )

mesh.attrs['comment'] = ('To compute East/North velocity use these equations: '
                         'East = U*gcosu - V*gsinu, North = U*gsinv + V*gcosv '
                         'where U and V are on a C grid. \n'
                         'If U and V are on an A grid use '
                         'East = U*gcost - V*gsint, North = U*gsint + V*gcost.'
                         )
mesh.attrs['contact'] = 'Nancy Soontiens nancy.soontiens@dfo-mpo.gc.ca'

mesh.to_netcdf(new_mesh)
