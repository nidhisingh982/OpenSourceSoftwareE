#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: Nidhi Singh - 24BCE11533 | Course: Open Source Software
# Description: Displays a formatted welcome screen with key system information
#              including distro, kernel, user details, uptime, and OS licence.
# =============================================================================
 
# --- Student Variables ---
# Fill in your name and your chosen open-source software below
STUDENT_NAME="Nidhi Singh"
SOFTWARE_CHOICE="VLC-MEDIA-PLAYER"
 
# --- System Info using Command Substitution $() ---
# $() runs a command and captures its output as a string value
KERNEL=$(uname -r)                                             # Linux kernel version
USER_NAME=$(whoami)                                            # Currently logged-in username
HOME_DIR=$(eval echo ~"$USER_NAME")                           # Home directory path of that user
UPTIME=$(uptime -p)                                           # Human-readable uptime e.g. "up 2 hours"
CURRENT_DATE=$(date "+%A, %d %B %Y")                         # e.g. Monday, 28 March 2026
CURRENT_TIME=$(date "+%H:%M:%S")                             # 24-hour time e.g. 14:35:02
 
# --- Distro Name ---
# /etc/os-release is a standard file present on all modern Linux distributions.
# We grep for the PRETTY_NAME line and strip the surrounding quotes.
DISTRO=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
 
# --- OS Licence ---
# Most Linux distributions are covered by the GNU GPL.
# We attempt to read a LICENSE field from os-release; if absent we use the default.
LICENSE=$(grep -i "^LICENSE" /etc/os-release | cut -d= -f2 | tr -d '"')
if [ -z "$LICENSE" ]; then
    LICENSE="GNU General Public License v2 (GPLv2)"
fi
 
# --- Display: Print the welcome banner ---
echo "================================================================="
echo "         OPEN SOURCE AUDIT  —  $STUDENT_NAME"
echo "================================================================="
echo ""
 
# --- Display: Software under audit ---
echo "  Software Under Audit : $SOFTWARE_CHOICE"
echo ""
 
# --- Display: System identity details ---
echo "  SYSTEM INFORMATION"
echo "  ──────────────────────────────────────────"
echo "  Distribution  :  $DISTRO"
echo "  Kernel        :  $KERNEL"
echo "  Logged-in User:  $USER_NAME"
echo "  Home Directory:  $HOME_DIR"
echo "  System Uptime :  $UPTIME"
echo "  Date          :  $CURRENT_DATE"
echo "  Time          :  $CURRENT_TIME"
echo ""
 
# --- Display: Licence notice ---
echo "  OPEN-SOURCE LICENCE"
echo "  ──────────────────────────────────────────"
echo "  This operating system is distributed under:"
echo "  $LICENSE"
echo ""
echo "  You are free to run, study, modify, and redistribute"
echo "  this software under the terms of that licence."
echo ""
echo "================================================================="
