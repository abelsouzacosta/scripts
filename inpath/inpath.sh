#!/bin/bash

# Checks if a command is either on $PATH or not

inpath() {
	result=$(which $1)

	if [ $? -eq 0 ]; then
		echo "$1 is in PATH"
		exit 0
	else
		echo "$1 is not in PATH"
		exit 1
	fi
}
