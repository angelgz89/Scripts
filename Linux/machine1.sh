git clone https://github.com/pablogonzalezpe/OoOps_machine.git
cd OoOps_machine
sudo docker build . -t tfm:machine1
sudo docker run --rm -it -e $(ifconfig enp0s8| grep "inet " | awk -F' ' '{print $2}') -p 21:21 -p 22:22 -p 8080:80 -p 10000:10000  tfm:machine1