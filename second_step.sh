#!/usr/bin/zsh

# stop script if return code is not 0 or use undefined vars
set -eu

# disable 'zsh: no match found' error
setopt nonomatch

source ~/.zshrc

echo '
###########
anyenv-update install
###########
'

mkdir -p $(anyenv root)/plugins
rm -rf $(anyenv root)/plugins/anyenv-update
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

anyenv install nodenv
anyenv install goenv
anyenv install pyenv
anyenv update

echo '
###########
gpg key generate and pass init
###########
'

gpg -u sawada --quick-generate-key `id -u` rsa4096
pass init `ls ~/.gnupg/openpgp-revocs.d/ | tr -d .rev`

echo '
** second_step.sh alll done !  **
'
