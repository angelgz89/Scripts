sudo apt install -y realtek-rtl88xxau-dkms
sudo apt update
sudo git clone -b v5.3.4 https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
sudo apt-get install build-essential
sudo apt-get install bc
sudo apt-get install libelf-dev
sudo apt-get install linux-headers-`uname -r`
make
make install