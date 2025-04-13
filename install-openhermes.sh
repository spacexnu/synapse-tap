#!/bin/bash

MODEL_NAME="openhermes-lite"
MODEL_DIR="$HOME/.ollama/models/$MODEL_NAME"
GGUF_URL="https://huggingface.co/TheBloke/OpenHermes-2.5-Mistral-7B-GGUF/resolve/main/openhermes-2.5-mistral-7b.Q4_K_S.gguf"
GGUF_FILE="$MODEL_DIR/openhermes-2.5-mistral-7b.Q4_K_S.gguf"

mkdir -p "$MODEL_DIR"
cd "$MODEL_DIR" || exit

curl -L -o "$(basename "$GGUF_FILE")" "$GGUF_URL"

cat <<EOF > Modelfile
FROM $(basename "$GGUF_FILE")

TEMPLATE """<|system|>
You are a helpful coding assistant.
<|user|>
{{ prompt }}
<|assistant|>
"""

PARAMETER context_length 2048
EOF

ollama create "$MODEL_NAME" -f Modelfile

ollama run "$MODEL_NAME"
