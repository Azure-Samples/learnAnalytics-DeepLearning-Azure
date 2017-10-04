#!/usr/bin/env bash

# create conda environment and install cntk
conda create -y -n cntk-py35 python=3.5 anaconda
source activate cntk-py35
yes | pip install https://cntk.ai/PythonWheel/GPU/cntk-2.2-cp35-cp35m-linux_x86_64.whl

# take ownership of root anaconda
sudo chown $USER:$USER -R /anaconda/

# update root anaconda python and jupyter
source deactivate
yes | pip install -U pip
yes | pip install --upgrade --force-reinstall jupyter
rm ~/.ipython/profile_default/startup/az_ml_magic.py

# update conda kernels and add cntk-py35 spec
conda install -y nb_conda
conda install -y ipykernel
python -m ipykernel install --user --name cntk-py35 --display-name "cntk-py35"
jupyter kernelspec list

# install keras and tensorflow-gpu
source activate cntk-py35
yes | pip install --upgrade --force-reinstall jupyter # the previous was to update jupyter on root, this will fix ipython cli
yes | pip install --upgrade --force-reinstall jupyter # seems redundant, but for some reason the first fails...
yes | pip install keras
yes | pip install tensorflow-gpu
yes | pip install opencv-python easydict future pydot-ng
conda install -y libgcc

# update cudnn
wget https://alizaidi.blob.core.windows.net/training/cuda_builds/CUDA/libcudnn6_6.0.21-1%2Bcuda8.0_amd64.deb
sudo dpkg -i libcudnn6_6.0.21-1+cuda8.0_amd64.deb
rm libcudnn6_6.0.21-1+cuda8.0_amd64.deb
python -m ipykernel install --user --name cntk-py35 --display-name "cntk-py35" # TODO: check where this should done
sudo systemctl restart jupyterhub

# start jupyterlab
# cd ~/notebooks
# tmux new -s jupyterlab
# nohup jupyter lab --ip="*" & disown
# tmux detach
# jupyter notebook list
