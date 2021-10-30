# Download package required
wget https://archive.raspberrypi.org/debian/pool/main/r/realvnc-vnc/realvnc-vnc-server_6.7.2.43081_arm64.deb

# Install package
sudo dpkg -i realvnc-vnc-server_6.7.2.43081_arm64.deb

# Change over to the aarch64-linux-gnu folder under /usr/lib
cd /usr/lib/aarch64-linux-gnu

# As sudo create symlinks to the following files
sudo ln libvcos.so /usr/lib/libvcos.so.0
sudo ln libvchiq_arm.so /usr/lib/libvchiq_arm.so.0
sudo ln libbcm_host.so /usr/lib/libbcm_host.so.0
#libbcm_host.so
# libvcos.so
sudo ln libmmal.so
sudo ln libmmal_core.so
sudo ln libmmal_components.so
sudo ln libmmal_util.so
sudo ln libmmal_vc_client.so
sudo ln libvcsm.so
sudo ln libcontainers.so

sudo systemctl enable vncserver-virtuald.service
sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-virtuald.service
sudo systemctl start vncserver-x11-serviced.service
sudo reboot
