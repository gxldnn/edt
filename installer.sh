#!/bin/bash
 
mkdir ~/Documents/apuntes/
 
wget https://tlauncher.org/jar -P ~/Documents/apuntes
 
cd ~/Documents/apuntes/
 
unzip jar
 

mv jar_FILES/TLauncher.jar .
 

mv TLauncher.jar .
 
rm -r jar
 

java -jar Tlauncher.jar
 

java -jar TLauncher.jar
 

 
echo 'function minepush() {
 
  cd
 
  rm -rf minecraftedt
 
  git clone git@github.com:gxldnn/minecraftedt.git
 
  rm -rf minecraftedt/*
 
  cp -r /home/users/inf/hisx1/a241477jr/.minecraft/saves/EDTBORINGAF/ /home/users/inf/hisx1/a241477jr/minecraftedt/
 
  cd minecraftedt
 
  git add -A
 
  git commit -m "Minecraft Push"
 
  git push
 
}
 
function mineget() {
 
  cd
 
  rm -rf minecraftedt
 
  git clone git@github.com:gxldnn/minecraftedt.git
 
  rm -rf ~/.minecraft/saves/*
 
  cp -r minecraftedt/* ~/.minecraft/saves/
 
}' >> ~/.bashrc
