#!/bin/bash

# install java
yum update -y && yum install -y java-1.8.0-openjdk.x86_64

# install minecraft server
mkdir /root/minecraft && cd /root/minecraft
wget https://cdn.getbukkit.org/spigot/spigot-1.14.4.jar && java -jar spigot-1.14.4.jar
sed -e "s/eula=false/eula=true/" /root/minecraft/eula.txt >/tmp/eula.txt
mv -f /tmp/eula.txt /root/minecraft/eula.txt

# add plugin
wget -P /root/minecraft/plugins https://media.forgecdn.net/files/2990/815/Dynmap-3.1-beta-1-spigot.jar
wget -P /root/minecraft/plugins https://lol.scarsz.me/WTtrsN/DiscordSRV-Build-1.19.1.jar
wget -P /root/minecraft/plugins https://media.forgecdn.net/files/2768/520/AntiCreeper.jar

# start server
screen -d -m -S "spigot" java -Xms3G -Xmx4G -XX:+UseConcMarkSweepGC -jar spigot-1.14.4.jar
# java -jar spigot-1.14.4.jar
