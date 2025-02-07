#!/bin/bash

# Clear the screen
tput clear

# Function to move the cursor to a specific position
move_cursor() {
    tput cup $1 $2  # Moves the cursor to row $1 and column $2
}

# Function to animate a moving sprite (entire sprite moves together)
animate_sprite() {
    width=9  # Width of the screen for animation
    height=2  # Height of the screen for animation (adjust as needed)
    position=3  # Starting position of the sprite
    direction=1  # 1 means moving right, -1 means moving left
    
    # Define the sprite as an array of lines
    sprite_lines=(
        "          "
        "     @@   "
        "  \  ##>  "
        "   ###    "
        "  /   \   "
    )





    # Function to reverse each line of the sprite horizontally (mirror left to right)
    reverse_sprite_horizontally() {
        for i in "${!sprite_lines[@]}"; do
            
            if [ $direction -eq 1 ]; then
                if [ $i -eq 4 ]; then    
                sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's#\\#/#; s#/#\\#' | rev)
                else
                sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's/</>/g; s#/#\\#' | rev)
                fi

            else
                 if [ $i -eq 4 ]; then  
                 sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's#\\#/#; s#/#\\#' | rev)  # Reverse each line
                 else
                 sprite_lines[$i]=$(echo "${sprite_lines[$i]}" | sed 's/>/</g; s#\\#/#' | rev)
                 fi
            fi
        done
    }

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
        
        # Move the cursor to the current position and print all lines of the sprite
        for ((i = 0; i < ${#sprite_lines[@]}; i++)); do
            move_cursor $((height + i)) $position
            echo "${sprite_lines[$i]}"
        done
        
        # Move the sprite's position
        position=$((position + direction))
        
        # Reverse direction if the sprite reaches the edge of the screen
        if [ $position -ge $width ] || [ $position -le 3 ]; then
            direction=$((direction * -1))
            reverse_sprite_horizontally  # Reverse the sprite horizontally when the direction changes
        fi
        
        # Delay for smooth animation
        sleep 0,5
    done
}

# Start the animation
animate_sprite
