.DEFAULT_GOAL := help
SHELL=/bin/zsh
GDEBI_INSTALL = yes | sudo gdebi
APT_INSTALL = sudo apt-get -y install

all: install_prezto install_anyenv install_gcm install_fcitx5 install_discord install_vscode

apt_reflesh:
	sudo apt update && sudo apt -y dist-upgrade

chsh_to_zsh:
	chsh -s `which zsh`
	sudo chsh -s `which zsh`

help:
	@echo "all\t\tinstall prezto, anyenv, gcm, fcitx5, discord, vscode"
	@echo "apt_reflesh\tapt update && apt dist-upgrade"
	@echo "chsh_to_zsh\tchsh -s `which zsh` with current user and root"
	@echo "install_anyenv\tinstall anyenv after install_git set_options"
	@echo "install_discord\tinstall discord after install_gdebi, install_wget"
	@echo "install_gdebi\tinstall gdebi after apt_reflesh"
	@echo "install_git\tinstall git after apt_reflesh"
	@echo "install_gcm\tinstall git-credential-manager after install_gdebi, install_git, install_wget"
	@echo "install_prezto\tinstall prezto after chsh_to_zsh, install_git, set_options"
	@echo "install_vscode\tinstall vscode after install_gdebi, install_wget"
	@echo "install_wget\tinstall wget after apt_reflesh"
	@echo "set_options\tset -eu and setopt nonomatch"

ANYENV_PATH = ~/.anyenv
ANYENV_BIN = ${ANYENV_PATH}/bin/anyenv
ANYENV_DOWNLOAD_URL= https://github.com/anyenv/anyenv
ANYENV_UPDATE_DOWNLOAD_URL = https://github.com/znz/anyenv-update.git
install_anyenv: install_git set_options
	rm -rf ${ANYENV_PATH}
	rm -rf ~/.config/anyenv
	git clone ${ANYENV_DOWNLOAD_URL} ${ANYENV_PATH}

	yes | ${ANYENV_BIN} install --init

	eval "$$(${ANYENV_BIN} init -)"

	mkdir -p $$(${ANYENV_BIN} root)/plugins
	rm -rf $$(${ANYENV_BIN} root)/plugins/anyenv-update
	git clone ${ANYENV_UPDATE_DOWNLOAD_URL} $$(${ANYENV_BIN} root)/plugins/anyenv-update

	${ANYENV_BIN} install nodenv
	${ANYENV_BIN} install goenv
	${ANYENV_BIN} install pyenv
	${ANYENV_BIN} update

DISCORD_PKG_NAME = discord.deb
DISCORD_DOWNLOAD_URL = 'https://discord.com/api/download?platform=linux&format=deb'
install_discord: install_gdebi install_wget
	wget -O ${DISCORD_PKG_NAME} ${DISCORD_DOWNLOAD_URL}
	${GDEBI_INSTALL} ${DISCORD_PKG_NAME}

install_fcitx5: apt_reflesh
	sudo apt -y purge ibus
	${APT_INSTALL} fcitx5 fcitx5-mozc kde-config-fcitx5

install_gdebi: apt_reflesh
	${APT_INSTALL} gdebi

install_git: apt_reflesh
	${APT_INSTALL} git

GCM_PKG_NAME = gcm.deb
GCM_DOWNLOAD_URL = https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.785/gcm-linux_amd64.2.0.785.deb
install_gcm: install_gdebi install_git install_wget
	cp dotfiles/.gitconfig ~
	wget -O ${GCM_PKG_NAME} ${GCM_DOWNLOAD_URL}
	${GDEBI_INSTALL} ${GCM_PKG_NAME}
	git-credential-manager-core configure

PREZTO_DOWNLOAD_URL = https://github.com/sorin-ionescu/prezto.git
install_prezto: chsh_to_zsh install_git set_options
	rm -rf ~/.z*
	git clone --recursive ${PREZTO_DOWNLOAD_URL} "$${ZDOTDIR:-$$HOME}/.zprezto"

	cp -r dotfiles/.z*rc ~
	source "$${ZDOTDIR:-$$HOME}/.zprezto/init.zsh"

VSCODE_PKG_NAME = vscode.deb
VSCODE_DOWNLOAD_URL = 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
install_vscode: install_gdebi install_wget
	wget -O ${VSCODE_PKG_NAME} ${VSCODE_DOWNLOAD_URL}
	${GDEBI_INSTALL} ${VSCODE_PKG_NAME}

install_wget: apt_reflesh
	${APT_INSTALL} wget

set_options:
	set -eu
	setopt nonomatch
