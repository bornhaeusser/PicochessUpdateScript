#Update Script by Dominik Bornhäußer
#Picochess 2.01 and new Engines-for-Raspberry-Pi-by-Al
#copy script into /home/pi/
#Make Script Executable
#sudo chmod +x picochess_201_newEngine.sh
sudo apt-get update
sudo apt-get upgrade

sudo killall  python3

#Git Clone repositorys
git clone https://github.com/tosca07/picochess.git
git clone https://github.com/well69/Chess-Engines-for-Raspberry-Pi-by-Al.git

#Safety Copy Picochess
sudo mkdir /opt/backup/
sudo mkdir /opt/backup/picochess
sudo cp -R /opt/picochess /opt/backup/picochess/picochess_$(date +%Y%m%d_%H%M%S)

# Copy new Picochess 2.01
sudo cp -R /home/pi/picochess/ /opt/

#Install new Engines
sudo apt install cmake g++ git libboost-all-dev libopenblas-dev opencl-headers ocl-icd-libopencl1 ocl-icd-opencl-dev zlib1g-dev
#sudo mkdir /opt/picochess/engines/armv6l
#sudo mkdir /opt/picochess/engines/armv6l
sudo cp -R Chess-Engines-for-Raspberry-Pi-by-Al/arm6l/* /opt/picochess/engines/armv6l
sudo cp -R Chess-Engines-for-Raspberry-Pi-by-Al/arm7l/* /opt/picochess/engines/armv7l
sudo chmod 755 -R /opt/picochess/engines

#Get Weights on http://lczero.org/networks/
wget http://lczero.org/get_network?sha=20f06b2ee03c4a10a04202277facccdbdc9362b3360ac8c575c4e44c5ab41ba7
cp get_network\?sha\=20f06b2ee03c4a10a04202277facccdbdc9362b3360ac8c575c4e44c5ab41ba7 weights.txt
rm get_network\?sha\=20f06b2ee03c4a10a04202277facccdbdc9362b3360ac8c575c4e44c5ab41ba7
sudo mv weights.txt /opt/picochess/weigths.txt
sudo chmod 755 /opt/picochess/weigths.txt

#Cleaning up
sudo rm -R Chess-Engines-for-Raspberry-Pi-by-Al
sudo rm -R picochess

#Clear History of you shell If you want
#history -c

sudo reboot
