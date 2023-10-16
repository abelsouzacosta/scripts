# Checks if a command is either on $PATH or not
function inpath() {
	# check if the number of arguments
	if [ $# -eq 0 ]; then
		echo "Please provide a command as argument"
		return 1
	fi

	result=$(which $1)

	# check the code of the output from the which command
	# if zero, it means that the command is in path
	if [ $? -eq 0 ]; then
		echo "$1 is on PATH at $result"
		return 0
	else # if different, it means that the command was not found in the path
		echo "$1 is not on PATH"
		return 1
	fi
}
