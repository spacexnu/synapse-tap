#!/usr/bin/env fish

set model_name openhermes-lite
set model_dir "$HOME/.ollama/models/$model_name"
set gguf_url "https://huggingface.co/TheBloke/OpenHermes-2.5-Mistral-7B-GGUF/resolve/main/openhermes-2.5-mistral-7b.Q4_K_S.gguf"
set gguf_file "$model_dir/openhermes-2.5-mistral-7b.Q4_K_S.gguf"

mkdir -p $model_dir
cd $model_dir

curl -L -o (basename $gguf_file) $gguf_url

echo 'FROM '(basename $gguf_file) >Modelfile
echo '' >>Modelfile
echo 'TEMPLATE """<|system|>' >>Modelfile
echo 'You are a helpful coding assistant.' >>Modelfile
echo '<|user|>' >>Modelfile
echo '{{ prompt }}' >>Modelfile
echo '<|assistant|>' >>Modelfile
echo '"""' >>Modelfile
echo '' >>Modelfile
echo 'PARAMETER context_length 2048' >>Modelfile

ollama create $model_name -f Modelfile

ollama run $model_name
