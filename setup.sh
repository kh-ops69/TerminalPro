#!/bin/sh

# later, have to add pre processing checks to ensure ollama is installed and if not, warn user and exit
# fetch a list of ollama models installed using
# ollama list

# take in input from user on command line on which model they wish to use and initialize that using
# ollama run model_name

# will probably have to check if homebrew is installed first or not 
# install jq on all systems using brew install jq 

# will have to add steps here in order to execute the following:
# nano ~/. zshrc
# add content somehow to this .zshrc file 
# source ~/.zshrc
# also have to add alias to this .zshrc file

# Add alias to ~/.zshrc
echo 'learner() { sh ~/TerminalPro/learning_script.sh "$*"; }' >> ~/.zshrc

exiterror = $?
# Check if the previous command was successful
if [ $exiterror -eq 0 ]; then
  # Reload ~/.zshrc to apply changes immediately
  source ~/.zshrc
  
  echo "Function 'learner' added and ~/.zshrc reloaded."
else
  echo "Failed to add function 'learner' to ~/.zshrc " 2>> error.txt
fi

exit 0
