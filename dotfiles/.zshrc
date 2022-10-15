# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Git password manager settings for KDE
export GIT_ASKPASS='/usr/bin/ksshaskpass'

# prezto theme
autoload -Uz promptinit
promptinit
prompt pure

# japanese input settings
export GTK_IM_MODUL=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

# original alias
alias ll="ls -lAh"

# anyenv settings
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
