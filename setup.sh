#!/bin/bash

# Check if python3.11 or greater is installed
python3 -V &> /dev/null
if [[ $? -ne 0 ]]; then
  printf "Installing Python3.11\n"
  sudo apt install -y -qq python3.11
  printf "\n"
else
  printf "Python 3.11 or greater already installed - Skipping\n"
fi

# Check if python3-poetry is installed
poetry -V &> /dev/null
if [[ $? -ne 0 ]]; then
  printf "Installing Poetry\n"
  sudo apt install -y -qq python3-poetry
  printf "\n"
else
  echo "Poetry already installed - Skipping"
fi

# Run poetry install command
echo "Installing dependencies"
poetry install &> /dev/null

# Check if errors were thrown by poetry
if [[ $? -ne 0 ]]; then
  echo "Error detected while installing. Running setup.sh as root can cause issues."
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