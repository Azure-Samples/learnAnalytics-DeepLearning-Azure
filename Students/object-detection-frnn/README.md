# Finding Groceries Using Fast R-CNN in CNTK

# Introduction

We use Fast R-CNN to find rough locations and types of groceries in pictures. Please see the `FindingGroceriesInImages.ipynb` Jupyter Notebook for details.

# Prerequisites

The instructions below (apologies in advance!) are for Windows 10 64-bit users. I'll gladly accept pull requests for other operating systems, but haven't had a chance to run through all of them on every system.

Please create a Python 3.4 environment with the appropriate setup by:

- Install Anaconda
- Create a new Anaconda environment using the included environment.yml file
   - `conda env create --name myNewEnv -f environment.yml python=3.4`
- Install `scikit-image` and `opencv` using the pre-built Wheel files 

NOTE: I've put the direct link to CNTK 2.1's Python 3.4 Wheel in the `environment.yml` - if you're not on Windows 64-bit, you'll need to switch that out or remove it and [install CNTK by hand](https://docs.microsoft.com/en-us/cognitive-toolkit/Setup-CNTK-on-your-machine).

## Installing pre-built wheel files

You can acquire pre-built Wheel files for Scikit-Image and OpenCV from http://www.lfd.uci.edu/~gohlke/pythonlibs/, download them (the `cp34` versions for Python 3.4, the `amd64` version since we're on 64-bit Windows), and install using `pip install \path\to\wheel-file`.

## C Library code

The Fast R-CNN implementation for CNTK depends on custom C code from the original Fast R-CNN [GitHub repo](https://github.com/rbgirshick/fast-rcnn) which has been built for 64-bit Windows and Python 3.4. In theory, building this code for other versions of Python and other operating systems is possible, but I have yet to do so. Once again, if you find yourself doing so, please submit a pull request as I'd love to extend this beyond just Windows.

# Appendix

## Why Fast R-CNN?

As you know if you watch the Deep Learning space, Fast R-CNN is _far_ from state-of-the-art for the Object Detection problem. This was _not_ true when we were working with our partner - we chose Fast R-CNN because the CNTK team had a beta version of their current [Example](https://github.com/Microsoft/CNTK/tree/master/Examples/Image/Detection/FastRCNN) and at the time getting the pipeline in place was more important than implementing Faster R-CNN (the best at the time) from scratch. We also knew that even Faster R-CNN's edge would erode quickly in this space, so getting them up and running and able to experiment as new techniques came along was more important.
