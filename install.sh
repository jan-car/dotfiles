#!/bin/bash

install_config_files() {
    local source_dir="$1"  # Source directory (your repository)
    local dest_dir="$2"    # Destination directory (where you want to copy the files)
    shift 2                # Shift the positional parameters to remove the first two (source_dir and dest_dir)
    local filters=("$@")   # Accept an array of filters as arguments

    # Loop through each specified filter
    for filter in "${filters[@]}"; do
        # Find matching configuration files in the source directory
        find "$source_dir" -maxdepth 1 -type f -name "$filter" -print0 | while IFS= read -r -d '' config_file; do
            # Extract the filename without the path
            base_name=$(basename "$config_file")

            # Create a backup of the existing file (if it exists)
            if [ -f "$dest_dir/$base_name" ]; then
                cp "$dest_dir/$base_name" "$dest_dir/$base_name.backup"
                echo "$dest_dir/$base_name installed and backup created!"
            fi

            # Copy the new configuration file
            cp "$config_file" "$dest_dir/$base_name"
        done
    done
}

SRC_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

install_config_files $SRC_DIR/home $HOME .gitconfig .p10k.zsh .zshrc
install_config_files $SRC_DIR/ssh $HOME/.ssh config
install_config_files $SRC_DIR/oh-my-zsh_custom $HOME/.oh-my-zsh/custom *.zsh
