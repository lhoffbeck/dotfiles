# Prompt

# Keep it simple when Emacs is connecting

if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  if whence -w precmd >/dev/null; then
      unfunction precmd
  fi
  if whence -w preexec >/dev/null; then
      unfunction preexec
  fi
  PS1='$ '
  return
fi

# Interactive prompt

autoload -Uz vcs_info
precmd_functions+=( vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '%F{200}[%b%u%c]%f'
zstyle ':vcs_info:*' enable git

ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.aliases
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port-number>"
        return 1
    fi
    kill -9 $(lsof -i4:$1 -t)
}