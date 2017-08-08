#!/bin/bash

# update repositories and upgrade packages
apt-get update
apt-get --assume-yes upgrade

# install python and tools
apt-get --assume-yes install nano python python-dev python-pip
apt-get --assume-yes install python3 python3-dev python3-pip

mkdir /home/downloads
cd /home/downloads

# download and install CUDA
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
apt-get update
apt-get --assume-yes install cuda

# download and install libcudnn5, which is necessary, for example, for Conv2D layers
# not needed for pytorch
:'
ML_REPO_PKG=http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
wget "$ML_REPO_PKG" -O /tmp/ml-repo.deb && sudo dpkg -i /tmp/ml-repo.deb && rm -f /tmp/ml-repo.deb
apt-get update
apt-get --assume-yes install libcudnn5
'

# install python packages for machine learning
yes | pip2 install --upgrade pip
yes | pip3 install --upgrade pip
yes | pip2 install pillow matplotlib mpmath jupyter keras sklearn tensorflow tensorflow-gpu
yes | pip3 install pillow matplotlib mpmath jupyter keras sklearn tensorflow tensorflow-gpu

# clean up
cd /home
rm -r ./downloads
