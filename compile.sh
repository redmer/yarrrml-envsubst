#!/usr/bin/env bash
set -o nounset
set -o pipefail
set -eu

# Check if a filename parameter is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Assign the parameter to a variable
FILE=$1

# Check if the file exists
if [ ! -f "$FILE" ]; then
  echo "Error: File '$FILE' not found."
  exit 1
fi

name=$(basename "$FILE" .rml.yaml)
step1="$name-1-subst.rml.yaml" # Substituted envvars
step2="/data/$name.rml.ttl" # Converted YARRRML to RML TTL

envsubst < "$FILE" > "$step1"
echo "DONE :: Substituted envvars ($step1)"
npm exec yarrrml-parser -- --pretty --input "$step1" > "$step2"
echo "DONE :: Parsed YARRRML into RML TTL ($step2)"
