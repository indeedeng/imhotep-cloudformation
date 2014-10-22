#!/bin/bash -v 

cd /tmp

# download the oracle java 7 rpm 
wget --no-cookies --no-check-certificate \
    --header 'Cookie: oraclelicense=accept-securebackup-cookie' \
    'http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.rpm'

yum localinstall -y jdk-7u55-linux-x64.rpm

# update java alternatives
alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_55/jre/bin/java 20000 \
         --slave /usr/bin/keytool keytool /usr/java/jdk1.7.0_55/jre/bin/keytool \
         --slave /usr/bin/orbd orbd /usr/java/jdk1.7.0_55/jre/bin/orbd \
         --slave /usr/bin/pack2000 pack2000 /usr/java/jdk1.7.0_55/jre/bin/pack200 \
         --slave /usr/bin/rmid rmid /usr/java/jdk1.7.0_55/jre/bin/rmid \
         --slave /usr/bin/rmiregistry rmiregistry /usr/java/jdk1.7.0_55/jre/bin/rmiregistry \
         --slave /usr/bin/servertool servertool /usr/java/jdk1.7.0_55/jre/bin/servertool \
         --slave /usr/bin/tnameserv tnameserv /usr/java/jdk1.7.0_55/jre/bin/tnameserv \
         --slave /usr/bin/unpack2000 unpack2000 /usr/java/jdk1.7.0_55/jre/bin/unpack200

# install supervisor 
easy_install supervisor

# copy supervisor config files
cp /var/data/imhotep-aws-config/supervisor/supervisord.conf /etc
mkdir /opt/supervisor
cp /var/data/imhotep-aws-config/supervisor/imhotep.conf /opt/supervisor
chmod a+rw /opt/supervisor

# set up init.d entry for supervisor
cp /var/data/imhotep-aws-config/supervisor/supervisor.init.sh /etc/rc.d/init.d/supervisor
chmod a+x /etc/rc.d/init.d/supervisor
chkconfig --level 345 supervisor on

# change directory owners
chown imhotep /var/data/
chown imhotep /var/data/indexes
chown imhotep /var/data/imhotep
chown imhotep /var/data/imhotep/logs
chgrp imhotep /var/data/
chgrp imhotep /var/data/indexes
chgrp imhotep /var/data/imhotep
chgrp imhotep /var/data/imhotep/logs

# mount a tmpfs partition
mkdir /var/tempFS
chown imhotep /var/tempFS
chgrp imhotep /var/tempFS
mount -t tmpfs -o size=10g tmpfs /var/tempFS

# copy imhotep files
cp /var/data/imhotep-aws-config/imhotep/log4j.xml /opt/imhotep/


# start imhotep 
#export CLASSPATH="/opt/imhotep/lib/*:"$CLASSPATH 
#bash /opt/imhotep/imhotep.sh | tee /opt/imhotep/imhotep.log 


