#/usr/bin/sh

# download and install vlfeat library
wget http://www.vlfeat.org/download/vlfeat-0.9.20-bin.tar.gz
tar zxvf vlfeat-0.9.20-bin.tar.gz
rm vlfeat-0.9.20-bin.tar.gz

# download the data images
mkdir data
cd data
wget http://alphamatting.com/datasets/zip/input_training_lowres.zip
wget http://alphamatting.com/datasets/zip/trimap_training_lowres.zip
mkdir trimaps
cd trimaps
unzip ../trimap_training_lowres.zip
cd ..
mkdir inputs
cd inputs
unzip ../input_training_lowres.zip
cd ../../

