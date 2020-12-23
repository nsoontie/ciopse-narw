# Wrapper script to convert RPN files to netcdf
# Only the daily 3D file are converted
# Outputs are on Agrid
# Nancy Soontiens
# December 2020

# Load rpn utilities like editfst
. ssmuse-sh -d eccc/mrd/rpn/utils/19.5

# CIOPSE_EXP24 source directory
SRC_DIR=/home/roy000/.suites/ciops/ciops_pa_e_v4_EXP24/hub/eccc-ppp3/gridpt/anal/ciops
# Save directory
OUT_DIR=/home/nso001/data/work2/models/ciopse_exp24

YEAR=2016 # Replace with the year you want to process.
mmdd=01* # Replace with the month/day to process. Can be * to process all months/days in a year or 01* to process all days in January.
HH=00 # Only the 00 hour files because 3D are daily.

mkdir -p ${OUT_DIR}/${YEAR}
mkdir -p ${OUT_DIR}/tmp
files=$(ssh gpsc-vis2 "ls ${SRC_DIR}/${YEAR}${mmdd}${HH}_*")

for f in ${files}; do
    echo $f
    base=$(basename $f)
    # Log on to gpsc-vis2 to copy file.
    ssh gpsc-vis2 "cp $f ${OUT_DIR}/tmp/${base}"
    # Remove "surface" IP1 levels becase they don't need to be converted
    editfst -i dir_remove_surface_ip1 -s ${OUT_DIR}/tmp/${base} -d ${OUT_DIR}/tmp/${base}_nosurface
    mv ${OUT_DIR}/tmp/${base}_nosurface ${OUT_DIR}/tmp/${base}
    # convert to netcdf
    bash to_netcdf.sh ${OUT_DIR}/tmp/${base} ${OUT_DIR}/${YEAR} dict_3d.nc dict_3d.nc
    rm -rf ${OUT_DIR}/tmp/*
done
rm -rf ${OUT_DIR}/tmp
