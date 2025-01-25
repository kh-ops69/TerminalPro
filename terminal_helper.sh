#!/bin/bash

# echo "Script reading started"

# Prompt user for input
# read -p "What do you want help with: " prompt
prompt="$*"

# Use proper JSON formatting and variable interpolation
ollamacom=$(curl -s http://localhost:11434/api/generate -d "{
    \"model\": \"llama3.2:1b\",
    \"prompt\": \"$prompt\",
    \"stream\": false
}" | jq -r '.response')

echo "$ollamacom"

exit 0

# add kill pid command before exiting, this consumes a lot of battery running as a background process and can catch users unawares
# pkill -9 "bash"

# also add code that retrieves current super directory structure containing all directories that user has access to, and to which he does not 
# have access to, send this as a hardcoded prompt/ system template etc. to locally running llm