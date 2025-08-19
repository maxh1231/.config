#!/bin/bash

brew tap FelixKratz/formulaebrew 

brew install --cask nikitabobko/tap/aerospace
brew install bat
brew install borders
brew install deno
brew install fzf
brew install git-delta
brew install --cask ghostty
brew install luarocks
brew install neovim
brew install node
brew install pnpm
brew install powerlevel10k
brew install qmk/qmk/qmk
brew install ripgrep
brew install sketchybar
brew install tmux
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

npm install -g @anthropic-ai/claude-code
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/kvndrsslr/sketchybar-app-font.git && cd sketchybar-app-font && pnpm install && pnpm run build:install && cd
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)




