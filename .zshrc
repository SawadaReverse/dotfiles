# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# prezto theme
autoload -Uz promptinit
promptinit
prompt pure

# japanese input settings
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# original alias
alias ll="ls -lAh"

# anyenv settings
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"