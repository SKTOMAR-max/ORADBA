#!/bin/bash

# Record start time
#START_TIME=$(date +%s)

# Basic color codes
RED='\033[0;31m'        # Red
GREEN='\033[0;32m'      # Green
YELLOW='\033[1;33m'     # Yellow
BLUE='\033[0;34m'       # Blue
MAGENTA='\033[0;35m'    # Magenta
CYAN='\033[0;36m'       # Cyan
RESET='\033[0m'         # Reset to default color

#echo "Source file $source_file successfully sourced."

LOG_FILE=$1
PATCH_DIR=$2
LOGS=$3
PATCHTMP=$4

#Current Running SID Output Location: /tmp/sid.out
# Define the path to the source file
source_file="$PATCHTMP/config.txt"  # Replace with the actual path to your source file

# Check if the source file exists
if [ ! -f "$source_file" ]; then
    echo "Error: Source file $source_file not found. Please ensure the file exists."
    exit 1
fi

# If the source file exists, source it
source "$source_file"



echo "--------------------------------------------------------"
echo
echo "Downloading Agent JDK patch......"
curl -s $CURL_AGENT_JDK >  $PATCHTMP/wget_Agent_JDK.sh
chmod +x $PATCHTMP/wget_Agent_JDK.sh
$PATCHTMP/wget_Agent_JDK.sh &
echo
  # Get the process ID of the Agent JDK process
  opatch_pid=$!

  # Display progress using dots
  while kill -0 $opatch_pid 2>/dev/null; do
    echo -n "."  # Print a dot every second to show progress
    sleep 1
  done

  echo " "  # Add a newline after the dots
echo
echo "Agent JDK patch downloaded!!!"
echo