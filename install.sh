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

	echo "Concatenating method to your environment file"
	cat "$temporary" >> ~/.zshrc
	
	# remove the temporary file
	echo "Removing temporary file [[$temporary]]"
	rm "$temporary"
done

source ~/.zshrc
exec $SHELL
