# [KNN Matting](http://dingzeyu.li/projects/knn/) 
Qifeng Chen, Dingzeyu Li, Chi-Keung Tang<br>
The Hong Kong University of Science and Technology<br>
CVPR 2012 / TPAMI 2013

[![KNN Matting](http://dingzeyu.li/imgs/knn.png)](http://dingzeyu.li/projects/knn/)

## Installation Steps

### Linux and Mac

run "bash install.sh" to download all the required libraries and data. It would take several minutes to tens of minutes, depending on the network connection.

### Windows or Manual Installation

- Download the [VLFeat library](http://www.vlfeat.org/download/vlfeat-0.9.20-bin.tar.gz "VLFeat library") and extract into the same directory.
- Download the training dataset from [AlphaMatting.com](http://alphamatting.com/datasets.php "Data from Alphamatting.com") .
- Extract corresponding files into ${KNN\_MATTING\_DIR}/vlfeat/ 
  and ${KNN\_MATTING\_DIR}/data/, 
  for details please see the ${KNN\_MATTING\_DIR}/src/run_demo.m.

### Optional Data
- [SVBRDF data](http://ist.cs.princeton.edu/) from Jason Lawence, the inverse shaded tree database.


## Running the Demo 

We have been running our codes since Matlab R2011b. The latest version of code is tested on Matlab R2015a. Please let us know if you run into problem.

The input method
1.Left click on each layer (Press Space to seperate layers)
2.press Enter to terminate

Parameters to change are input at the begining of the code
lambda: see equ(12)
level: the degree of spatial coherence. normally between 0.5 and 3
factor: the degree of hue. normally between 0.5 and 3
im: an image or BRDF data
scrib: scribble
l: input windows size is (l*2+1)^2
nn: the number of neighbors. It can be a vector of two elements. For example [10;2] means 10 neighbors with default(level) spatial coherence and 2 neighbors with weak spatial coherence.

### More Information

For more information, please go to our project site for the detailed paper.

### Disclaimer

The code is free for academic/research purpose. Use at your own risk and we are not responsible for any loss resulting from this code. Feel free to submit pull request for bug fixes.

### Contact 
[Qifeng Chen](http://web.stanford.edu/~cqf/) (cqf@stanford.edu) and [Dingzeyu Li](http://dingzeyu.li/) (dli@cs.columbia.edu)
