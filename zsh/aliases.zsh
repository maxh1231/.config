# ~/.oh-my-zsh/custom/

alias vim="/opt/homebrew/bin/nvim"
alias mongostart="brew services start mongodb-community"
alias mongostop="brew services stop mongodb-community"
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glb="git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep 'checkout:' | \
  grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[\$1]++' | head -n 10 | \
  awk -F' ~ HEAD@{' '{printf(\"  \\033[33m%s: \\033[37m %s\\033[0m\\n\", substr(\$2, 1, length(\$2)-1), \$1)}'"
alias gld='git status && git log --no-merges --color --format=" * %C(red)%h%C(reset) - %s %C(green)(%ar)%C(reset) %C(bold brightblue)<%an>%C(reset)" | fzf --ansi --layout="reverse" --preview "git diff-tree --no-commit-id --name-only -r {2}" | awk "{print \$2}" | xargs -I {} git diff {}^ {}'
alias gbs='cb=$(git branch --show-current) && { echo "$cb"; git branch --format="%(refname:short)" --sort=-committerdate | grep -v "$cb"; } | fzf --layout="reverse" | xargs -I {} git switch {}'
