SHELL=/bin/zsh

help:
	echo "this is help"

all: install_prezto install_anyenv install_gcm install_fcitx5 install_discord install_vscode

apt_reflesh:
	sudo apt update && sudo apt -y dist-upgrade

chsh_to_zsh:
	chsh -s `which zsh`
	sudo chsh -s `which zsh`

tmp_anyenv = ~/.anyenv/bin/anyenv
install_anyenv: install_git set_options
	rm -rf ~/.anyenv
	rm -rf ~/.config/anyenv
	git clone https://github.com/anyenv/anyenv ~/.anyenv

	yes | ${tmp_anyenv} install --init

	eval "$$(${tmp_anyenv} init -)"

	mkdir -p $$(${tmp_anyenv} root)/plugins
	rm -rf $$(${tmp_anyenv} root)/plugins/anyenv-update
	git clone https://github.com/znz/anyenv-update.git $$(${tmp_anyenv} root)/plugins/anyenv-update

	${tmp_anyenv} install nodenv
	${tmp_anyenv} install goenv
	${tmp_anyenv} install pyenv
	${tmp_anyenv} update

	unset anyenv

install_discord: install_gdebi install_wget
	wget -O discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
	yes | sudo gdebi discord.deb

install_fcitx5: apt_reflesh
	sudo apt -y purge ibus
	sudo apt -y install fcitx5 fcitx5-mozc kde-config-fcitx5

install_gdebi: apt_reflesh
	sudo apt -y install gdebi

install_git: apt_reflesh
	sudo apt -y install git

install_gcm: install_gdebi install_git install_wget
	cp dotfiles/.gitconfig ~
	wget -O gcm.deb https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.785/gcm-linux_amd64.2.0.785.deb
	yes | sudo gdebi gcm.deb
	git-credential-manager-core configure

install_prezto: chsh_to_zsh install_git set_options
	rm -rf ~/.z*
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "$${ZDOTDIR:-$$HOME}/.zprezto"

	cp -r dotfiles/.z*rc ~
	source "$${ZDOTDIR:-$$HOME}/.zprezto/init.zsh"

install_vscode: install_gdebi install_wget
	wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
	yes | sudo gdebi vscode.deb

install_wget: apt_reflesh
	sudo apt -y install wget

set_options:
	set -eu
	setopt nonomatch