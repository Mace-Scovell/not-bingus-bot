#!/bin/bash

# Perform apt update and upgrade
sudo apt update
sudo apt upgrade -y

# Check if python3.11 or greater, python3-pip, and python3-poetry are installed
python3 --version &> /dev/null
pip3 --version &> /dev/null
poetry --version &> /dev/null

if [[ $? -ne 0 ]]; then
    # Install python3.11, python3-pip, and python3-poetry
    sudo apt install -y python3.11 python3-pip python3-poetry
fi

# Ask the user to input Discord bot token and channel ID
read -p "Enter Discord bot token: " discord_token
read -p "Enter Discord channel ID: " discord_channel_id

# Put TOKEN="Discord bot token" into .env
echo "TOKEN=$discord_token" >> .env

# Put Markov.REPLY_CHANNELS="Discord channel ID" into .env
echo "Markov.REPLY_CHANNELS=$discord_channel_id" >> .env

# Run poetry install command
poetry install

# Tell user how to start bingus bot
echo "Setup Complete! Use the command 'poetry run bingus' to start Bingus Bot."