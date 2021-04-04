#!/usr/bin/env bash
# GO to scratch storage
cd /scratch/$USERNAME

# make data folder and download data
mkdir data
ls
cd data/
mkdir kitti
ls
cd kitti/
ls
wget -b https://s3.eu-central-1.amazonaws.com/avg-kitti/data_object_image_2.zip
wget -b https://s3.eu-central-1.amazonaws.com/avg-kitti/data_object_velodyne.zip
wget -b https://s3.eu-central-1.amazonaws.com/avg-kitti/data_object_calib.zip
wget -b https://s3.eu-central-1.amazonaws.com/avg-kitti/data_object_label_2.zip
# waiting for downloading, usally takes less than 0.5h, or go to set env first.
rm wget-log*
unzip data_object_calib.zip
unzip data_object_image_2.zip
unzip data_object_label_2.zip
unzip data_object_velodyne.zip

cd /scratch/username

# load required modules, CUDA 11.0 ,GCC 5.5
module load cuda/11.0
module load gcc/5.5.0

# set up open-mmlab conda environment, don't forget activate the env when using mmdet3D
# install pytorch 1.7, then mmcv, then mmdet
conda create -n open-mmlab python=3.7 -y
conda activate open-mmlab
conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=11.0 -c pytorch
pip install mmcv-full -f https://download.openmmlab.com/mmcv/dist/cu110/torch1.7.0/index.html
pip install git+https://github.com/open-mmlab/mmdetection.git

# download and install mmdetection3d, one can fork it for further modifications
git clone https://github.com/13952522076/mmdetection3d-0.10.0.git
cd mmdetection3d-0.10.0/
pip install -v -e .

# soft link dataset, and prepare dataset, perparation would take 0.5h.
mkdir data
ln -s /scratch/$USERNAME/data/kitti data/
mkdir ./data/kitti/ImageSets
wget -c  https://raw.githubusercontent.com/traveller59/second.pytorch/master/second/data/ImageSets/test.txt --no-check-certificate --content-disposition -O ./data/kitti/ImageSets/test.txt
wget -c  https://raw.githubusercontent.com/traveller59/second.pytorch/master/second/data/ImageSets/train.txt --no-check-certificate --content-disposition -O ./data/kitti/ImageSets/train.txt
wget -c  https://raw.githubusercontent.com/traveller59/second.pytorch/master/second/data/ImageSets/val.txt --no-check-certificate --content-disposition -O ./data/kitti/ImageSets/val.txt
wget -c  https://raw.githubusercontent.com/traveller59/second.pytorch/master/second/data/ImageSets/trainval.txt --no-check-certificate --content-disposition -O ./data/kitti/ImageSets/trainval.txt
python tools/create_data.py kitti --root-path ./data/kitti --out-dir ./data/kitti --extra-tag kitti


# test if successfully installed, test kitti dataset
mkdir checkpoints
cd checkpoints/
wget https://download.openmmlab.com/mmdetection3d/v0.1.0_models/second/hv_second_secfpn_6x8_80e_kitti-3d-car/hv_second_secfpn_6x8_80e_kitti-3d-car_20200620_230238-393f000c.pth
cd ..
./tools/dist_test.sh configs/second/hv_second_secfpn_6x8_80e_kitti-3d-car.py checkpoints/hv_second_secfpn_6x8_80e_kitti-3d-car_20200620_230238-393f000c.pth 4 --eval mAP

##### If everything correct, we will see following output:
# *****************************************
# Setting OMP_NUM_THREADS environment variable for each process to be 1 in default, to avoid your system being overloaded, please further tune the variable for optimal performance in your application as needed.
# *****************************************
# Use load_from_local loader
# Use load_from_local loader
# Use load_from_local loader
# Use load_from_local loader
# [>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>] 3772/3769, 103.7 task/s, elapsed: 36s, ETA:     0s
# Converting prediction to KITTI format
# [>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>] 3769/3769, 838.8 task/s, elapsed: 4s, ETA:     0s
# Result is saved to /tmp/tmpe0rbk9rt/results.pkl.

# Car AP@0.70, 0.70, 0.70:
# bbox AP:98.5478, 90.0518, 89.3139
# bev  AP:90.5600, 88.4615, 86.0715
# 3d   AP:89.7836, 79.2523, 77.8632
# aos  AP:98.28, 89.56, 88.59
# Car AP@0.70, 0.50, 0.50:
# bbox AP:98.5478, 90.0518, 89.3139
# bev  AP:98.7233, 90.2979, 89.7645
# 3d   AP:98.6713, 90.2561, 89.6637
# aos  AP:98.28, 89.56, 88.59




