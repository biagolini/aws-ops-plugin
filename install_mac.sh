#!/usr/bin/env bash

# Use the directory of the current script to form an absolute path
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Ensure /usr/local/bin directory exists
sudo mkdir -p /usr/local/bin

# Copy the script to /usr/local/bin
sudo cp "$script_dir/ops-aws-profile.sh" /usr/local/bin/ops-aws-profile

# Use select to prompt the user for a choice
PS3="Choose where to append 'source /usr/local/bin/ops-aws-profile' (enter number): "
options=(
    "~/.bashrc (for bash users)"
    "~/.zshrc (for zsh users)"
    "~/.bash_profile (alternative for bash users)"
    "~/.profile (general profile for bash)"
    "~/.zprofile (for zsh users during login)"
)

select opt in "${options[@]}"
do
    case $opt in
        "~/.bashrc (for bash users)")
            echo "source /usr/local/bin/ops-aws-profile" >> ~/.bashrc
            echo "Added to ~/.bashrc"
            break
            ;;
        "~/.zshrc (for zsh users)")
            echo "source /usr/local/bin/ops-aws-profile" >> ~/.zshrc
            echo "Added to ~/.zshrc"
            break
            ;;
        "~/.bash_profile (alternative for bash users)")
            echo "source /usr/local/bin/ops-aws-profile" >> ~/.bash_profile
            echo "Added to ~/.bash_profile"
            break
            ;;
        "~/.profile (general profile for bash)")
            echo "source /usr/local/bin/ops-aws-profile" >> ~/.profile
            echo "Added to ~/.profile"
            break
            ;;
        "~/.zprofile (for zsh users during login)")
            echo "source /usr/local/bin/ops-aws-profile" >> ~/.zprofile
            echo "Added to ~/.zprofile"
            break
            ;;
        *) 
            echo "Invalid choice. Exiting without adding."
            exit 1
            ;;
    esac
done

# Source the script immediately so it can be used without restarting the terminal
source /usr/local/bin/ops-aws-profile

echo "Installation completed!"