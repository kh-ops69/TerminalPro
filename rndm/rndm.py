# import argparse

# help_dict = {
#     "list": "Use this command to list items.",
#     "show": "Use this command to show details of an item.",
#     "add": "Use this command to add a new item."
# }

# # Function to show help for a specific command - placeholder - add ollama integration
# def show_help(command):
    
#     # Fetch help message based on the command
#     if command in help_dict:
#         print(help_dict[command])
#     else:
#         print(f"Sorry, no help available for '{command}'.")

# # Main function to parse arguments
# def main_func():
#     parser = argparse.ArgumentParser(prog='rndm')
#     subparsers = parser.add_subparsers(dest='command')

#     # 'help' sub-command
#     help_parser = subparsers.add_parser('help', help='Get help for a command')
#     help_parser.add_argument('command', type=str, help='The command you need help with')

#     # Parse arguments
#     args = parser.parse_args()

#     # Check if the 'help' command was used
#     if args.command in help_dict:
#         show_help(args.command)
#     else:
#         print(f"Unknown command: {args.command}")

# # placeholder function - first check if ollama is installed and user has locally installed models available
# def greeting():
#     return "ai tracking available"

import argparse
from rndm import package_help  # Import the help dictionary

# Function to display help for the entire package
def show_all_help():
    print("Available commands and their functionalities:")
    for command, description in package_help.items():
        print(f"  {command}: {description}")

# Function to show help for a specific command
def show_help(command):
    if command in package_help:
        print(f"{command}: {package_help[command]}")
    else:
        print(f"Sorry, no help available for '{command}'.")

# Placeholder function
def greeting():
    return "AI tracking available"

# Main function
def main_func():
    parser = argparse.ArgumentParser(prog='rndm', description='A random package for various utilities.')
    parser.add_argument('-help', action='store_true', help='Show all available commands and their descriptions.')
    subparsers = parser.add_subparsers(dest='command', help='Subcommands')

    # 'help' sub-command
    help_parser = subparsers.add_parser('help', help='Get help for a specific command')
    help_parser.add_argument('command', type=str, nargs='?', help='The command you need help with')

    # 'greet' sub-command
    subparsers.add_parser('greet', help='Check AI tracking availability')

    args = parser.parse_args()

    # Handle '-help' flag
    if args.help:
        show_all_help()
        return

    # Dispatch commands
    if args.command == 'help' and args.command:
        show_help(args.command)
    elif args.command == 'greet':
        print(greeting())
    else:
        print(f"Unknown or missing command: {args.command}. Use '-help' for available commands.")