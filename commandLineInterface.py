import os
import subprocess
import readline
import requests

# Store session command history
command_history = []

# LLM Integration Function
def query_llm(prompt):
    """
    Sends a prompt to an LLM API and returns the response.
    Replace this function with your LLM integration logic.
    """
    # Example API call (replace with your actual endpoint and payload)
    url = "https://api.example.com/llm"
    payload = {"prompt": prompt, "max_tokens": 200}
    response = requests.post(url, json=payload)
    return response.json().get("response", "No response from LLM")

# Function to execute commands
def execute_command(command):
    global command_history
    try:
        # Append command to history
        command_history.append(command)

        # Execute the command
        result = subprocess.run(command, shell=True, capture_output=True, text=True)

        # If command executes successfully
        if result.returncode == 0:
            print(result.stdout)
            print(f'executed successfully with output: {result.stdout}')
        else:
            # Handle errors
            print("\033[91mError:\033[0m", result.stderr.strip())  # Red text for errors
            # Query LLM for help
            llm_input = f"Command history:\n{command_history}\nError:\n{result.stderr.strip()}"
            suggestion = query_llm(llm_input)
            print("\033[93mLLM Suggestion:\033[0m", suggestion)  # Yellow text for suggestions
    except Exception as e:
        print("\033[91mCritical Error:\033[0m", str(e))  # Red text for unexpected errors

# Main loop for CLI
def cli():
    print("\033[92mCustom CLI Interface\033[0m (type 'exit' to quit)")  # Green text
    while True:
        try:
            # Display prompt
            command = input("\033[94m> \033[0m")  # Blue text for prompt
            if command.lower() in {"exit", "quit"}:
                print("Exiting CLI...")
                break
            if command.strip():
                execute_command(command)
        except KeyboardInterrupt:
            print("\nType 'exit' to quit.")
        except EOFError:
            break

if __name__ == "__main__":
    cli()