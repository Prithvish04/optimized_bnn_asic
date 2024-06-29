echo This shell script takes as input a MNIST data set and splits it into seperate images.
echo The script requires 2 inputs:
echo input 1 is the name of the MNIST test file. Default is set to t10k-images.idx3-ubyte
echo input 2 is the number of bytes of one test image. Default is set to 784
echo Input 3 is the byte size of the header label. Default is set to 16
echo If the number of files you create is larger than 10000. An error will be generated. In that case increase the -a parameter.

mkdir ./result
dd if=${1:-t10k-images.idx3-ubyte} of=input_file_wo_label-ubyte ibs=${3:-16} skip=1
split -b ${2:-784} -a 4 -d input_file_wo_label-ubyte ./result/img_


