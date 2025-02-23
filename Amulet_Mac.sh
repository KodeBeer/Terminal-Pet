#!/bin/bash

# Clear the screen
tput clear

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

# Save the updated counter value back to the file
echo "$counter" > "$COUNTER_FILE"

# Function to move the cursor to a specific position
move_cursor() {
    tput cup $1 $2  # Moves the cursor to row $1 and column $2
}

# Function to animate a moving sprite (entire sprite moves together)
animate_sprite() {
    width=11  # Width of the screen for animation
    height=2  # Height of the screen for animation (adjust as needed)
    position=3  # Starting position of the sprite
    direction=1  # 1 means moving right, -1 means moving left
    
    # Define the sprite as an array of lines
    sprite_lines=(
        "          "
        "    _     "
        "  / . \   "
        " |  .  |  "
        "  \___/   "
        "          "
        "     @@   "
        "  \  ##>  "
        "   ###    "
        "  /   \   "
        "          "
        "   @_@    "
        "  \ # /   "
        "   ###    "
        "  /   \   "
    )

    # Function to reverse each line of the sprite horizontally (mirror left to right)
    reverse_sprite_horizontally() {
        for i in "${!sprite_lines[@]}"; do
            
            if [ $direction -eq 1 ]; then
                if [ $i -eq 14 ]; then    
                sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's#\\#/#; s#/#\\#' | rev)
                else
                sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's/</>/g; s#/#\\#' | rev)
                fi

            else
                 if [ $i -eq 14 ]; then  
                 sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's#\\#/#; s#/#\\#' | rev)  # Reverse each line
                 else
                 sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's/>/</g; s#\\#/#' | rev)
                 fi
            fi
        done
    }


    # Calculate spriteNum based on counter
    # New variable to decide which lines to display (0 for 1-9, 1 for 10-19, etc.)
    line_set=$((counter / 10))

    # Number of lines to display in one set (adjust this if you want to show more or fewer lines per set)
    num_lines=5  

    while true; do
        # Clear the screen each frame
        tput clear

                # Display ASCII art
        echo -e " \033[33;41mO________________________\033[0m"
        echo -e "  \033[33;41m|------------     |     |\033[0m"
        echo -e "  \033[33;41m|           |     |  o  |\033[0m"
        echo -e "  \033[33;41m|           |     |\  / |\033[0m"
        echo -e "  \033[33;41m|           |     | \o  |\033[0m"
        echo -e "  \033[33;41m|           |     | /\  |\033[0m"
        echo -e "  \033[33;41m|-----------|     |/ o\ |\033[0m"
        echo -e "  \033[33;41m|_________________|_____|\033[0m"
        # Display the time spent in a readable format
        echo "Time spent in terminal: ${hours_spent} hours and ${remaining_minutes} minutes."
        # Display the current counter value
        echo "You are level $counter"
        echo $line_set

        # Calculate the starting index for the set of lines to display
        start_idx=$((line_set * num_lines))

        # Move the cursor to the current position and print the selected lines of the sprite
        for ((i = start_idx; i < start_idx + num_lines && i < ${#sprite_lines[@]}; i++)); do
            move_cursor $((height + i - start_idx)) $position  # Adjust position dynamically based on start_idx
            echo "${sprite_lines[$i]}"
        done
        
        # Move the sprite's position
        if [ "$line_set" -ne 0 ]; then
            position=$((position + direction))
        fi
        
        # Reverse direction if the sprite reaches the edge of the screen
        if [ $position -ge $width ] || [ $position -le 3 ] && [ "$line_set" -ne 0 ]; then
            direction=$((direction * -1))
            reverse_sprite_horizontally  # Reverse the sprite horizontally when the direction changes
        fi
        
        # Delay for smooth animation
        sleep 0,5
    done
}

# Start the animation
animate_sprite



# Leg[0]="  /   \   "
# Leg[1]="   \  \   "
# Leg[2]="   \ /    "
# Leg[3]="  /  /    "

# Sprite[0]="    _     "
# Sprite[1]="  / . \   "
# Sprite[2]=" |  .  |  "
# Sprite[3]="  \___/   "
# Sprite[4]="----------"
# Sprite[5]="     @@   "
# Sprite[6]="  \  ##>  "
# Sprite[7]="   ###    "

# Sprite[9]="----------"

# animate_sprite() {
#     walkNum=0
#     while true; do
#         Sprite[8]="${Leg[walkNum]}"
#         # Clear the terminal screen
#         clear
        
#         # Display ASCII art
#         echo -e " \033[33;41mO__________________\033[0m"
#         echo -e "  \033[33;41m|___________     |\033[0m"
#         echo -e "  \033[33;41m|${Sprite[$((0 + spriteNum))]}|  o  |\033[0m"
#         echo -e "  \033[33;41m|${Sprite[1 + spriteNum]}|\  / |\033[0m"
#         echo -e "  \033[33;41m|${Sprite[2 + spriteNum]}| \o  |\033[0m"
#         echo -e "  \033[33;41m|${Sprite[3 + spriteNum]}| /\  |\033[0m"
#         echo -e "  \033[33;41m|${Sprite[4 + spriteNum]}|/ o\ |\033[0m"
#         echo -e "  \033[33;41m|________________|\033[0m"

#         # Display the current counter value
#         echo "You are level $counter"


#         # Display the time spent in a readable format
#         echo "Time spent in terminal: ${hours_spent} hours and ${remaining_minutes} minutes."


#                 # Increment walkNum to cycle through legs (loop back after 3)
#         if [ "$walkNum" -eq 3 ]; then
#             walkNum=0
#         else
#             ((walkNum++))
#         fi

#         # Delay between frames for animation effect
#         sleep 1  # Adjust this value to make the animation faster or slower
#     done
# }

# # Start the animation
# animate_sprite
