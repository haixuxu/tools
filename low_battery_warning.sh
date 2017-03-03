#!/bin/bash
                                                                               
# Location of acpi files. 
path="/sys/class/power_supply/BAT0/capacity"

# cat /sys/class/power_supply/BAT0/status(Charging, Discharging, Full)
path2="/sys/class/power_supply/BAT0/status"
current=`cat $path`
state=$((current+0))
export DISPLAY=:0 # This is needed so that the script can post to the display (using the zenity command, running through su as steph).
echo $current>>/tmp/battery.log
echo $path2>>/tmp/battery.log
if [ $state -lt 75 ]
then
       zenity --warning --title "Battery" --text "Low battery. (state = $state)"
fi 
