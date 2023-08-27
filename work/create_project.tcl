set proj_name $::env(PROJECT_NAME)
set part_id xczu15eg-ffvc900-2-i

# Create the project and directory structure
create_project -force $proj_name -part $part_id
#
# Add RTL sources
add_files -norecurse [glob ../rtl/*.{v,vhd,VHD}]

# Add constraints
#if { [ catch add_files -norecurse [glob ../constraints/*.xdc] ] } {
#    puts "Warning: No constraints found in project"
#}

# Add testbench files
if { [ catch { add_files -norecurse [glob ../tb/*.{sv,v}] } ] } {
    puts "Warning: No testbench found in project"
}
