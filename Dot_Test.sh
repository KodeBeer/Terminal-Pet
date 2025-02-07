#!/bin/bash

# Clear the screen
tput clear

# Function to move the cursor to a specific position
move_cursor() {
    tput cup $1 $2  # Moves the cursor to row $1 and column $2
}

# Function to animate a moving dot
animate_dot() {
    width=5  # Width of the screen for animation
    height=10  # Height of the screen for animation
    position=0  # Starting position of the dot
    direction=1  # 1 means moving right, -1 means moving left
    sprite="<<0<"  # Initial sprite

    while true; do
        # Clear the screen each frame (or you could choose to just update specific areas)
        tput clear
        
        # Move the cursor to the current position and display the sprite
        move_cursor $height $position
        echo -n "$sprite"
        
        # Move the dot's position
        position=$((position + direction))
        
        # Reverse direction if the dot reaches the edge of the screen
        if [ $position -ge $width ] || [ $position -le 0 ]; then
            direction=$((direction * -1))
            
            # Reverse the sprite horizontally when direction changes
            if [ $direction -eq 1 ]; then
                # Moving right
                sprite=$(echo "$sprite" | sed 's/>/</g' | rev)
            else
                # Moving left
                sprite=$(echo "$sprite" | sed 's/</>/g' | rev)
            fi
        fi
        
        # Delay for smooth animation
        sleep 1
    done
}

# Start the animation
animate_dot
