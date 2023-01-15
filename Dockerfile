FROM ubuntu:20.04

ENV HOME_DIR '/root'

WORKDIR ${HOME_DIR}

RUN mkdir -p ${HOME_DIR}/sunrisehouse/project
RUN mkdir -p ${HOME_DIR}/local/project
RUN mkdir -p ${HOME_DIR}/callabtech/project

RUN apt -y update
RUN apt -y upgrade
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y install curl
RUN apt-get install -y software-properties-common
RUN apt-get install -y git
RUN curl -sl https://deb.nodesource.com/setup_18.x | bash -E - && \
    apt install -y nodejs
RUN python3 --version && \
    apt install -y python3-pip && \
    apt install -y build-essential libssl-dev libffi-dev python3-dev && \
    apt install -y python3-venv

ENV VIM_CONFIG_GIT_REPOSITORY_NAME "vim_config"
ENV VIM_CONFIG_GIT_REPOSITORY_URL "https://github.com/sunrisehouse/${VIM_CONFIG_GIT_REPOSITORY_NAME}.git"
ENV VIM_CONFIG_FILE_PATH "/init.vim"
ENV NEOVIM_CONFIG_DIR_PATH "${HOME_DIR}/.config/nvim/"
ENV NEOVIM_CONFIG_FILE_NAME "init.vim"
ENV NEOVIM_DOWNLOAD_URL "https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb"
RUN curl ${NEOVIM_DOWNLOAD_URL} -fLo ./nvim-linux64.deb && \
    apt install -y ./nvim-linux64.deb && \
    rm -rf ./nvim-linux64.deb && \
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && \
    git clone ${VIM_CONFIG_GIT_REPOSITORY_URL} && \
    mkdir -p ${NEOVIM_CONFIG_DIR_PATH} && \
    mv ./${VIM_CONFIG_GIT_REPOSITORY_NAME}${VIM_CONFIG_FILE_PATH} ${NEOVIM_CONFIG_DIR_PATH}${NEOVIM_CONFIG_FILE_NAME} && \
    rm -rf ./${VIM_CONFIG_GIT_REPOSITORY_NAME}
