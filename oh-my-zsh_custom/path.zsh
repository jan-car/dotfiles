export PATH=$(cat <<EOF
${KREW_ROOT:-$HOME/.krew}/bin
${HOME}/.local/bin
EOF
):$PATH

# TODO: Add /mnt/c/Users/Jan.Caron/AppData/Local/Programs/Microsoft VS Code/bin or is it there by default from Windows?