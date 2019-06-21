#Update Script by Dominik Bornhäußer
#Picochess 2.01 and new Engines-for-Raspberry-Pi-by-Al
#copy script into /home/pi/
#Make Script Executable
#sudo chmod +x picochess_201_newEngine.sh
sudo apt-get update
sudo apt-get upgrade
#sudo rpi-update c50c65e52bad69e8fa7d6576d9e2399eade7faf6

sudo killall  python3

#Git Clone repositorys
#For original Jrmang Picochess Version uncomment next line
#https://github.com/jromang/picochess.git

#For 201 Picochess Version uncomment next line
git clone https://github.com/tosca07/picochess.git
git clone https://github.com/well69/Chess-Engines-for-Raspberry-Pi-by-Al.git

#Safety Copy Picochess
sudo mkdir /opt/backup
sudo mkdir /opt/backup/picochess
sudo cp -R /opt/picochess /opt/backup/picochess/picochess_$(date +%Y%m%d_%H%M%S)

#Remove Picochess exept picochess.ini
cd /opt/picochess
sudo rm -v -R !("picochess.ini")
cd /home/pi/

# Copy new Picochess 2.01
sudo cp -R /home/pi/picochess/ /opt/

#Install new Engines
sudo apt install cmake g++ git libboost-all-dev libopenblas-dev opencl-headers ocl-icd-libopencl1 ocl-icd-opencl-dev zlib1g-dev
sudo cp -R Chess-Engines-for-Raspberry-Pi-by-Al/arm6l/* /opt/picochess/engines/armv6l
sudo cp -R Chess-Engines-for-Raspberry-Pi-by-Al/arm7l/* /opt/picochess/engines/armv7l
sudo chmod 755 -R /opt/picochess/engines

#Get Weights on http://lczero.org/networks/ 
wget http://lczero.org/get_network?sha=1d71df3f0a6c90ef1132e858096486acf6dc7e2c91420fedc56e0167131af8de
cp 'get_network?sha=1d71df3f0a6c90ef1132e858096486acf6dc7e2c91420fedc56e0167131af8de' weights.txt 
rm 'get_network?sha=1d71df3f0a6c90ef1132e858096486acf6dc7e2c91420fedc56e0167131af8de'
sudo mv weights.txt /opt/picochess/weigths.txt

#Cleaning up
sudo rm -R Chess-Engines-for-Raspberry-Pi-by-Al
sudo rm -R picochess

#Clear History of you shell If you want
#history -c

sudo reboot
