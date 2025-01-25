#!/bin/sh

# Add alias to ~/.zshrc
# echo 'learner() { sh ~/TerminalPro/learning_script.sh "$*"; }' >> ~/.zshrc

# # Reload ~/.zshrc to apply changes immediately
# source ~/.zshrc

# echo "Function 'learner' added and ~/.zshrc reloaded."

# echo 'learner() { sh ~/TerminalPro/learning_script.sh "$*"; }' >> ~/.zshrc

# check system info and select smallest model for generation- allow user to change this behaviour using custom flag
# add case statement for the same

# availableModels=$(ollama list) # Fetch the output of the command

# # Split the output into an array, with each line being an element
# IFS=$'\n' read -d '' -r -a models_array <<< "$availableModels"

# # Access the first element of the array
# echo "First line: ${availableModels[1]}"

# unset IFS
# memInfo=$(top -l 1 | grep PhysMem)
# read -a memInfoArray <<< "$memInfo"
# availableMem=${memInfoArray[1]}
# referenceVar=availableMem
# for model in "${models_array[@]}"; do
#     # echo "$line"
#     read -a modelinfoarray <<< "$model"
#     modelName="${modelinfoarray[0]}"
#     modelSize="${modelinfoarray[2]}"
#     curDifference=$(($availableMem-$modelSize))
#     if $referenceVar>$curDifference && curDifference<=((25/100*$availableMem)):
#     referenceVar=$(($availableMem-modelSize))
#     bestModel=$modelName
#     fi
# done

# echo "Best Model given current memory, is: $bestModel" 


# Fetch the output of the command
availableModels=$(ollama list)

# Split the output into an array, with each line being an element
IFS=$'\n' read -d '' -r -a models_array <<< "$availableModels"

# Access the first element of the array (for testing/debugging)
echo "First line: ${models_array[2]}"

# Get memory info
unset IFS
memInfo=$(top -l 1 | grep PhysMem)
read -a memInfoArray <<< "$memInfo"
availableMem=${memInfoArray[1]%M}

# Extract only the numeric part of available memory (assuming it's in MB or GB)
# availableMem=$(echo "$availableMem" | grep -oE '[0-9]+')

# Initialize variables
# referenceVar=$availableMem
referenceVar=$(echo "$availableMem * -1" | bc -l) 
bestModel=""

# Loop through models and find the best one
for model in "${models_array[@]}"; do
    # Parse the model info into an array
    read -a modelinfoarray <<< "$model"

    # Extract model name and size
    modelName="${modelinfoarray[0]}"
    modelSize="${modelinfoarray[2]}"
    modelSize=$(echo "$modelSize" | awk '{printf "%.0f\n", $1}' | awk '{print $1 * 1024}')

    # Extract only numeric part of model size (assuming it's in MB or GB)
    # modelSize=$(echo "$modelSize" | grep -oE '[0-9]+')

    # Skip if modelSize is not a valid number
    if [[ -z "$modelSize" ]]; then
        continue
    fi

    # Calculate difference between available memory and model size
    curDifference=$(($availableMem - $modelSize))

    # Check conditions
    if (( $curDifference > $referenceVar && $curDifference >= (30 * $availableMem / 100) )); then
        referenceVar=$curDifference
        bestModel=$modelName
    fi
done

# Output the best model
echo "Best Model given current memory, is: $bestModel"

# model=${models_array[1]}
# read -a modelinfoarray <<< "$model"
# # retreive the top model (stored in model variable) and its size is at the second index 
# echo "${modelinfoarray[2]}"

# # get memory information
# echo "$(top -l 1 | grep PhysMem)"
# memInfo=$(top -l 1 | grep PhysMem)
# read -a memInfoArray <<< "$memInfo"
# echo "${memInfoArray[1]}"


# Print all elements of the array for verification
# echo "Full array:"

# declare -p responsestr

# echo 'help () {
#     ~/TerminalPro/terminal_helper.sh "$@"
# }
# source ~/.bash_profile' >> ~/.zshrc

# echo parameter "(block of text)" passed were $1

# time=$(date +%H:%m:%S)

# echo "and current time is $time"

# read -p "Enter some example text: " example

# echo "Your entered text was: $example"



# while read line; do
# echo "$line"
# done < <(ls $HOME)

exit 0 
