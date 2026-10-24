![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

# 👾 Termux Hacker Theme & Autosuggestions

A complete Kali Linux-style setup for Termux with Matrix rain, custom prompt, autosuggestions, and syntax highlighting.

### 📸 Preview

<div align="center">
  <img src="images/screenshot-1.jpg" width="300" alt="Matrix Rain">
  <img src="images/screenshot-2.jpg" width="300" alt="Hacker Banner">
</div>

## ✨ Features
- Matrix rain on startup (3.5s)
- Hacker-style ASCII banner
- Zsh autosuggestions (like Fish/Kali)
- Syntax highlighting (Blue commands, Cyan paths)
- Useful aliases (`cls`, `ll`, `..`, etc.)
- `Ctrl+R` fuzzy history search (fzf)
- Removes default Termux welcome message

## 🚀 Installation

Copy and paste this single command in Termux:

```bash
pkg install git -y && git clone https://github.com/souravpaul-ind/termux-hacker-theme.git && cd termux-hacker-theme && bash setup.sh
```

⌨️ Shortcuts
cls : Clear screen

ll : List files

.. : Go back

Ctrl + R : Search history

Right Arrow / Space : Accept autosuggestion

## 📄 License

This project is licensed under the **MIT License**. 
See the [LICENSE](LICENSE) file for more details.
