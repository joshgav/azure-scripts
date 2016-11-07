# Bootstrap Mesos from source
sudo apt-get update && apt-get upgrade -y
sudo apt-get install -y git
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y autoconf libtool build-essential
sudo apt-get install -y python-dev python-boto libcurl4-nss-dev libsasl2-dev maven libapr1-dev libsvn-dev

MESOS_ROOT_DIR=~/mesos

test -d $MESOS_ROOT_DIR || git clone https://git-wip-us.apache.org/repos/asf/mesos.git $MESOS_ROOT_DIR
cd $MESOS_ROOT_DIR

./bootstrap

test -d build || mkdir build
cd $MESOS_ROOT_DIR/build
../configure
make -j8

