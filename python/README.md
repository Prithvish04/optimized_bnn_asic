# Instructions


1. For systems with Nvidia GPU:
* Install CUDA (Instructions given below are for Ubuntu 20.04. For other plaforms, visit [CUDA Downloads](https://developer.nvidia.com/cuda-downloads))
```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda-repo-ubuntu2004-11-3-local_11.3.1-465.19.01-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-3-local_11.3.1-465.19.01-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-3-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```
* Download and install [cuDNN](https://developer.nvidia.com/rdp/cudnn-download)
* Install Tensorflow (GPU version)
```bash
pip install tensorflow-gpu
```

2. For systems without Nvidia GPU:
* Install Tensorflow (CPU version)
```bash
pip install tensorflow
```

3. Install keras
```bash
pip install keras
```
