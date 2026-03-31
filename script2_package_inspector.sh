#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Course: Open Source Software
# Description: Checks whether a chosen FOSS package is installed on CachyOS
#              (Arch-based), displays its version and licence details, and
#              prints a philosophy note using a case statement.
# Concepts: variables, if-then-else, case statement, command substitution,
#           pacman package manager, pipes, grep, awk
# =============================================================================

# --- Target package — VLC Media Player ---
PACKAGE="vlc"

echo "================================================================="
echo "  FOSS PACKAGE INSPECTOR  —  CachyOS / Arch"
echo "================================================================="
echo "  Package under inspection: $PACKAGE"
echo "-----------------------------------------------------------------"
echo ""

# =============================================================================
# SECTION 1: Check if the package is installed using pacman
# pacman -Q checks if a package is installed (exit code 0 = found)
# pacman -Qi gives detailed info: version, licence, description, URL
# &>/dev/null suppresses any error output so only our messages show
# =============================================================================

if pacman -Q "$PACKAGE" &>/dev/null; then
    # --- Package IS installed ---
    echo "  STATUS  :  $PACKAGE is INSTALLED"
    echo ""
    echo "  PACKAGE DETAILS"
    echo "  ────────────────────────────────────────────"

    # pacman -Qi prints the full info block for the package
    # grep -E keeps only the lines matching Version, Licenses, Description, URL
    # awk splits each line on ' : ' and prints it in a neat aligned format
    pacman -Qi "$PACKAGE" | grep -E "^(Version|Licenses|Description|URL)" | \
        awk -F' : ' '{printf "  %-12s :  %s\n", $1, $2}'

else
    # --- Package is NOT installed ---
    echo "  STATUS  :  $PACKAGE is NOT INSTALLED on this system."
    echo ""
    echo "  To install it, run:"
    echo "    sudo pacman -S $PACKAGE"
fi

# =============================================================================
# SECTION 2: Philosophy note using a case statement
# case matches the value of $PACKAGE against each named pattern.
# Each branch ends with ;; to break out of the block.
# The *) wildcard at the end is the default/catch-all branch.
# =============================================================================
echo ""
echo "  OPEN SOURCE PHILOSOPHY"
echo "  ────────────────────────────────────────────"

case $PACKAGE in

    vlc)
        echo "  VLC: the media player that plays anything, on any platform."
        echo "  Licence: GPL v2 — free software that never asks you to pay"
        echo "  or install codecs. A true champion of open multimedia freedom."
        ;;

    httpd | apache)
        echo "  Apache: the web server that built the open internet."
        echo "  Licence: Apache 2.0 — permissive and business-friendly."
        ;;

    mysql | mariadb)
        echo "  MySQL/MariaDB: open source at the heart of millions of apps."
        echo "  Licence: GPL v2 — a FOSS pioneer with a dual-licence model."
        ;;

    curl)
        echo "  cURL: the silent workhorse of the internet, in every device."
        echo "  Licence: MIT/curl — proof that small tools can power the world."
        ;;

    git)
        echo "  Git: born from the Linux kernel community; now runs all of software."
        echo "  Licence: GPL v2 — the most widely used VCS, built on collaboration."
        ;;

    firefox)
        echo "  Firefox: the browser that fights for your privacy and an open web."
        echo "  Licence: Mozilla Public Licence v2 — copyleft for the modern web."
        ;;

    nginx)
        echo "  NGINX: high-performance open source web server and reverse proxy."
        echo "  Licence: BSD 2-clause — freedom to use, modify, and redistribute."
        ;;

    python | python3)
        echo "  Python: the language that democratised programming worldwide."
        echo "  Licence: PSF — open, permissive, backed by a non-profit foundation."
        ;;

    *)
        # Default branch — runs if no pattern above matches
        echo "  $PACKAGE: a valued member of the FOSS ecosystem."
        echo "  Open source software powers the modern world freely and transparently."
        ;;

esac

echo ""
echo "================================================================="
