#!/bin/bash

search_text="example"
folder_path="/path/to/folder"

search_text_in_file() {
    file_path=$1
    while IFS= read -r line; do
        if [[ $line == *"$search_text"* ]]; then
            echo "Found '$search_text' in $file_path: $line"
        fi
    done < "$file_path"
}

search_text_in_folder() {
    local folder_path=$1
    local search_text=$2

    for file_path in "$folder_path"/*; do
        if [ -d "$file_path" ]; then
            search_text_in_folder "$file_path" "$search_text"
        elif [ -f "$file_path" ]; then
            search_text_in_file "$file_path"
        fi
    done
}

# Example usage
search_text_in_folder "$folder_path" "$search_text"
