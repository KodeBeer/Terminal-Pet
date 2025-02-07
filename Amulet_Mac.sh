#!/bin/bash

# Define the counter file
COUNTER_FILE="/home/ko/Documents/GitHub/Terminal-Pet/counter.txt"
TIME_TRACK_FILE="/home/ko/Documents/GitHub/Terminal-Pet/time_spent.txt"

# Check if the counter file exists
if [ ! -f "$COUNTER_FILE" ]; then
    echo 0 > "$COUNTER_FILE"  # If the file doesn't exist, initialize counter to 0
fi

# Check if the start time is already recorded
if [ ! -f "$TIME_TRACK_FILE" ]; then
    # If the file does not exist, this is the first time the script is running
    start_time=$(date +%s)  # Get the current timestamp in seconds
    echo "$start_time" > "$TIME_TRACK_FILE"  # Store the start time in the file
    echo "Welcome! Starting time tracking..."
else
    # If the file exists, read the stored start time
    start_time=$(cat "$TIME_TRACK_FILE")
fi
# Read the current counter value from the file
counter=$(cat "$COUNTER_FILE")

# Increment the counter
((counter++))

# Calculate the time spent in the terminal since the script started
current_time=$(date +%s)  # Get the current timestamp in seconds
time_spent=$((current_time - start_time))  # Time spent in seconds

# Convert time spent into minutes and hours
minutes_spent=$((time_spent / 60))
hours_spent=$((minutes_spent / 60))
remaining_minutes=$((minutes_spent % 60))

# Display the time spent in a readable format
echo "Time spent in terminal: ${hours_spent} hours and ${remaining_minutes} minutes."

if [ "$counter" -ge 5 ]; then
    spriteNum=5
else
    spriteNum=0
fi

# Save the updated counter value back to the file
echo "$counter" > "$COUNTER_FILE"

Leg[0]="  /   \   "
Leg[1]="   \  \   "
Leg[2]="   \ /    "
Leg[3]="  /  /    "

Sprite[0]="    _     "
Sprite[1]="  / . \   "
Sprite[2]=" |  .  |  "
Sprite[3]="  \___/   "
Sprite[4]="----------"
Sprite[5]="     @@   "
Sprite[6]="  \  ##>  "
Sprite[7]="   ###    "

Sprite[9]="----------"

animate_sprite() {
    walkNum=0
    while true; do
        Sprite[8]="${Leg[walkNum]}"
        # Clear the terminal screen
        clear
        
        # Display ASCII art
        echo -e " \033[33;41mO__________________\033[0m"
        echo -e "  \033[33;41m|___________     |\033[0m"
        echo -e "  \033[33;41m|${Sprite[$((0 + spriteNum))]}|  o  |\033[0m"
        echo -e "  \033[33;41m|${Sprite[1 + spriteNum]}|\  / |\033[0m"
        echo -e "  \033[33;41m|${Sprite[2 + spriteNum]}| \o  |\033[0m"
        echo -e "  \033[33;41m|${Sprite[3 + spriteNum]}| /\  |\033[0m"
        echo -e "  \033[33;41m|${Sprite[4 + spriteNum]}|/ o\ |\033[0m"
        echo -e "  \033[33;41m|________________|\033[0m"

        # Display the current counter value
        echo "You are level $counter"


        # Display the time spent in a readable format
        echo "Time spent in terminal: ${hours_spent} hours and ${remaining_minutes} minutes."


                # Increment walkNum to cycle through legs (loop back after 3)
        if [ "$walkNum" -eq 3 ]; then
            walkNum=0
        else
            ((walkNum++))
        fi

        # Delay between frames for animation effect
        sleep 1  # Adjust this value to make the animation faster or slower
    done
}

# Start the animation
animate_sprite
