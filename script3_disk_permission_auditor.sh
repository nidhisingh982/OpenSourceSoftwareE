#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Course: Open Source Software
# Description: Loops through important system directories and reports their
#              disk usage, owner, group, and permissions. Also checks for
#              VLC's config directory specifically.
# Concepts: for loop, arrays, if-then-else, du, ls -ld, awk, cut, echo
# =============================================================================

# --- Array of important system directories to audit ---
# Arrays in bash are defined with () and elements separated by spaces
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/var" "/usr" "/boot")

# --- VLC specific config directory ---
# VLC stores user config in ~/.config/vlc on Linux
VLC_CONFIG_DIR="$HOME/.config/vlc"

# =============================================================================
# SECTION 1: Print the report header
# printf is used here for precise column spacing in the table header
# =============================================================================
echo "================================================================="
echo "  DISK AND PERMISSION AUDITOR"
echo "  Generated: $(date '+%d %B %Y at %H:%M:%S')"
echo "================================================================="
echo ""
printf "  %-15s %-12s %-10s %-10s %-20s\n" "DIRECTORY" "SIZE" "OWNER" "GROUP" "PERMISSIONS"
printf "  %-15s %-12s %-10s %-10s %-20s\n" "---------------" "------------" "----------" "----------" "--------------------"

# =============================================================================
# SECTION 2: Loop through each directory in the DIRS array
# "${DIRS[@]}" expands all elements of the array one by one
# Each iteration stores the current directory path in $DIR
# =============================================================================
for DIR in "${DIRS[@]}"; do

    # --- Check if the directory actually exists before trying to read it ---
    if [ -d "$DIR" ]; then

        # --- Get permissions, owner, and group using ls -ld ---
        # ls -ld prints a single line of info for the directory itself
        # awk '{print $1}' extracts field 1 = permission string e.g. drwxr-xr-x
        # awk '{print $3}' extracts field 3 = owner username
        # awk '{print $4}' extracts field 4 = group name
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # --- Get disk usage using du -sh ---
        # du -sh gives a human-readable size (K, M, G)
        # 2>/dev/null suppresses "permission denied" errors on protected dirs
        # cut -f1 keeps only the first field (the size), dropping the path
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # --- If du returned nothing (e.g. permission denied), show N/A ---
        if [ -z "$SIZE" ]; then
            SIZE="N/A"
        fi

        # --- Print the row for this directory using printf for alignment ---
        printf "  %-15s %-12s %-10s %-10s %-20s\n" "$DIR" "$SIZE" "$OWNER" "$GROUP" "$PERMS"

    else
        # --- Directory does not exist on this system ---
        printf "  %-15s %s\n" "$DIR" "** does not exist on this system **"
    fi

done

# =============================================================================
# SECTION 3: VLC config directory check
# This section specifically checks whether VLC has created its config folder,
# which only exists after VLC has been launched at least once by the user.
# =============================================================================
echo ""
echo "================================================================="
echo "  VLC MEDIA PLAYER — CONFIG DIRECTORY CHECK"
echo "================================================================="
echo ""
echo "  Checking: $VLC_CONFIG_DIR"
echo ""

if [ -d "$VLC_CONFIG_DIR" ]; then
    # --- VLC config directory found — print its details ---
    PERMS=$(ls -ld "$VLC_CONFIG_DIR" | awk '{print $1}')
    OWNER=$(ls -ld "$VLC_CONFIG_DIR" | awk '{print $3}')
    GROUP=$(ls -ld "$VLC_CONFIG_DIR" | awk '{print $4}')
    SIZE=$(du -sh "$VLC_CONFIG_DIR" 2>/dev/null | cut -f1)

    echo "  STATUS      :  VLC config directory EXISTS"
    echo "  Path        :  $VLC_CONFIG_DIR"
    echo "  Size        :  $SIZE"
    echo "  Owner       :  $OWNER"
    echo "  Group       :  $GROUP"
    echo "  Permissions :  $PERMS"
    echo ""

    # --- List the config files inside the VLC directory ---
    echo "  Config files found:"
    # Loop through each file inside the VLC config dir and print its name
    for FILE in "$VLC_CONFIG_DIR"/*; do
        if [ -f "$FILE" ]; then
            # basename strips the directory path, leaving just the filename
            echo "    ->  $(basename "$FILE")"
        fi
    done

else
    # --- VLC config directory does not exist yet ---
    echo "  STATUS  :  VLC config directory NOT FOUND."
    echo ""
    echo "  This usually means VLC has not been launched yet."
    echo "  Launch VLC once and the config directory will be created at:"
    echo "  $VLC_CONFIG_DIR"
fi

echo ""
echo "================================================================="
