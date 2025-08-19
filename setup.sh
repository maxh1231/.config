#!/bin/bash

ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.config/zsh/.zprofile" "$HOME/.zprofile"
ln -sf "$HOME/.config/zsh/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
ln -sf "$HOME/.config/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

ln -sf "$HOME/.config/.vscode/extensions/extensions.json" "$HOME/.vscode/extensions/extensions.json"
ln -sf "$HOME/.config/.vscode/User/settings.json" "$HOME/.vscode/User/settings.json"

ln -sf "$HOME/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/.config/tmux/.tmux-cht-languages" "$HOME/.tmux-cht-languages"
ln -sf "$HOME/.config/tmux/.tmux-cht-command" "$HOME/.tmux-cht-command"

link_script() {
    local src="$HOME/.config/tmux/$1"
    local target="$HOME/.local/bin/$1"

    if [ ! -e "$src" ]; then
        echo "$1 not found"
        return
    fi

    chmod +x "$src"

    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "$target already exists."
    else 
        ln -s "$src" "$target"
        echo "Symlink created at $target"
    fi
}

link_script "tmux-cht.sh"
link_script "tmux-sessionizer"

cp -L "$HOME/.config/.gitconfig" "$HOME/.gitconfig"

ln -sf "$HOME/.config/.claude/settings.json" "$HOME/.claude/"
