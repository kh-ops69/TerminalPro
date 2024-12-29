import subprocess

# Your command
command = "ps aux | sort -nrk 4 | head -n 10"
command2 = 'netstat -an | grep LISTEN'
command3 = 'wc -lwm test/example.txt'

# Run the command
try:
    result = subprocess.run(command, shell=True, text=True, capture_output=True, executable="/bin/bash")
    print("=== STDOUT ===")
    print(result.stdout.strip())  # Print standard output
    print("=== STDERR ===")
    print(result.stderr.strip())  # Print standard error
    print("=== RETURN CODE ===")
    print(result.returncode)  # Check the return code
except Exception as e:
    print(f"Error occurred: {e}")