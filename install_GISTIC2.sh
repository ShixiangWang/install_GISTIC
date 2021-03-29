#!/bin/bash
# FUN: Install GISTIC 2.0 by one line code
# 
# Format: 
#   ./install_GISTIC2.sh args1 args2
# args1: the path to GISTIC_x_x_xx.tar.gz file
# args2: the install directory, must be absolute path, note relative path
# 
# Version: 0.2.0 for GISTIC 2.0.23
# @copyright 2019 Shixiang Wang <w_shixiang@163.com>
# Release under MIT license

## Check OS
if [ "$(uname)" == "Darwin" ];then
    # MAC OS
    echo "MacOS is detected, the GISTIC2 is for Linux at default, just take a try..."
    CONFIG=~/.bash_profile
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ];then   
    # GNU/Linux
    CONFIG=~/.bashrc
else
    # Windows NT
    echo "Windows is detected, the GISTIC2 is for Linux at default, just take a try..."
    CONFIG=~/.bashrc
fi

file=$(basename $1)
dir=$2

# Prepare
echo =================
echo "  Preparing...  "
echo =================
if [ -d $dir ]; then
    echo "The install directory exists, exiting..."
    exit 1
fi

if mkdir -p $dir; then
    echo "Directory created."
else
    echo "Please check your permission for creating directory, exiting..."
    exit 1
fi

cp $1 $dir && cd $dir

# Unzip
echo =================
echo "  Unzipping...  "
echo =================
tar zxvf $file
mkdir MATLAB_Compiler_Runtime
cd MCR_Installer/
unzip MCRInstaller.zip 

# Install
echo =================
echo "  Installing...  "
echo =================
unset DISPLAY
./install -mode silent -agreeToLicense yes -destinationFolder "$dir"/"MATLAB_Compiler_Runtime/"

# Set env variable
echo ==================================
echo "Seting environmanet variables.."
echo ==================================
echo "export XAPPLRESDIR=$dir/MATLAB_Compiler_Runtime/v83/X11/app-defaults:\$XAPPLRESDIR" >> $CONFIG
echo "export LD_LIBRARY_PATH=$dir/MATLAB_Compiler_Runtime/v83/runtime/glnxa64:$dir/MATLAB_Compiler_Runtime/v83/bin/glnxa64:$dir/MATLAB_Compiler_Runtime/v83/sys/os/glnxa64:\${LD_LIBRARY_PATH}" >> $CONFIG
source $CONFIG

# Testing
echo ==================
echo "    Testing...  "
echo "Please be patient"
echo ==================
cd ../
./run_gistic_example

if [ $? -ne 0 ]; then
    echo "Test failed, please check the errors above."
    echo "Typically, the errors are due to lack of some system dependencies."
    echo "    Please search the QA on internet or file to https://github.com/ShixiangWang/install_GISTIC/issues"
else
    echo "Install finished, have fun!"
    echo "Check example code in file <run_gistic_example> for usage."
    echo "Check run_docker.sh if you use it in Docker environment."
    echo "-- Shixiang"
fi

rm $file
