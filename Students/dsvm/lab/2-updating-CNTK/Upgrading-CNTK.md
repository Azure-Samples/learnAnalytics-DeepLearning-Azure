Upgrading CNTK and CUDNN
=========================

In this lab, we'll upgrade from CNTK version 2.0 to CNTK 2.1.

## Updating CNTK

CNTK is available in a variety of [precompiled binaries](https://docs.microsoft.com/en-us/cognitive-toolkit/setup-cntk-on-your-machine), which you can install using the `pip` installer. 

### Create Conda Virtual Environment 

For this tutorial, we'll use the [`conda` virtual environment manager](https://conda.io/docs/using/envs.html) to create and modify Python virtual environments. You can create a Python 3.5 environment with `conda` by using the `conda create` command:


```bash
conda create -n cntk-py35 python=3.5 anaconda
```

The environment will be named `cntk-py35` and the additional flag `anaconda` ensures that the distribution will install over a 100 prebuilt Python packages for scientific computing (list [here](https://docs.continuum.io/anaconda/packages/pkg-docs)).

### Install CNTK Using `pip` Binary Wheels

We can activate that environment by running

```bash
source activate cntk-py35
```

Now that we are in our virutla environment for CNTK, let's install the [appropriate Python binary](https://docs.microsoft.com/en-us/cognitive-toolkit/setup-linux-python?tabs=cntkpy21) using a Python "wheel". For example, here are the installation instructions for CNTK on a Python 3.5 environment with Ubuntu 16.04 system with GPU support:

```bash
pip install https://cntk.ai/PythonWheel/GPU/cntk-2.1-cp35-cp35m-linux_x86_64.whl
```

### Temporary Fixes

Let's take complete ownership of our `home` and `anaconda` directories:

```bash
sudo chown alizaidi:alizaidi -R /home/alizaidi
source deactivate
sudo chown alizaidi:alizaidi -R /anaconda/
pip install -U pip
```

**IMPORTANT** replace `alizaidi` with the username you used to create the DSVM.

Update `ipython` and related packages:

```bash
pip install --upgrade --force-reinstall jupyter
```

Remove `az_ml_magic` from ipython startup:

```bash
rm ~/.ipython/profile_default/startup/az_ml_magic.py
```

### Conda Extensions

Since we created a new environment, let's also install some extensions that will make it easier to find that environment from JupyterHub. 

```bash
conda install nb_conda
conda install ipykernel
python -m ipykernel install --user --name cntk-py35 --display-name "cntk-py35"
jupyter kernelspec list
```

### Install Keras

Let's also install Keras in this specific Python environment

```bash
source activate cntk-py35
pip install keras
```
