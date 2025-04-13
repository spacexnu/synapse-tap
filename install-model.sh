#!/bin/bash

if ! pgrep -f "ollama" > /dev/null; then
    echo "🔌 Ollama is not running. Starting it in the background..."
    nohup ollama serve > /dev/null 2>&1 &
    sleep 2
else
    echo "✅ Ollama is already running."
fi

MODEL=$1
BASE_DIR="$HOME/.ollama/models/$MODEL"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || exit

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
    echo "❌ Invalid model name: $MODEL"
    echo "Available options: openhermes, deepseek-coder, phi"
    exit 1
    ;;
esac

echo "📦 Downloading model: $MODEL"
curl -L -o "$FILE" "$URL"

echo "🧱 Creating Modelfile..."
cat <<EOF > Modelfile
FROM $FILE

TEMPLATE """<|system|>
You are a helpful coding assistant.
<|user|>
{{ .prompt }}
<|assistant|>
"""

EOF

echo "🧠 Registering model in Ollama..."
ollama create "$MODEL" -f Modelfile

echo "🚀 Launching model..."
ollama run "$MODEL"
