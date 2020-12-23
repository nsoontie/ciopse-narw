#!/bin/bash
## Script to convert rpn file to netcdf
## Usage: bash to_netcdf.sh file outdir dict2d dict3d
## file can be a single file or a list of files ( e.g "f1 f2 f3")
## dict2d and dict3d are the 2d and 3d rpn2netcdf dictionaries
## Separates 2D, 3D fields into different files
## Author: Nancy Soontiens

# Load cstrpn2cdf utilities 
#. ssmuse-sh -x /fs/ssm/eccc/cmd/cmde/ocean/tools/20190903/ # from DFO-GPSC wiki
#. ssmuse-sh -x /fs/ssm/eccc/cmd/cmde/ocean/tools/20201113/ # newest version - not compatibile with amd64 processors (only skylake)
. ssmuse-sh -x /fs/ssm/eccc/cmd/cmde/ocean/tools/20191028/ # newest version that works with amd64


# Global attibutes
SOURCE="CIOPSE_EXP24"

# 2D fields
var_2D='SSH UU2W VV2W GE GL SA2W SDV SIII STGI TM2 TMI UUI VVI UU VV UTAW VTAW'
# 3D fields
var_3D='UUW VVW SALW TM'
# grid fields
var_grid="E3T E2T E1T E2U E1U E2V E1V"

# Commands for conversion and appending to a single netcdf
outdir=$2
dict2d=$3
dict3d=$4
for f in $1; do 
    echo $f
    base=$(basename $f)
#    # 2D fields 
#    dict=$dict2d
#    for var in $var_2D; do
#      # Convert to netcdf, ignore mask and remove singlton z dimensions
#      cstrpn2cdf -s $f -d ${outdir}/${base}_2D_${var} -cutz T \
#        -ignm F -dict $dict -nomv $var
#    done
#    # Final netcdf file name
#    final_nc=${outdir}/${base}_2D.nc
#    if [[ -f $final_nc ]]; then
#       rm -f $final_nc
#    fi
#    # List all but first netcdf files generated by cstrpn2cdf
#    newfiles=$(ls $outdir/${base}_2D*.nc* | tail -n +2)
#    # List first netcdf file generated by cst2rpncdf
#    firstfile=$(ls ${outdir}/${base}_2D*.nc* | head -1)
#    # Append all netcdf to a single file and remove temporary files 
#    cp $firstfile $final_nc
#    rm -f $firstfile
#    for nf in $newfiles; do
#      ncks -h -A $nf $final_nc
#      rm -f $nf
#    done
#    # Add attributes
#    ncatted -h -a source,global,o,c,"$SOURCE" $final_nc
#    # Compress file
#    ncks -4 -L4 -O $final_nc $final_nc
  
    # 3D fields
    dict=$dict3d
    for var in $var_3D; do
      # Convert to netcdf, ignore mask and remov singlton z dimensions   
      eval "d.cstrpn2cdf -s $f -d ${outdir}/${base}_3D_${var} -cutz T \
        -ignm F -dict $dict -nomv $var -zdim depth" 
    done
    # Final netcdf file name
    final_nc=${outdir}/${base}_3D.nc
    if [[ -f $final_nc ]]; then
       rm -f $final_nc
    fi
    # List all but first netcdf files generated by cstrpn2cdf 
    newfiles=$(ls $outdir/${base}_3D* | tail -n +2)
    # List first netcdf file generated by cst2rpncdf
    firstfile=$(ls ${outdir}/${base}_3D* | head -1)
    # Append all netcdf to a single file and remove temporary files
    cp $firstfile $final_nc
    rm -f $firstfile
    for nf in $newfiles; do
      ncks -h -A $nf $final_nc
      rm -f $nf
    done
    # Add attributes
    ncatted -h -a source,global,o,c,"$SOURCE" $final_nc
    # Compress file
    ncks -4 -L4 -O $final_nc $final_nc
done
