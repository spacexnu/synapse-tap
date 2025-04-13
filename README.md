```
░█▀▀░█░█░█▀█░█▀█░█▀█░█▀▀░█▀▀░▀█▀░█▀█░█▀█
░▀▀█░░█░░█░█░█▀█░█▀▀░▀▀█░█▀▀░░█░░█▀█░█▀▀
░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀░▀░▀░░
   
   SYNAPSE TAP — local LLM assistant
```

*A local LLM-powered coding assistant built for hackers, rebels, and cypherpunks.*

---

## 🧠 What is Synapse Tap?

**Synapse Tap** is your offline coding copilot. It taps into the intelligence of open-source large language models (LLMs) running entirely on your machine — no data leaks, no tokens, no Big Brother.

- 🛠 Powered by [Ollama](https://ollama.com/)
- ⚡ Integrated with [Continue](https://continue.dev/) for JetBrains IDEs (IntelliJ, PyCharm, etc.)
- 🔒 100% offline & private — nothing leaves your Mac
- 🧬 Supports models like **Mistral**, **CodeLlama**, **Phi-2**, and more
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

### 2. Run a model (e.g., CodeLlama or Mistral)
```bash
ollama run codellama
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
      "title": "Codellama (local)",
      "model": "ollama:codellama",
      "apiBase": "http://localhost:11434"
    }
  ]
}
```

---

## 💡 Recommended Models

| Model          | Size (4-bit) | Good for              |
|----------------|--------------|------------------------|
| `mistral`      | ~4GB         | General + code         |
| `codellama`    | ~3.5GB       | Code generation        |
| `phi-2`        | ~1.5GB       | Light Q&A, small tasks |
| `dolphin-mistral` | ~4GB      | Code + chat            |

---

## 🕶 Philosophy
> "Privacy is not a luxury. It's your right as a developer." — Synapse Tap

---

## 📦 License
MIT

## ☠️ Disclaimer
This is a rogue, offline-friendly AI assistant. If you're being watched... well, now you aren't.

