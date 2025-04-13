#!/usr/bin/env bash

export LC_ALL=C

# Função para pegar RAM usada pelo processo do Ollama (em MB)
get_memory_usage_mb() {
    ps -o rss= -p $(pgrep -f "ollama serve") | awk '{sum += $1} END {print int(sum/1024)}'
}

MODELS=($(ollama list | awk 'NR > 1 { print $1 }'))
PROMPT="Write a Python function named is_prime that returns True if a number is prime and False otherwise."
API_URL="http://localhost:11434/api/generate"

echo -e "Benchmark Results"
echo -e "---------------------------------------------------------------------------------------------------------------"
printf "%-32s | %-8s | %-10s | %-45s\n" "Model" "Time (s)" "RAM (MB)" "Output Preview"
echo -e "---------------------------------------------------------------------------------------------------------------"

for MODEL in "${MODELS[@]}"; do
    MODEL_DISPLAY=$(echo "$MODEL" | sed 's/:latest//')

    MEMORY_BEFORE=$(get_memory_usage_mb)
    START=$(date +%s.%N)

    RESPONSE=$(curl -s -X POST "$API_URL" \
        -H "Content-Type: application/json" \
        -d "{
              \"model\": \"$MODEL\",
              \"prompt\": \"$PROMPT\",
              \"stream\": false
            }")

    END=$(date +%s.%N)
    MEMORY_AFTER=$(get_memory_usage_mb)

    MEMORY_USED=$((MEMORY_AFTER - MEMORY_BEFORE))
    ELAPSED=$(echo "$END - $START" | bc)
    OUTPUT=$(echo "$RESPONSE" | jq -r '.response // ""' | head -c 45 | tr '\n' ' ')

    # Cor baseada no tempo
    if (( $(echo "$ELAPSED < 10" | bc -l) )); then
        COLOR="\e[32m"  # Verde
    elif (( $(echo "$ELAPSED < 30" | bc -l) )); then
        COLOR="\e[33m"  # Amarelo
    else
        COLOR="\e[31m"  # Vermelho
    fi
    RESET="\e[0m"

    printf "${COLOR}%-32s | %-8.2f | %-10s | %-45s${RESET}\n" "$MODEL_DISPLAY" "$ELAPSED" "$MEMORY_USED" "$OUTPUT"
done