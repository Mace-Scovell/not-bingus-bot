#!/bin/bash

# Run poetry install command
echo "Installing dependencies"
poetry install

# Check if errors were thrown by poetry
if [[ $? -ne 0 ]]; then
  echo "Error detected while installing dependencies."
  exit 1
fi

# Ask user for Discord bot token and channel ID
while true; do
  read -p "Enter Discord bot token: " token
  if [[ ! -z "$token" ]]; then
    break
  fi
done

while true; do
  read -p "Enter Discord channel ID: " channel_id
  if [[ ! -z "$channel_id" ]]; then
    break
  fi
done

# Put Discord bot token and channel ID into .env
echo "TOKEN=$token" >> .env
echo "Markov.REPLY_CHANNELS=$channel_id" >> .env

# Output success message
echo "Setup Complete! Use the command 'poetry run bingus' to start Bingus Bot."