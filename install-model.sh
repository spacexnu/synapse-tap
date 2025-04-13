#!/bin/bash

export LC_ALL=C

MODEL=$1
if [[ -z "$MODEL" ]]; then
  echo "❌ Usage: ./install-model.sh <model-name>"
  echo "Available models: openhermes, deepseek-coder, phi, dolphin-mistral"
  exit 1
fi

STRICT_NAME="${MODEL}-strict"
BASE_DIR="$HOME/.ollama/models/$STRICT_NAME"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || exit

# Model URLs
case $MODEL in
openhermes)
  FILE="openhermes-2.5-mistral-7b.Q4_K_S.gguf"
  URL="https://huggingface.co/TheBloke/OpenHermes-2.5-Mistral-7B-GGUF/resolve/main/$FILE"
  ;;
deepseek-coder)
  FILE="deepseek-coder-1.3b-instruct.Q4_K_M.gguf"
  URL="https://huggingface.co/TheBloke/deepseek-coder-1.3b-instruct-GGUF/resolve/main/$FILE"
  ;;
phi)
  FILE="phi-2.Q4_K_M.gguf"
  URL="https://huggingface.co/TheBloke/phi-2-GGUF/resolve/main/$FILE"
  ;;
*)
  echo "❌ Unknown model: $MODEL"
  exit 1
  ;;
esac

echo "📦 Downloading model: $MODEL"
curl -L -o "$FILE" "$URL"

echo "🧱 Creating strict Modelfile..."
cat <<EOF >Modelfile
FROM $FILE

TEMPLATE """<|user|>
{{ .prompt }}
<|assistant|>
"""
EOF

echo "🧠 Registering model '$STRICT_NAME' in Ollama..."
ollama create "$STRICT_NAME" -f Modelfile

echo "🚀 Launching model..."
ollama run "$STRICT_NAME"
