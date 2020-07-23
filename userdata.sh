sudo su

# install java
yum update -y
yum install -y java-1.8.0-openjdk.x86_64

# install minecraft server
mkdir /etc/minecraft && cd /etc/minecraft
wget https://cdn.getbukkit.org/spigot/spigot-1.12.2.jar
java -jar spigot-1.12.2.jar
sed -e "s/eula=false/eula=true/" /etc/minecraft/eula.txt >/tmp/eula.txt
mv -f /tmp/eula.txt /etc/minecraft/eula.txt
java -jar spigot-1.12.2.jar
