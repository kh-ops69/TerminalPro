#!/bin/zsh

# Store the process ID file
PID_FILE="$HOME/.terminal_assistant.pid"
ERROR_LOG="$HOME/.terminal_error.log"
LAST_CMD_FILE="$HOME/.last_command.tmp"

# Function to send curl request with given prompt
send_curl_request() {
    local prompt="$1"
    curl http://localhost:11434/api/generate -d "{
        \"model\": \"llama3.1\",
        \"prompt\": \"$prompt\",
        \"stream\": false
    }" 2>/dev/null
}

# Function to handle help commands
handle_help() {
    local command="$1"
    if [[ "$command" == "help "* ]]; then
        local help_query="${command#help }"
        send_curl_request "$help_query"
        return 0
    fi
    return 1
}

# Function to get last command's exit status and error output
handle_command_error() {
    local exit_status=$?
    if [ $exit_status -ne 0 ]; then
        # Get successful commands from current session
        local successful_commands=$(fc -l -n 1 | grep -v "exit status [1-9]" | tail -n 10)
        
        # Get last error output
        local error_output=$(tail -n 10 "$ERROR_LOG" 2>/dev/null)
        
        # Construct the prompt
        local prompt="Context of successful commands: $successful_commands
Last error encountered: $error_output
Please help fix this error."
        
        send_curl_request "$prompt"
    fi
}

# Function to execute before each command
preexec() {
    echo "$1" > "$LAST_CMD_FILE"
}

# Function to execute after each command
precmd() {
    if [ -f "$LAST_CMD_FILE" ]; then
        local last_cmd=$(cat "$LAST_CMD_FILE")
        
        # Handle 'exit term' command
        if [[ "$last_cmd" == "exit term" ]]; then
            rm -f "$PID_FILE" "$LAST_CMD_FILE" 2>/dev/null
            exit 0
        fi
        
        # Handle help command
        handle_help "$last_cmd" || handle_command_error
        
        rm "$LAST_CMD_FILE"
    fi
}

# Set up error logging (simplified)
exec 2>> "$ERROR_LOG"

# Add the hook functions to zsh
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec
add-zsh-hook precmd precmd

# Create PID file
echo $$ > "$PID_FILE"