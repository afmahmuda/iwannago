#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage:"
    echo "  $0 <destination_name> [--map <mapfile.yaml>]"
    echo "  $0 --list [--map <mapfile.yaml>]"
    exit 1
}

# Default map file path
MAP_FILE="$HOME/.iwannago_map.yaml"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --map)
            MAP_FILE="$2"
            shift
            shift
            ;;
        --list)
            LIST=true
            shift
            ;;
        *)
            DESTINATION="$1"
            shift
            ;;
    esac
done

# Check if --list option is provided
if [ "$LIST" = true ]; then
    # Check if map file exists
    if [ ! -f "$MAP_FILE" ]; then
        echo "Error: Map file '$MAP_FILE' not found."
        exit 1
    fi

    # Extract destination names from the map file
    DESTINATIONS=$(grep "name:" "$MAP_FILE" | awk '{print $3}')

    # Display destination names in vertical list
    echo "$DESTINATIONS"
    exit 0
fi

# Check if destination is provided
if [ -z "$DESTINATION" ]; then
    echo "Error: Destination name is required."
    usage
fi

# Check if map file exists
if [ ! -f "$MAP_FILE" ]; then
    echo "Error: Map file '$MAP_FILE' not found."
    exit 1
fi

# Get destination details from the map file
DEST_DETAILS=$(grep -A3 "name: $DESTINATION" "$MAP_FILE")

# Check if destination is found in the map file
if [ -z "$DEST_DETAILS" ]; then
    echo "Error: Destination '$DESTINATION' not found in the map file."
    exit 1
fi

# Parse destination details
ADDRESS=$(echo "$DEST_DETAILS" | grep "address" | awk '{print $2}')
USER=$(echo "$DEST_DETAILS" | grep "user" | awk '{print $2}')
IDENTITY_FILE=$(echo "$DEST_DETAILS" | grep "identity_file" | awk '{print $2}')

# SSH into the destination
ssh -i "$IDENTITY_FILE" "$USER@$ADDRESS"
