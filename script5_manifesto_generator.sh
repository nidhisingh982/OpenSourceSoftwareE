#!/bin/bash
# =============================================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Course: Open Source Software
# Description: Asks the user three interactive questions, then composes and
#              saves a personalised open source philosophy statement to a .txt
#              file using string concatenation and file redirection.
# Concepts: read, interactive input, string concatenation, file redirection
#           (> and >>), date command, variables, echo, cat, aliases (commented)
# =============================================================================

# --- Alias concept demonstrated via comment ---
# In a normal shell session you could define a shortcut like:
#   alias makefile='touch'
# Aliases are not used inside scripts (they don't expand by default),
# but they are a key shell concept for productivity in the terminal.

# --- Output file — named after the current logged-in user ---
# whoami is wrapped in $() for command substitution
OUTPUT="manifesto_$(whoami).txt"

# --- Capture the current date for the manifesto footer ---
DATE=$(date '+%d %B %Y')
TIME=$(date '+%H:%M:%S')

# =============================================================================
# SECTION 1: Welcome banner
# =============================================================================
echo "================================================================="
echo "   THE OPEN SOURCE MANIFESTO GENERATOR"
echo "================================================================="
echo ""
echo "  Answer three questions and your personal open source"
echo "  philosophy statement will be written and saved for you."
echo ""
echo "-----------------------------------------------------------------"

# =============================================================================
# SECTION 2: Interactive user input using read
# read -p "prompt" VARIABLE — displays the prompt and waits for the user
# to type a response, storing it in the named variable.
# The user's answer is stored as a string for use in the manifesto.
# =============================================================================

# --- Question 1: Daily open-source tool ---
echo ""
read -p "  1. Name one open-source tool you use every day: " TOOL

# --- Question 2: What freedom means to them ---
read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM

# --- Question 3: Something they would build and share ---
read -p "  3. Name one thing you would build and share freely: " BUILD

# --- Question 4 (bonus): Their name for personalisation ---
read -p "  4. What is your name?                              " AUTHOR

# =============================================================================
# SECTION 3: Validate input — make sure none of the answers are empty
# -z checks if a string has zero length (i.e. user just pressed Enter)
# =============================================================================
echo ""

if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ] || [ -z "$AUTHOR" ]; then
    echo "  ERROR: All four questions must be answered."
    echo "  Please re-run the script and fill in every answer."
    exit 1
fi

# =============================================================================
# SECTION 4: String concatenation — build the manifesto paragraph
# Bash strings are concatenated simply by placing variables next to text.
# Each line of the manifesto is built by combining fixed text with the
# user's answers stored in $TOOL, $FREEDOM, $BUILD, and $AUTHOR.
# =============================================================================

# Build each sentence as its own variable for clarity
LINE1="I, $AUTHOR, believe that open source software is not just code —"
LINE2="it is a movement built on the principle that knowledge belongs to everyone."
LINE3="Every day I rely on $TOOL, a tool created and shared freely by developers"
LINE4="around the world who understood that collaboration builds better software than secrecy."
LINE5="To me, freedom in the digital world means $FREEDOM —"
LINE6="the ability to inspect, improve, and redistribute the tools we depend on."
LINE7="In the spirit of that freedom, I commit to one day building $BUILD"
LINE8="and releasing it openly, so that others may learn from it, improve it,"
LINE9="and carry the open source philosophy forward."
LINE10="Software is most powerful when it is free — free as in freedom."

# =============================================================================
# SECTION 5: Write the manifesto to a .txt file
# > (single redirect) creates the file fresh or overwrites it if it exists
# >> (double redirect) appends to the file without overwriting
# We use > for the first line, then >> for every line after
# =============================================================================

# --- Write header using > to create/overwrite the file cleanly ---
echo "=================================================================" > "$OUTPUT"
echo "   MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "   By: $AUTHOR" >> "$OUTPUT"
echo "   Date: $DATE  |  Time: $TIME" >> "$OUTPUT"
echo "=================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Write the manifesto body using >> to append each line ---
echo "  $LINE1" >> "$OUTPUT"
echo "  $LINE2" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  $LINE3" >> "$OUTPUT"
echo "  $LINE4" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  $LINE5" >> "$OUTPUT"
echo "  $LINE6" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  $LINE7" >> "$OUTPUT"
echo "  $LINE8" >> "$OUTPUT"
echo "  $LINE9" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  $LINE10" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=================================================================" >> "$OUTPUT"
echo "  Signed: $AUTHOR  |  Generated on CachyOS Linux  |  $DATE" >> "$OUTPUT"
echo "=================================================================" >> "$OUTPUT"

# =============================================================================
# SECTION 6: Confirm save and display the manifesto using cat
# cat reads the file and prints its full contents to the terminal
# =============================================================================
echo "-----------------------------------------------------------------"
echo "  Manifesto saved to: $OUTPUT"
echo "-----------------------------------------------------------------"
echo ""

# --- cat prints the saved file back to the screen ---
cat "$OUTPUT"

echo ""
echo "================================================================="
echo "  Your manifesto has been saved. Share it freely."
echo "================================================================="
