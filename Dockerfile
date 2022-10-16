FROM ubuntu:22.04

RUN apt-get update && apt-get -y install zsh make sudo

WORKDIR /make/

COPY dotfiles/ dotfiles/
COPY Makefile .

CMD [ "zsh", "-ic", "make all" ]