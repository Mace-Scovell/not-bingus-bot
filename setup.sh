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

# Check if curl is installed
curl -V &> /dev/null
if [[ $? -ne 0 ]]; then
  printf "Installing Curl\n"
  sudo apt install -y -qq curl
  printf "\n"
else
  printf "Curl already installed - Skipping\n"
fi

# Check if python3-poetry is installed
poetry -V &> /dev/null
if [[ $? -ne 0 ]]; then
  printf "Installing Poetry\n"
  curl -sSL https://install.python-poetry.org | python3 -
  printf "\n"
else
  echo "Poetry already installed - Skipping"
fi

# Update Path to include Poetry
export PATH="$HOME/.local/bin:$PATH"

# Refresh Source to allow using Poetry
source $HOME/.bashrc

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
echo "Setup Complete!"
echo "Add Poetry's bin directory to your PATH environment variable:"
echo 'export PATH="$HOME/.local/bin:$PATH"'
echo "Make sure to refresh your console:"
echo 'source $HOME/.bashrc'
echo "Use the command 'poetry run bingus' to start Bingus Bot."