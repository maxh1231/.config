#!/bin/bash

ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.config/zsh/.zprofile" "$HOME/.zprofile"
ln -sf "$HOME/.config/zsh/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
ln -sf "$HOME/.config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

ln -sf "$HOME/.config/.vscode/extensions/extensions.json" "$HOME/.vscode/extensions/extensions.json"

ln -sf "$HOME/.config/.vscode/User/settings.json" "$HOME/.vscode/User/settings.json"

cp -L "$HOME/.config/.gitconfig" "$HOME/.gitconfig"
