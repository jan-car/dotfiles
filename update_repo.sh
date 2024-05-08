#!/bin/bash

update_repo_from_config_files() {
    local source_dir="$1"  # Source directory (where you copied the files)
    local dest_dir="$2"    # Destination directory (your repository)
    shift 2                # Shift the positional parameters to remove the first two (source_dir and dest_dir)
    local filters=("$@")   # Accept an array of filters as arguments

    # Loop through each specified filter
    for filter in "${filters[@]}"; do
        # Find matching configuration files in the destination directory
        find "$source_dir" -maxdepth 1 -type f -name "$filter" -print0 | while IFS= read -r -d '' config_file; do
            # Extract the filename without the path
            base_name=$(basename "$config_file")

            # Copy the configuration file back to the repository
            cp "$config_file" "$dest_dir/$base_name"
            echo "$config_file copied to $dest_dir/$base_name"
        done
    done
}

# Check if the Git status is clean
if test -n "$(git status --porcelain)"; then
    echo "Error: Your Git working directory has uncommitted changes. Please commit or stash your changes before running this script."
    exit 1
fi

DEST_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

update_repo_from_config_files $HOME $DEST_DIR/home .gitconfig .p10k.zsh .zshrc
update_repo_from_config_files $HOME/.ssh $DEST_DIR/ssh config
update_repo_from_config_files $HOME/.oh-my-zsh/custom $DEST_DIR/oh-my-zsh_custom *.zsh
