#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Course: Open Source Software
# Usage:  bash script4_log_analyzer.sh /path/to/logfile [KEYWORD]
# Example: bash script4_log_analyzer.sh /var/log/pacman.log error
# Description: Reads a log file line by line, counts occurrences of a keyword,
#              prints matching lines, and gives a full summary report.
# Concepts: command-line arguments ($1 $2), while read loop, if-then, counter
#           variables, grep, tail, wc, arithmetic expansion $(())
# =============================================================================

# =============================================================================
# SECTION 1: Handle command-line arguments
# $1 = first argument passed when running the script (the log file path)
# $2 = second argument (keyword to search for); defaults to "error" if not given
# The ${2:-"error"} syntax means: use $2 if set, otherwise use "error"
# =============================================================================
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword is 'error' if none provided

# --- Counters — all start at zero ---
COUNT=0           # Lines containing the keyword
TOTAL_LINES=0     # Total lines read in the file
WARN_COUNT=0      # Lines containing "warning" (bonus counter)

# =============================================================================
# SECTION 2: Validate input — make sure a file was actually given
# $# holds the number of arguments passed to the script
# If no argument was given, print usage instructions and exit
# =============================================================================
if [ $# -eq 0 ]; then
    echo "================================================================="
    echo "  USAGE: bash script4_log_analyzer.sh <logfile> [keyword]"
    echo ""
    echo "  Examples:"
    echo "    bash script4_log_analyzer.sh /var/log/pacman.log error"
    echo "    bash script4_log_analyzer.sh /var/log/pacman.log warning"
    echo "================================================================="
    exit 1
fi

# --- Check the file exists and is a regular file ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found. Please check the path."
    exit 1
fi

# --- Check the file is not empty ---
# -s returns true if file exists AND has a size greater than zero
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: '$LOGFILE' exists but is empty. Nothing to analyze."
    exit 1
fi

# =============================================================================
# SECTION 3: Print the report header
# =============================================================================
echo "================================================================="
echo "  LOG FILE ANALYZER"
echo "  Generated : $(date '+%d %B %Y at %H:%M:%S')"
echo "================================================================="
echo ""
echo "  Log File  :  $LOGFILE"
echo "  Keyword   :  $KEYWORD"
echo "-----------------------------------------------------------------"

# =============================================================================
# SECTION 4: Read the log file line by line using a while read loop
# "while IFS= read -r LINE" reads one line at a time into the variable $LINE
# IFS=  prevents leading/trailing whitespace being stripped from each line
# -r    prevents backslashes being interpreted as escape characters
# "done < $LOGFILE" redirects the file contents into the while loop as input
# =============================================================================
while IFS= read -r LINE; do

    # --- Increment the total line counter for every line read ---
    TOTAL_LINES=$((TOTAL_LINES + 1))

    # --- Check if this line contains the keyword (case-insensitive with -i) ---
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        # Increment keyword match counter using arithmetic expansion $(())
        COUNT=$((COUNT + 1))
    fi

    # --- Bonus: also count lines containing "warning" separately ---
    if echo "$LINE" | grep -iq "warning"; then
        WARN_COUNT=$((WARN_COUNT + 1))
    fi

done < "$LOGFILE"

# =============================================================================
# SECTION 5: Print the matching lines
# grep -i = case-insensitive, --color = highlight the keyword in output
# tail -n 5 limits output to the last 5 matching lines to keep it readable
# =============================================================================
echo ""
echo "  LAST 5 LINES MATCHING '$KEYWORD':"
echo "  ────────────────────────────────────────────────────────────"

# Store matching lines in a variable first
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE")

if [ -z "$MATCHES" ]; then
    # -z checks if the string is empty — no matches found
    echo "  No lines found containing '$KEYWORD'."
else
    # Print last 5 matching lines; sed adds indentation for readability
    echo "$MATCHES" | tail -n 5 | sed 's/^/  /'
fi

# =============================================================================
# SECTION 6: Print the summary report
# We calculate the match percentage using awk (bash can't do decimals natively)
# =============================================================================
echo ""
echo "  SUMMARY"
echo "  ────────────────────────────────────────────────────────────"
echo "  Total lines read       :  $TOTAL_LINES"
echo "  Lines with '$KEYWORD'  :  $COUNT"
echo "  Lines with 'warning'   :  $WARN_COUNT"

# --- Calculate percentage of lines that matched the keyword ---
if [ "$TOTAL_LINES" -gt 0 ]; then
    PERCENT=$(awk "BEGIN {printf \"%.2f\", ($COUNT / $TOTAL_LINES) * 100}")
    echo "  Match percentage       :  $PERCENT%"
fi

# --- Final verdict based on keyword count ---
echo ""
echo "  VERDICT"
echo "  ────────────────────────────────────────────────────────────"
if [ "$COUNT" -eq 0 ]; then
    echo "  No '$KEYWORD' entries found. Log looks clean."
elif [ "$COUNT" -lt 10 ]; then
    echo "  Low number of '$KEYWORD' entries ($COUNT). Worth monitoring."
else
    echo "  High number of '$KEYWORD' entries ($COUNT). Review recommended."
fi

echo ""
echo "================================================================="
