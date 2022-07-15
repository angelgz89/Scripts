#! /bin/bash	

	cd /usr/local/src
	wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
	tar xzf noip-duc-linux.tar.gz
	cd noip-2.1.9-1
	make
	make install
	/usr/local/bin/noip2 -C

	# systemctl enable noip2.service (start on boot)
	# systemctl start noip2.service (start immediately)
	# systemctl status noip2.service (for status)