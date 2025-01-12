#!/bin/bash

# Define the counter file
COUNTER_FILE="/Volumes/AMULET/shellAmulet/counter.txt"

# Check if the counter file exists
if [ ! -f "$COUNTER_FILE" ]; then
    echo 0 > "$COUNTER_FILE"  # If the file doesn't exist, initialize counter to 0
fi

# Read the current counter value from the file
counter=$(cat "$COUNTER_FILE")

# Increment the counter
((counter++))


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
