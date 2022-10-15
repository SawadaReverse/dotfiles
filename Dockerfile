FROM ubuntu:22.04

ARG user_name="user"
ARG password="password"

WORKDIR /make/
COPY dotfiles .
COPY Makefile .

RUN apt-get update && apt-get -y install zsh make sudo
RUN adduser ${user_name} --disabled-password --gecos "" && gpasswd -a ${user_name} sudo && echo ${user_name}:${password} | /usr/sbin/chpasswd
USER ${user_name}

CMD [ "make", "all" ]