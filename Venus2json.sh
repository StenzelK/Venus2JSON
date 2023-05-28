#!/bin/bash

# Step 1: Check if Python is installed
python3 --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Python is not installed on this system."
    echo "Please download and install Python from https://www.python.org/downloads/"
    read -p "Press any key to exit..."
    exit 1
fi

# Step 2: Install required packages
pip3 install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "Failed to install the required packages."
    read -p "Press any key to exit..."
    exit 1
fi

# Step 3: Run venus2json.py
python3 venus2json.py

read -p "Press any key to exit..."
