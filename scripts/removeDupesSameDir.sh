#!/bin/bash

DUPE_DIR="$HOME/Downloads/dupes"

mkdir -p $DUPE_DIR

# Check if a directory path was provided as an argument
if [[ -z "$1" ]]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Store the provided directory path
target_directory="$1"

# Check if the provided path is a valid directory
if [[ ! -d "$target_directory" ]]; then
    echo "Error: Directory not found or is not a directory: $target_directory"
    exit 1
fi

# Change to the target directory to perform the operations
cd "$target_directory" || { echo "Failed to change directory."; exit 1; }

# A dictionary to store MD5 checksums and their corresponding filenames
declare -A checksums

# Loop through each file in the current (now target) directory
for file in *; do
    # Check if the item is a regular file
    if [[ -f "$file" ]]; then
        # Calculate the MD5 checksum of the file
        md5_checksum=$(md5sum "$file" | awk '{print $1}')

        # Check if the checksum already exists in our dictionary
        if [[ -n "${checksums[$md5_checksum]}" ]]; then
            # A duplicate is found. Append "duplicate" to the filename.
            original_filename="${checksums[$md5_checksum]}"
            new_filename="$md5_checksum_${file}"

            echo "Duplicate found: '$file' is a duplicate of '$original_filename'"
            echo "Renaming '$file' to '$new_filename'"

            # Rename the file
            mv -- "$file" "$new_filename"
            # move to dupes dir
            mv "$new_filename" "$DUPE_DIR"
        else
            # No duplicate found yet. Store the checksum and filename.
            checksums[$md5_checksum]="$file"
        fi
    fi
done

echo "Script finished."
