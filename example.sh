#! /bin/bash

log=/path/to/log-file
echo > $log
(
  while ! grep -q -F 'continue?' $log ; do sleep 2 ; done ; 
  output=$(<$log) 
  echo do-something "$output"
) &
# Run command with output to terminal
apt purge 2>&1 some_package | tee -a $log

# If output to terminal not needed, replace above command with
apt purge 2>&1 some_package > $log

# returns json object containing downloaded model information
curl http://localhost:11434/api/tags

curl -X GET https://jsonplaceholder.typicode.com/comments/4 | python -c "import sys,json; print json.load(sys.stdin)['email']"