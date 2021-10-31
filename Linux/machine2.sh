git clone https://github.com/pablogonzalezpe/odyssey.git
cd odyssey
sudo docker build . -t tfm:machine2
sudo docker run --rm -it -p 8080:80 tfm:machine2