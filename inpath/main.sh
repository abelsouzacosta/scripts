#!/bin/bash

source ./inpath.sh

if [ $# -ne 1 ]; then
	echo "Please provide an argument"
	exit
else
	inpath "$1"
fi
