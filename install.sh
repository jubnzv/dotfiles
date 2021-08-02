#!/usr/bin/env bash

create_directories() {
    mkdir -pv ~/{Downloads,Documents,Work,Sources,Dev,Org,Work,Pictures/Screenshots}/
}

install_deb_packages() {
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install $(grep -vE "^\s*#" ~/dotfiles/packages.deb.txt  | tr "\n" " ")
    sudo apt-get autoremove
    sudo apt-get autoclean
    sudo apt-get clean

    cd /tmp/

    wget https://github.com/sharkdp/bat/releases/download/v0.18.1/bat-musl_0.18.1_amd64.deb
    sudo dpkg -i bat-musl_0.18.1_amd64.deb

    wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
    sudo dpkg -i ripgrep_13.0.0_amd64.deb

    wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
    sudo dpkg -i fd_8.2.1_amd64.deb
}

install_neovim() {
    cd ~/Sources/
    git clone https://github.com/neovim/neovim
    cd neovim
    git checkout v0.5.0
    make distclean && make CMAKE_BUILD_TYPE=RelWithDebInfo -j4 && sudo make install
}

install_firefox() {
    cd /tmp
    wget https://ftp.mozilla.org/pub/firefox/releases/89.0/linux-x86_64/en-US/firefox-89.0.tar.bz2
    sudo tar xf firefox-89.0.tar.bz2 -C /opt/
}

install_thunderbird() {
    # TODO: Install firetray
    cd /tmp
    wget https://releases.mozilla.org/pub/thunderbird/releases/89.0b4/linux-x86_64/en-US/thunderbird-89.0b4.tar.bz2
    sudo tar xf thunderbird-89.0b4.tar.bz2 -C /opt/
}

install_packages() {
    if [[ -f /etc/debian_version ]]; then
        install_deb_packages
    else
        echo "Unsupported OS"
        exit 1
    fi

    install_neovim
    install_firefox
    install_thunderbird
}

create_symlinks() {
    for f in "$1"/* "$1"/.[^.]*; do
        if echo "$f" | egrep '.*\/?((\.){1,2}|.git|assets|README.md|install.sh|tags)$' >/dev/null; then
            continue
        fi
        if [[ -f $f ]]; then
            ln -sfn `realpath "$f"` "$HOME/$f"
        fi
        if [[ -d $f ]]; then
            mkdir -p "$HOME"/"$f"
            create_symlinks "$f"
        fi
    done
}

if [[ $2 == "-A" ]]; then
    create_directories
    install_packages
fi
create_symlinks .
