#!/bin/bash -v 

# install maven
cd /var/data/imhotep
mkdir build-tools
cd build-tools
wget http://apache.cs.utah.edu/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz
tar xf apache-maven-3.2.1-bin.tar.gz
ln -s apache-maven-3.2.1 maven

# download and build imhotep
#cd /var/data/imhotep
#git clone https://github.com/darren-indeed/imhotep.git source
#cd source
#/var/data/imhotep/build-tools/maven/bin/mvn install package

# copy imhotep since building it does not work yet
mkdir -p /var/data/imhotep/source/target
cp /tmp/imhotep*.tar.gz /var/data/imhotep/source/target

# unpack imhotep
cd /opt/imhotep
tar xzf /var/data/imhotep/source/target/imhotep-server*.tar.gz 
ln -s /opt/imhotep/imhotep-server-* /opt/imhotep/imhotep-server

