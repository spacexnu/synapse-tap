```
░█▀▀░█░█░█▀█░█▀█░█▀█░█▀▀░█▀▀░▀█▀░█▀█░█▀█
░▀▀█░░█░░█░█░█▀█░█▀▀░▀▀█░█▀▀░░█░░█▀█░█▀▀
░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀░▀░▀░░
   
   SYNAPSE TAP — local LLM assistant
```
# Synapse Tap

*A local LLM-powered coding assistant built for hackers, rebels, and cypherpunks.*

---

## 🧠 What is Synapse Tap?

**Synapse Tap** is your offline coding copilot. It taps into the intelligence of open-source large language models (LLMs) running entirely on your machine — no data leaks, no tokens, no Big Brother.

- 🛠 Powered by [Ollama](https://ollama.com/) or [LM Studio](https://lmstudio.ai/)
- ⚡ Integrated with [Continue](https://continue.dev/) for JetBrains IDEs (IntelliJ, PyCharm, etc.) and VS Code
- 🔒 100% offline & private — nothing leaves your Mac
- 🧬 Supports models like **OpenHermes**, **Mistral**, **CodeLlama**, **Phi-2**, and more
- 🧰 Works great on **Apple Silicon with 16GB RAM** or higher

---

## 🧪 Features

- Run LLMs locally using lightweight quantized models (GGUF)
- Ask questions about your code directly in your IDE
- Refactor, explain, debug or generate new code
- Full control over which model runs and how it's prompted

---

## ⚙️ Setup Guide

### 1. Install Ollama
```bash
brew install ollama
```

### 2. Run a model (e.g., OpenHermes or Mistral)
```bash
ollama run openhermes
# or
ollama run mistral
```

#### Testing openhermes and it don't look to work well for this project's purpose. Be advised.

### 3. Install Continue plugin in JetBrains IDE
- Open **Preferences > Plugins**
- Search for `Continue` and install it
- Restart your IDE

### 4. Configure Continue
Go to:
```
Preferences > Tools > Continue
```
And add this configuration:
```json
{
  "models": [
    {
      "title": "OpenHermes (local)",
      "model": "ollama:openhermes",
      "apiBase": "http://localhost:11434"
    }
  ]
}
```

---

## 💡 Recommended Models

| Model            | Size (4-bit) | Good for               |
|------------------|--------------|------------------------|
| `openhermes`     | ~4.1GB       | Code + chat, main model|
| `mistral`        | ~4GB         | General + code         |
| `codellama`      | ~3.5GB       | Code generation        |
| `phi-2`          | ~1.5GB       | Light Q&A, small tasks |
| `dolphin-mistral`| ~4GB         | Code + chat            |

---

## 🔧 Installation Scripts

You can automate the installation of supported models using a single command:

### Bash:
```bash
./install-model.sh <model-name>
```

### Fish Shell:
```fish
./install-model.fish <model-name>
```

**Supported model names:** `openhermes`, `deepseek-coder`, `phi`

Each script will:
- Download the appropriate `.gguf` model from Hugging Face
- Generate a `Modelfile` for Ollama
- Register the model
- Launch the model

Example:
```bash
./install-model.sh openhermes
```

---

## 📊 Benchmark Script

You can compare the performance of installed models using:

```bash
./benchmark-models.sh
```

This will:
- Send the same prompt to each model
- Measure total response time
- Extract tokens/second from Ollama's response
- Print a formatted table in your terminal

Output example:
```
Benchmark Results
---------------------------------------------------------------------------------------------------------------
Model                             | Time (s) | RAM (MB)   | Output Preview
---------------------------------------------------------------------------------------------------------------
dolphin-mistral                   | 17.00    | 16         | Here's the implementation of the is_prime fun
openhermes-strict                 | 28.00    | 2          | Hello! I'm here to help you with any question
qwen:1.8b                         | 9.00     | 60         | Here's the Python function `is_prime` that ch
phi                               | 7.00     | 10         |  def is_prime(n):     # Check if n is less th
codellama                         | 14.00    | 4          | [PYTHON] def is_prime(n):     if n < 2:
nous-hermes                       | 6.00     | 0          |  def is_prime(num):     """This function chec
llama3                            | 28.00    | 39         | Here is a Python function named `is_prime` th
mistral                           | 28.00    | 1          |  Here is a simple implementation of the is_pr
qwen2.5-coder:1.5b-instruct-q4_K_S| 7.00     | 12         | ```python def is_prime(n):     # Check if the
llama3.1:8b                       | 38.00    | 12         | **is_prime Function** =====================
qwen2.5-coder:1.5b                | 7.00     | 8          | ```python def is_prime(number):     """Check
```

_Most models can be installed directly by openllama or LM Studio._

---

## 🖥 Optional: Use with LM Studio

If you prefer a GUI, you can also run OpenHermes or other GGUF models using [LM Studio](https://lmstudio.ai):
- Download the `.gguf` model file
- Launch it with a single click
- No terminal required

---

## 🕶 Philosophy
> "Privacy is not a luxury. It's your right as a developer." — Synapse Tap

---

## 📦 License
BSD 3-Clause

## ☠️ Disclaimer
This is a rogue, offline-friendly AI assistant. If you're being watched... well, now you aren't.
