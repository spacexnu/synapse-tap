#!/usr/bin/env fish

set MODEL $argv[1]
if test -z "$MODEL"
    echo "❌ Usage: ./install-model.fish <model-name>"
    echo "Available models: openhermes, deepseek-coder, phi, dolphin-mistral"
    exit 1
end

set STRICT_NAME "$MODEL-strict"
set BASE_DIR "$HOME/.ollama/models/$STRICT_NAME"
mkdir -p $BASE_DIR
cd $BASE_DIR

switch $MODEL
    case openhermes
        set FILE "openhermes-2.5-mistral-7b.Q4_K_S.gguf"
        set URL "https://huggingface.co/TheBloke/OpenHermes-2.5-Mistral-7B-GGUF/resolve/main/$FILE"
    case deepseek-coder
        set FILE "deepseek-coder-1.3b-instruct.Q4_K_M.gguf"
        set URL "https://huggingface.co/TheBloke/deepseek-coder-1.3b-instruct-GGUF/resolve/main/$FILE"
    case phi
        set FILE "phi-2.Q4_K_M.gguf"
        set URL "https://huggingface.co/TheBloke/phi-2-GGUF/resolve/main/$FILE"
    case '*'
        echo "❌ Unknown model: $MODEL"
        exit 1
end

echo "📦 Downloading model: $MODEL"
curl -L -o $FILE $URL

echo "🧱 Creating strict Modelfile..."
echo "FROM $FILE" > Modelfile
echo "" >> Modelfile
echo 'TEMPLATE """<|user|>' >> Modelfile
echo '{{ .prompt }}' >> Modelfile
echo '<|assistant|>' >> Modelfile
echo '"""' >> Modelfile

echo "🧠 Registering model '$STRICT_NAME' in Ollama..."
ollama create $STRICT_NAME -f Modelfile

echo "🚀 Launching model..."
ollama run $STRICT_NAME