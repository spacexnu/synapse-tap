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
- 🧰 Works great on **Mac M1/M2 with 16GB RAM** or higher

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

| Model          | Size (4-bit) | Good for              |
|----------------|--------------|------------------------|
| `openhermes`   | ~4.1GB       | Code + chat, main model|
| `mistral`      | ~4GB         | General + code         |
| `codellama`    | ~3.5GB       | Code generation        |
| `phi-2`        | ~1.5GB       | Light Q&A, small tasks |
| `dolphin-mistral` | ~4GB      | Code + chat            |

---

## 🔧 Installation Scripts

You can automate the installation of OpenHermes with:

### Bash:
```bash
./install-openhermes-lite.sh
```

### Fish Shell:
```fish
./install-openhermes-lite.fish
```

These scripts will:
- Download the GGUF file
- Create the appropriate `Modelfile`
- Register the model with Ollama
- Launch the model automatically

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
