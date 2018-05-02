#!/bin/bash

validate_bash()
{
    rst=`ls -l /bin/sh | grep "bash"`
    if [ "$rst" == "" ];then
        echo "The default sh is not bash, please modify it." && exit 1
    fi
}


install_vim()
{
    sudo -u infrasim git clone https://github.com/vim/vim.git $WORKSPACE/vim
    cp $CUR/build_vim.sh $WORKSPACE/vim
    pushd $WORKSPACE/vim
    ./build_vim.sh || (echo "Fail to build vim!" && exit 1)
    popd
}

install_apt_pkgs()
{
    apt-get install -y sshpass cscope checkinstall dh-autoreconf libglib2.0-dev libncurses5-dev libpython-dev libssl-dev libpopt-dev  python-pip python-setuptools libpython-dev libsm-dev libice-dev gcc libaio-dev libnuma-dev libgnome2-dev libgnomeui-dev   libgtk2.0-dev libatk1.0-dev libbonoboui2-dev   libcairo2-dev libx11-dev libxpm-dev libxt-dev
}


config_vim()
{
    git clone https://github.com/tpope/vim-pathogen.git $HOME/.vim
    cp $CUR/.vimrc $HOME
    pushd $HOME/.vim
    mkdir bundle
    git submodule add https://github.com/flazz/vim-colorschemes.git bundle/colorschemes
    popd
}


if [ $EUID -ne 0 ]; then
    echo "Please run with root priviledge" && exit 1
fi

# Check workspace mount or not.
WORKSPACE=$HOME/julie
CUR=`pwd`
if [ ! -d $WORKSPACE ]; then
    echo "Please create dir and set mount point first." && exit 1
fi
# Validate bash
validate_bash
# Install vim as needed.
install_apt_pkgs
# Install necessary libs.
install_vim
config_vim
