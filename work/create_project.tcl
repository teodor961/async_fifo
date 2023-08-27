set proj_name $::env(PROJECT_NAME)
set part_id xczu15eg-ffvc900-2-i

# Create the project and directory structure
create_project -force  ./project_bft_batch -part xc7k70tfbg484-2
#
# Add RTL sources
add_files -norecurse [glob ../rtl/*.{v,vhd,VHD}]

# Add constraints
add_files -norecurse [glob ../constraints/*.xdc]

# Add testbench files
add_files -norecurse [glob ../tb/*.{sv, v}]
