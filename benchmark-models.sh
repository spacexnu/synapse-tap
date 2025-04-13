#!/usr/bin/env bash

export LC_ALL=C
MODELS=($(ollama list | awk 'NR > 1 { print $1 }'))
PROMPT="Write a function that checks if a number is prime."
API_URL="http://localhost:11434/api/generate"

echo -e "Benchmark Results"
echo -e "---------------------------------------------------------------------------------------"
printf "%-40s | %-8s | %-45s\n" "Model" "Time (s)" "Output Preview"
echo -e "---------------------------------------------------------------------------------------"

for MODEL in "${MODELS[@]}"; do
    START=$(date +%s.%N)
    RESPONSE=$(curl -s -X POST "$API_URL" \
        -H "Content-Type: application/json" \
        -d "{
              \"model\": \"$MODEL\",
              \"prompt\": \"$PROMPT\",
              \"stream\": false
            }")
    END=$(date +%s.%N)
    ELAPSED=$(echo "$END - $START" | bc)
    OUTPUT=$(echo "$RESPONSE" | jq -r '.response // ""' | head -c 45 | tr '\n' ' ')

    # Decide color based on elapsed time
    if (( $(echo "$ELAPSED < 10" | bc -l) )); then
        COLOR="\e[32m"  # Green
    elif (( $(echo "$ELAPSED < 30" | bc -l) )); then
        COLOR="\e[33m"  # Yellow
    else
        COLOR="\e[31m"  # Red
    fi
    RESET="\e[0m"
    MODEL_DISPLAY=$(echo "$MODEL" | sed 's/:latest//')

    printf "${COLOR}%-40s | %-8.2f | %-45s${RESET}\n" "$MODEL_DISPLAY" "$ELAPSED" "$OUTPUT"
done
