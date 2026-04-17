# Attendance tracker Setup Script

## Description of the project

This is a shell script that has a source logic that is same as the one of "Student Attendance Tracker". It follows correct diretory structure, changes attendance thresholds based on the user input, and handles interruptions gracefully using signal trapping. Which means instead of manually creating folders and placing files the script handles eveything in one run.

---

## How I approached the solution

I started by thinking about what the script needed to do for instance to get input from the user, building a correct directory structure, and among others.

To briefly know how I briefly approached the solution, click on the video link below, which contains detailed information, of how I approached the solution, and a practical work through of how the script runs.

WIBUKE GUSHYIRA LINK HANO ....

---

## How to run the script

To run this project, clone the repository and execute the setup script:

```bash
git clone https://Your_github_personal_token@github.com/Elvireak/deploy_agent_Elvireak.git
cd deploy_agent_Elvireak                #Change into your cloned repository
chmod +x setup_project.sh                #Give the script execute permission
./setup_project.sh                       #Run it

```

**When prompted type your preferred name and press enter.**

When you run the script, you will be asked to enter the preferred name, if you don't enter any, you will be asked multiple times until you type a name you want, the directory name cannot be empty.

Then when you enter a name the script will create a directory based on your input and then inside it, it builds files and folders(Helpers and report). Then back to what the user is prompted, the script will ask the user if they want to update the attendance threshold. 

User will have to choose between yes or no, if yes, you will enter new values of warning and failure, and they will update the ones in the `config.json`. Through the use of `sed` command. Note that the user has to enter a number between 0 and 100, if no the script will keep its default values. 'warning = 75', 'failure = 50' 

---

## How to Trigger the Archive Feature

The archive feature is triggered by pressing `Ctrl+C` at any point while the scriptis runnning.

To implememnt this I used a `trap` that cathes the SIGINT signal. Here is what happens when you press `Ctrl+c`:

- The script catches the interruption before it exits
- It uses `tar -czf` to keep whatever has been created so far into a compressed archive named `attendance_tracker_{project_name}_archive.tar.gz`
-It then deletes the incomplete project directory using `rm -rf` to keep the workspace clean
- Finally it exits safely

---

## The file structure

Here is the file structure the script is going to build.

```
attendance_tracker_{project_name}/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log
```
---

## Health check

At the end the script checks if python 3 is installed on the system using `python --version` command. If it is the system prints out that it is installed if not, it prints a warning message if it is not installed.
