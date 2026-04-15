#!/bin/bash

rm -rf attendance_tracker_*

read -p "Enter your own project name you prefer: " project_name
mkdir -p "attendance_tracker_${project_name}"
mkdir -p "attendance_tracker_${project_name}/Helpers/"
mkdir -p "attendance_tracker_${project_name}/reports/"
cp ./attendance_checker.py "attendance_tracker_${project_name}"
cp ./assets.csv "attendance_tracker_${project_name}/Helpers/"
cp ./config.json "attendance_tracker_${project_name}/Helpers/"
cp ./reports.log "attendance_tracker_${project_name}/reports"

read -p "Do you want to update the attendance threshold? (yes/no): " option

if [ $option = 'yes']; then
	read -p "Enter the new value of warning out of 100: " warning
	read -p "Enter the new value of failure out of 100: " failure
	sed -i "s/\"warning_threshold\": 75/\": $warning/" "attendance_tracker_${project_name}/Helpers/config.json"
	sed -i "s/\"failure_threshold\": 50/\"failure_threshold\": $failure/" "attendance_tracker_${project_name}/Helpers/config.json"

else
	echo " If no, we will still keep the default values: (warning: 75% , failure: 50% ) "

	#toto
fi
