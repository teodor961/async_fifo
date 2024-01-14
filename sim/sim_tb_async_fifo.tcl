create_wave_config tb_async_fifo.wcfg

# Probe all signals recursively
add_wave -recursive tb_async_fifo

run all

###################################
## Check Results
###################################
if {[catch {set error_count [get_value -radix dec [get_scopes /]/error_count]} result]} {
    puts "\n\nERROR: Testbench MUST have a single top instance with an \"error_count\" signal in it.\n\n"
    exit 2
}

###################################
## Check Results
###################################
# Get the current directory where the script is located
set script_directory [file dirname [info script]]

# Create the file path for the "result" file in the same directory
set result_file [file join $script_directory "result.txt"]

# Open the file for writing
set file_id [open $result_file "w"]

# Write the value of $error_count to the file
puts $file_id $error_count

# Close the file
close $file_id

exec ls

exit
