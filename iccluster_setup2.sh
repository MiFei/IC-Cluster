# this file works for tensorflow 1.4 with GPU, which specifically reuqire cuda8.0, and cudnn6
# python 3

apt-get update
apt-get --assume-yes upgrade



# install python and tools
apt-get --assume-yes install nano
apt-get --assume-yes install python3 python3-dev python3-pip

mkdir /home/downloads
cd /home/downloads

# download and install CUDA
sudo apt-get install cuda-8.0

# download and install libcudnn6, which is necessary tensorflow 1.4 GPU
CUDNN_TAR_FILE="cudnn-8.0-linux-x64-v6.0.tgz"
wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/${CUDNN_TAR_FILE}
tar -xzvf ${CUDNN_TAR_FILE}
mkdir /usr/local/cuda-8.0
mkdir /usr/local/cuda-8.0/lib64

sudo cp -P cuda/include/cudnn.h /usr/local/cuda-8.0/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-8.0/lib64/
sudo chmod a+r /usr/local/cuda-8.0/lib64/libcudnn*

# install python packages for machine learning
yes | pip3 install --upgrade pip
yes | pip3 install pillow matplotlib mpmath jupyter pandas keras sklearn tensorflow tensorflow-gpu

# clean up
cd /home
rm -r ./downloads

# set environment variables
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
