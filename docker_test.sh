#!/usr/bin/zsh

# stop script if return code is not 0 or use undefined vars
set -eu

# disable 'zsh: no match found' error
setopt nonomatch


echo '
###########
apt update
###########
'
apt update 

echo '
###########
apt install vim ca-certificates
###########
'
apt install vim ca-certificates ibus-mozc wget curl gdebi

echo '
###########
chsh -s `which zsh`
###########
'

chsh -s `which zsh`

echo '
###########
sudo chsh -s `which zsh`
###########
'

chsh -s `which zsh`

echo '
###########
prezto install
###########
'

rm -r ~/.z*

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cp -r ${SCRIPT_DIR}/.z* ~/

echo '
###########
anyenv install
###########
'

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

echo 'install complete! need shell reload. "exec $SHELL -l"'