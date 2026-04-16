#!/bin/bash

#Writing the trap code when user places Ctrl+C, it will create an archive file, to keep the progress of the user.

cleaner(){
echo "You interrupted the process! Archiving now..."
tar -czf attendance_tracker_${project_name}_archive.tar.gz attendance_tracker_$project_name
rm -rf attendance_tracker_$input
echo "Archive saved. Exiting."
exit 1
}

#Setting the trap
trap cleanup SIGINT

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

if [ $option = 'yes' ]; then
	read -p "Enter the new value of warning out of 100: " warning_threshold
	read -p "Enter the new value of failure out of 100: " failure_threshold
	sed -i "s/\"warning\": 75/\"warning\": $warning_threshold/" "attendance_tracker_${project_name}/Helpers/config.json"
	sed -i "s/\"failure\": 50/\"failure\": $failure_threshold/" "attendance_tracker_${project_name}/Helpers/config.json"

else
	echo -e " \nIf no, we will still keep the default values: (warning: 75 , failure: 50 ) "

fi

#Code to check if python3 is installed

echo -e "\n***Performing a health check, to check if Python3 is installed or not.***\n"
python3 --version 

if [ $? -eq 0 ]; then
	echo -e "\nPython3 is installed!"
else
	echo -e "\nWarning: Python3 is not installed."
fi
