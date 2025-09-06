#!/bin/bash

SOURCE_DIR=""
TARGET_DIR=""

DUPE_DIR="$HOME/Downloads/dupes"

mkdir -p $DUPE_DIR

# Check if source and target directories exist
if [ ! -d "$SOURCE_DIR" ] || [ ! -d "$TARGET_DIR" ] || [ ! -d "$DUPE_DIR" ] ; then
    echo "Error: Source or target directory does not exist."
    exit 1
fi

# Iterate over each file in the source directory
find "$SOURCE_DIR" -type f -print0 | while IFS= read -r -d '' source_file; do
    source_sha=$(md5sum "$source_file" | awk '{print $1}')

    # Iterate over each file in the target directory
    find "$TARGET_DIR" -type f -print0 | while IFS= read -r -d '' target_file; do
        target_sha=$(md5sum "$target_file" | awk '{print $1}')

        # Compare the SHA256 hashes
        if [ "$source_sha" == "$target_sha" ]; then
            filename=$(basename "$target_file")
            dirname=$(dirname "$target_file")
            extension="${filename##*.}"
            filename_no_ext="${filename%.*}"

            # Check if the file has an extension
            if [ "$filename" == "$filename_no_ext" ]; then
                new_filename="${dirname}/${filename_no_ext}_$target_sha"
            else
                new_filename="${dirname}/${filename_no_ext}_$target_sha.${extension}"
            fi

            # Rename the file in the target directory
            mv "$target_file" "$new_filename"
            mv "$new_filename" "$DUPE_DIR"

            echo "Renamed '$target_file' to '$new_filename'"
        else
            echo -n "."
        fi
    done
done

echo "Script execution completed."
