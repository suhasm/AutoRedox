@echo off
setlocal enabledelayedexpansion

:: Step 1: Store the name of the python script in a variable
set PYTHON_SCRIPT_NAME=opentronsdemo3.py

:: Step 2: Store the robot's IP address in a variable
set ROBOT_IP=169.254.186.203

:: Step 3: Show a prompt
echo Upload %PYTHON_SCRIPT_NAME% file to the robot's data folder (y/n)? You risk re-write.
set /p user_input=Choice: 

:: Step 4: Check the user's response
if /I "%user_input%" NEQ "y" (
    echo Terminating...
    exit /b
)

echo done

:: Step 5: Execute the scp command
scp -i ot2_ssh_key !PYTHON_SCRIPT_NAME! root@!ROBOT_IP!:/data
if errorlevel 1 (
    echo Error occurred while uploading.
    exit /b 1
)

echo File uploaded successfully!

ssh -i ot2_ssh_key root@!ROBOT_IP! "cd /data; ls; opentrons_execute !PYTHON_SCRIPT_NAME!"


pause
endlocal
exit /b 0