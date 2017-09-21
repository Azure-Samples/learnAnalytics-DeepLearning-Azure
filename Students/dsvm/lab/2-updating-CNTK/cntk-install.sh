#!/usr/bin/env bash

# create conda environment and install cntk
conda create -y -n cntk-py35 python=3.5 anaconda
source activate cntk-py35
pip install -y https://cntk.ai/PythonWheel/GPU/cntk-2.2-cp35-cp35m-linux_x86_64.whl

# take ownership of root anaconda
sudo chown $whoami:$whoami -R /anaconda/

# update root anaconda python and jupyter
source deactivate
pip install -U pip
pip install --upgrade --force-reinstall jupyter
rm ~/.ipython/profile_default/startup/az_ml_magic.py

# update conda kernels and add cntk-py35 spec
conda install nb_conda
conda install ipykernel
python -m ipykernel install --user --name cntk-py35 --display-name "cntk-py35"
jupyter kernelspec list

# install keras and tensorflow-gpu
source activate cntk-py35
pip install keras
pip install tensorflow-gpu
