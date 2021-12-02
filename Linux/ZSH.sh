#! /bin/bash

sudo dpkg -l | grep -i "zsh" > /dev/null 2>&1
if [ "$(echo $?)" == "1" ];
then
    sudo apt install git zsh -y > /dev/null 2>&1
    chsh -s $(which zsh)
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    sudo apt-get install zsh-antigen
    #sudo apt-get install zsh-syntax-highlighting
    #git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

    #wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null 2>&1
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting > /dev/null 2>&1
    
    echo "" > .zshrc
    
    echo '
    export ZSH=$HOME/.oh-my-zsh

    ZSH_THEME="bira"

    plugins=(git
    zsh-autosuggestions
    zsh-syntax-highlighting)

    source $ZSH/oh-my-zsh.sh
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    export PATH="$PATH:$HOME/Scripts/Linux"' > .zshrc
fi