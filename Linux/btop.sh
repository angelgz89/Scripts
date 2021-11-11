#! /bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: M4h0uT

mkdir ~/btop
cd ~/btop
wget https://github.com/aristocratos/btop/releases/download/v1.0.24/btop-1.0.24-x86_64-linux-musl.tbz
tar -xjf btop-1.0.24-x86_64-linux-musl.tbz
./install.sh
cd ..
rm -R btop