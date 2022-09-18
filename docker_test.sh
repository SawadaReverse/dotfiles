#!/usr/bin/zsh

# stop script if return code is not 0 or use undefined vars
set -eu

# disable 'zsh: no match found' error
setopt nonomatch


echo '
###########
apt update && apt dist-upgrade
###########
'
apt update && apt -y dist-upgrade

echo '
###########
apt purge ibus
###########
'

apt -y purge ibus

echo '
###########
apt install vim ca-certificates ibus-mozc wget curl gdebi pass
###########
'
apt -y install vim ca-certificates wget curl gdebi pass fcitx5 fcitx5-mozc kde-config-fcitx5

echo '
###########
chsh -s `which zsh`
###########
'

chsh -s `which zsh`

echo '
###########
chsh -s `which zsh`
###########
'

chsh -s `which zsh`

echo '
###########
prezto install
###########
'

rm -rf ~/.z*

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cp -r ${SCRIPT_DIR}/.z* ~/

echo '
###########
git-credential-manager install
###########
'
cp ${SCRIPT_DIR}/.gitconfig ~/
wget -O gcm.deb https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.785/gcm-linux_amd64.2.0.785.deb
yes | gdebi gcm.deb
git-credential-manager-core configure

echo '
###########
anyenv install
###########
'

rm -rf ~/.anyenv
rm -rf ~/.config/anyenv
git clone https://github.com/anyenv/anyenv ~/.anyenv
yes | ~/.anyenv/bin/anyenv install --init

echo '
###########
discord install
###########
'

wget -O discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
yes | gdebi discord.deb

echo '
###########
VSCode install
###########
'

wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
yes | gdebi vscode.deb

echo '
###########
call second_step.sh with zsh
###########
'

zsh ./second_step.sh

echo '
** setup complete! Your remain tasks... Nothing! **
'
