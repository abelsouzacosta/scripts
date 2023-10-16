#!/bin/zsh

# get the list of subdirectories
subdirectories=()
# filled with absolute paths
absolutepaths=()

while IFS= read -r -d $'\0' directory; do
	subdirectories+=("$directory")
done < <(find . -maxdepth 1 -type d ! -name "*.*" -print0)

for subdir in "${subdirectories[@]}"; do
	absolute_path=$(readlink -f "$subdir")
	method_file="$absolute_path/main.sh"

	# concatenate the method file into a temporary generated file
	temporary=$(mktemp)

	echo "Concatenating method to your temporary file [[$temporary]]"
	cat "$method_file" >> "$temporary"

	function_name=$(basename "$absolute_path")

	if ! grep -q "$function_name" ~/.zshrc; then
		echo "Adding new script to yout zshrc"
		echo "" >> ~/.zshrc
		echo "Concatenating method to your environment file"
		cat "$temporary" >> ~/.zshrc
	else
		echo "The function already exists inside the file"
	fi

	# remove the temporary file
	echo "Removing temporary file [[$temporary]]"
	rm "$temporary"

done

source ~/.zshrc
exec $SHELL
