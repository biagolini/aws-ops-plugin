#!/usr/bin/bash

# Remove the file from /usr/bin
sudo rm /usr/bin/ops-aws-profile
echo "Removed /usr/bin/ops-aws-profile."

# Remove the source line from initialization files
files=(~/.bashrc ~/.zshrc ~/.bash_profile ~/.profile ~/.zprofile)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        # Use sed to remove the line
        sed -i '/source \/usr/bin\/ops-aws-profile/d' "$file"
        echo "Removed source command from $file."
    fi
done

echo "Uninstallation completed!"
