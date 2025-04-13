#!/usr/bin/env fish

if not pgrep -f ollama >/dev/null
    echo "🔌 Ollama is not running. Starting it in the background..."
    nohup ollama serve >/dev/null 2>&1 &
    sleep 2
else
    echo "✅ Ollama is already running."
end

set MODEL $argv[1]
set BASE_DIR "$HOME/.ollama/models/$MODEL"
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
        echo "❌ Invalid model name: $MODEL"
        echo "Available options: openhermes, deepseek-coder, phi"
        exit 1
end

echo "📦 Downloading model: $MODEL"
curl -L -o $FILE $URL

echo "🧱 Creating Modelfile..."
echo "FROM $FILE" >Modelfile
echo "" >>Modelfile
echo 'TEMPLATE """<|system|>' >>Modelfile
echo 'You are a helpful coding assistant.' >>Modelfile
echo '<|user|>' >>Modelfile
echo '{{ .prompt }}' >>Modelfile
echo '<|assistant|>' >>Modelfile
echo '"""' >>Modelfile
echo "" >>Modelfile

echo "🧠 Registering model in Ollama..."
ollama create $MODEL -f Modelfile

echo "🚀 Launching model..."
ollama run $MODEL
