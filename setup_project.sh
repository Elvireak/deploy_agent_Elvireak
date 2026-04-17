#!/bin/bash

#Writing the trap code when user places Ctrl+C, it will create an archive file, to keep the progress of the user.

cleaner(){
echo "You interrupted the process! Archiving now..."
tar -czf attendance_tracker_${project_name}_archive.tar.gz attendance_tracker_$project_name
rm -rf attendance_tracker_${project_name}
echo "Archive saved. Exiting..."
exit 1
}

#Setting the trap
trap cleaner SIGINT

rm -rf attendance_tracker_*
#This while loop runs until the user enters the value, to do this it uses if statements.
while true; do
        read -p "Enter your own project name you prefer: " project_name
	if [ -n "${project_name}" ]; then
		break
	fi

		echo -e "\ndirectory name can't be empty, please type the name"
	
done

#Creating the directory based on user input that will contain report and helpers folders

mkdir -p "attendance_tracker_${project_name}"
mkdir -p "attendance_tracker_${project_name}/Helpers/"
mkdir -p "attendance_tracker_${project_name}/reports/"

#Copying files (I din't use mv command bcz it will move strictly whole files into that one user directory{it would mean one time use}, when the user will want to create another directory, they won't be able to have access to these file, hence an error)

cp ./source_code_files/attendance_checker.py attendance_tracker_${project_name}
cp ./source_code_files/assets.csv attendance_tracker_${project_name}/Helpers/
cp ./source_code_files/config.json attendance_tracker_${project_name}/Helpers/
cp ./source_code_files/reports.log attendance_tracker_${project_name}/reports/

read -p "Do you want to update the attendance threshold? (yes/no): " option

#For warning threshold

if [ "$option" = "yes" ]; then
while true; do
	read -p "Enter the new value of warning out of 100: " warning_threshold
	if [ -z "$warning_threshold" ]; then
           warning_threshold=75
           break
        elif [[ ! "$warning_threshold" =~ ^[0-9]+$ ]]; then
             echo -e "\nAn error occured, Please enter numbers only."
        elif (( warning_threshold < 0 || warning_threshold > 100 )); then
             echo -e "\nAn error occured, Please enter a number between 0 and 100."
        else
	break
	fi
done

#For failure threshold

while true; do
	read -p "Enter the new value of failure out of 100: " failure_threshold

	if [ -z "$failure_threshold" ]; then
           failure_threshold=50
           break
        elif [[ ! "$failure_threshold" =~ ^[0-9]+$ ]]; then
             echo -e "\nAn error occured, Please enter numbers only."
        elif (( failure_threshold < 0 || failure_threshold > 100 )); then
             echo -e "\nAn error occured, Please enter a number between 0 and 100."
        else
	break
	fi
done
#Using sed, to replace the values in confi.json, with new values the user inputted.
	sed -i "s/\"warning\": [0-9]*/\"warning\": $warning_threshold/" "attendance_tracker_${project_name}/Helpers/config.json"
	sed -i "s/\"failure\": [0-9]*/\"failure\": $failure_threshold/" "attendance_tracker_${project_name}/Helpers/config.json"

	echo "Thresholds were updated successfully!!!"
else
	echo -e " \nIf no, we will still keep the default values: (warning: 75 , failure: 50 ) "

fi

#Code to check if python3 is installed

echo -e "\n***Performing a health check, to check if Python3 is installed or not.***"

#Hiding the output of this python command so that only the output of python is installed or not should be the one to get displayed.
python3 --version > /dev/null 2>&1

if [ $? -eq 0 ]; then
	echo -e "\nPython3 is installed!"
else
	echo -e "\nWarning: Python3 is not installed."
fi
