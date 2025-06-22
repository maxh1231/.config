# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

plugins=(git)

# Set up paths
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH=$PATH:/Library/Java/JavaVirtualMachines/jdk-23.jdk/Contents/Home
export PATH=~/.local/bin/:$PATH

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Custom fzf config
source "$HOME/.config/.fzfrc"

# Enable syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# configs
export DOCKER_CONFIG="$HOME/.config/.docker"
export GRADLE_USER_HOME="$HOME/.config/.gradle"
export GIT_EDITOR="nvim"
