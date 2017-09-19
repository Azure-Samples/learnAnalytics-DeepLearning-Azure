# Finding Groceries Using Fast R-CNN in CNTK

# Introduction

We use Fast R-CNN to find rough locations and types of groceries in pictures. Please see the `FindingGroceriesInImages.ipynb` Jupyter Notebook for details.

# Prerequisites

Please create a Python 3.4 environment with the appropriate setup by:

- Install Anaconda
- Create a new Anaconda environment using the included environment.yml file
   - `conda env create --name fastrnn -f environment.yml python=3.4`
- Install `scikit-image` and `opencv` using the pre-built Wheel files 

## C Library code

The Fast R-CNN implementation for CNTK depends on custom C code from the original Fast R-CNN [GitHub repo](https://github.com/rbgirshick/fast-rcnn) which has been built for 64-bit Windows and Python 3.4. In theory, building this code for other versions of Python and other operating systems is possible, but I have yet to do so. Once again, if you find yourself doing so, please submit a pull request as I'd love to extend this beyond just Windows.

# Appendix

## Why Fast R-CNN?

As you know if you watch the Deep Learning space, Fast R-CNN is _far_ from state-of-the-art for the Object Detection problem. This was _not_ true when we were working with our partner - we chose Fast R-CNN because the CNTK team had a beta version of their current [Example](https://github.com/Microsoft/CNTK/tree/master/Examples/Image/Detection/FastRCNN) and at the time getting the pipeline in place was more important than implementing Faster R-CNN (the best at the time) from scratch. We also knew that even Faster R-CNN's edge would erode quickly in this space, so getting them up and running and able to experiment as new techniques came along was more important.
