FROM ubuntu:20.04

ENV HOME_DIR '/root'

WORKDIR ${HOME_DIR}

RUN apt -y update
RUN apt -y upgrade
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y install curl
RUN apt-get install -y software-properties-common
RUN apt-get install -y git
RUN curl -sl https://deb.nodesource.com/setup_18.x | bash -E - && \
    apt install -y nodejs && \
    npm install --global yarn
RUN python3 --version && \
    apt install -y python3-pip && \
    apt install -y build-essential libssl-dev libffi-dev python3-dev && \
    apt install -y python3-venv

ENV VIM_CONFIG_GIT_REPOSITORY_NAME "vim_config"
ENV VIM_CONFIG_GIT_REPOSITORY_URL "https://github.com/sunrisehouse/${VIM_CONFIG_GIT_REPOSITORY_NAME}.git"
ENV VIM_CONFIG_FILE_PATH "/init.lua"
ENV NEOVIM_CONFIG_DIR_PATH "${HOME_DIR}/.config/nvim/"
ENV NEOVIM_CONFIG_FILE_NAME "init.vim"
ENV NEOVIM_DOWNLOAD_URL "https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb"
RUN curl ${NEOVIM_DOWNLOAD_URL} -fLo ./nvim-linux64.deb && \
    apt install -y ./nvim-linux64.deb && \
    rm -rf ./nvim-linux64.deb && \
    git clone ${VIM_CONFIG_GIT_REPOSITORY_URL} && \
    mkdir -p ${NEOVIM_CONFIG_DIR_PATH} && \
    mv ./${VIM_CONFIG_GIT_REPOSITORY_NAME}${VIM_CONFIG_FILE_PATH} ${NEOVIM_CONFIG_DIR_PATH}${NEOVIM_CONFIG_FILE_NAME} && \
    rm -rf ./${VIM_CONFIG_GIT_REPOSITORY_NAME} && \
    # install packer
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim && \
    # install lua language server
    apt install ninja-build && \
    mkdir ${HOME_DIR}/app && cd ${HOME_DIR}/app && \
    git clone  --depth=1 https://github.com/sumneko/lua-language-server && \
    cd lua-language-server && \
    git submodule update --depth 1 --init --recursive && \
    cd 3rd/luamake && \
    ./compile/install.sh && \
    cd ../.. && \
    ./3rd/luamake/luamake rebuild && \
    echo 'export PATH="${HOME_DIR}/app/lua-language-server/bin:${PATH}"' >> ~/.bashrc && \
    source ~/.bashrc && \
    # install other language server
    npm install -g typescript typescript-language-server && \
    npm install -g pyright && \
    # install fonts
    apt install -y unzip
    apt install -y fontconfig
    mkdir -p ${HOME_DIR}/.local/share/fonts && \
    curl -fLo ${HOME_DIR}/.local/share/fonts/RobotoMono.zip --create-dirs https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/RobotoMono.zip && \
    unzip ${HOME_DIR}/.local/share/fonts/RobotoMono.zip && \
    fc-cache -fv

    
    
