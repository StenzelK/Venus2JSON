@echo off

REM Step 1: Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed on this system.
    echo Please download and install Python from https://www.python.org/downloads/
    pause
    exit /b
)

REM Step 2: Install required packages
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Failed to install the required packages.
    pause
    exit /b
)

REM Step 3: Run venus2json.py
py venus2json.py

pause
