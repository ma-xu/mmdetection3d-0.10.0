<div align="center">
  <img src="resources/mmdet3d-logo.png" width="600"/>
</div>

[![docs](https://img.shields.io/badge/docs-latest-blue)](https://mmdetection3d.readthedocs.io/en/latest/)
[![badge](https://github.com/open-mmlab/mmdetection3d/workflows/build/badge.svg)](https://github.com/open-mmlab/mmdetection3d/actions)
[![codecov](https://codecov.io/gh/open-mmlab/mmdetection3d/branch/master/graph/badge.svg)](https://codecov.io/gh/open-mmlab/mmdetection3d)
[![license](https://img.shields.io/github/license/open-mmlab/mmdetection3d.svg)](https://github.com/open-mmlab/mmdetection3d/blob/master/LICENSE)

```bash
# My GCP Environment:
sys.platform: linux
Python: 3.7.10 | packaged by conda-forge | (default, Feb 19 2021, 16:07:37) [GCC 9.3.0]
CUDA available: True
GPU 0: Tesla V100-SXM2-16GB
CUDA_HOME: /usr/local/cuda
NVCC: Build cuda_11.0_bu.TC445_37.28540450_0
GCC: gcc (Debian 8.3.0-6) 8.3.0
PyTorch: 1.7.0
PyTorch compiling details: PyTorch built with:
  - GCC 7.3
  - C++ Version: 201402
  - Intel(R) Math Kernel Library Version 2020.0.2 Product Build 20200624 for Intel(R) 64 architecture applications
  - Intel(R) MKL-DNN v1.6.0 (Git Hash 5ef631a030a6f73131c77892041042805a06064f)
  - OpenMP 201511 (a.k.a. OpenMP 4.5)
  - NNPACK is enabled
  - CPU capability usage: AVX2
  - CUDA Runtime 11.0
  - NVCC architecture flags: -gencode;arch=compute_37,code=sm_37;-gencode;arch=compute_50,code=sm_50;-gencode;arch=compute_60,code=sm_60;-gencode;arch=compute_61,code=sm_61;-gencode;arch=compute_70,code=sm_70;-gencode;arch=compute_75,code=sm_75;-gencode;arch=compute_80,code=sm_80;-gencode;arch=compute_37,code=compute_37
  - CuDNN 8.0.3
  - Magma 2.5.2
  - Build settings: BLAS=MKL, BUILD_TYPE=Release, CXX_FLAGS= -Wno-deprecated -fvisibility-inlines-hidden -DUSE_PTHREADPOOL -fopenmp -DNDEBUG -DUSE_FBGEMM -DUSE_QNNPACK -DUSE_PYTORCH_QNNPACK -DUSE_XNNPACK -DUSE_VULKAN_WRAPPER -O2 -fPIC -Wno-narrowing -Wall -Wextra -Werror=return-type -Wno-missing-field-initializers -Wno-type-limits -Wno-array-bounds -Wno-unknown-pragmas -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function -Wno-unused-result -Wno-unused-local-typedefs -Wno-strict-overflow -Wno-strict-aliasing -Wno-error=deprecated-declarations -Wno-stringop-overflow -Wno-psabi -Wno-error=pedantic -Wno-error=redundant-decls -Wno-error=old-style-cast -fdiagnostics-color=always -faligned-new -Wno-unused-but-set-variable -Wno-maybe-uninitialized -fno-math-errno -fno-trapping-math -Werror=format -Wno-stringop-overflow, PERF_WITH_AVX=1, PERF_WITH_AVX2=1, PERF_WITH_AVX512=1, USE_CUDA=ON, USE_EXCEPTION_PTR=1, USE_GFLAGS=OFF, USE_GLOG=OFF, USE_MKL=ON, USE_MKLDNN=ON, USE_MPI=OFF, USE_NCCL=ON, USE_NNPACK=ON, USE_OPENMP=ON, 

TorchVision: 0.8.0
OpenCV: 4.5.1
MMCV: 1.2.7
MMCV Compiler: GCC 7.3
MMCV CUDA Compiler: 11.0
MMDetection: 2.10.0
MMDetection3D: 0.10.0+bb2463b
```

**News**: We released the codebase v0.10.0.

In the recent [nuScenes 3D detection challenge](https://www.nuscenes.org/object-detection?externalData=all&mapData=all&modalities=Any) of the 5th AI Driving Olympics in NeurIPS 2020, we obtained the best PKL award and the second runner-up by multi-modality entry, and the best vision-only results. Code and models will be released soon!

Documentation: https://mmdetection3d.readthedocs.io/

## Introduction

The master branch works with **PyTorch 1.3 to 1.6**.

MMDetection3D is an open source object detection toolbox based on PyTorch, towards the next-generation platform for general 3D detection. It is
a part of the OpenMMLab project developed by [MMLab](http://mmlab.ie.cuhk.edu.hk/).

![demo image](resources/mmdet3d_outdoor_demo.gif)

### Major features

- **Support multi-modality/single-modality detectors out of box**

  It directly supports multi-modality/single-modality detectors including MVXNet, VoteNet, PointPillars, etc.

- **Support indoor/outdoor 3D detection out of box**

  It directly supports popular indoor and outdoor 3D detection datasets, including ScanNet, SUNRGB-D, Waymo, nuScenes, Lyft, and KITTI.
  For nuScenes dataset, we also support [nuImages dataset](https://github.com/open-mmlab/mmdetection3d/tree/master/configs/nuimages).

- **Natural integration with 2D detection**

  All the about **50+ methods, 300+ models**, and modules supported in [MMDetection](https://github.com/open-mmlab/mmdetection/blob/master/docs/model_zoo.md) can be trained or used in this codebase.

- **High efficiency**

  It trains faster than other codebases. The main results are as below. Details can be found in [benchmark.md](./docs/benchmarks.md). We compare the number of samples trained per second (the higher, the better). The models that are not supported by other codebases are marked by `×`.

  | Methods | MMDetection3D | [OpenPCDet](https://github.com/open-mmlab/OpenPCDet) |[votenet](https://github.com/facebookresearch/votenet)| [Det3D](https://github.com/poodarchu/Det3D) |
  |:-------:|:-------------:|:---------:|:-----:|:-----:|
  | VoteNet | 358           | ×         |   77  | ×     |
  | PointPillars-car| 141           | ×         |   ×  | 140     |
  | PointPillars-3class| 107           |44     |   ×      | ×    |
  | SECOND| 40           |30     |   ×      | ×    |
  | Part-A2| 17           |14     |   ×      | ×    |

Like [MMDetection](https://github.com/open-mmlab/mmdetection) and [MMCV](https://github.com/open-mmlab/mmcv), MMDetection3D can also be used as a library to support different projects on top of it.

## License

This project is released under the [Apache 2.0 license](LICENSE).

## Changelog

v0.10.0 was released in 1/2/2021.
Please refer to [changelog.md](docs/changelog.md) for details and release history.

## Benchmark and model zoo

Supported methods and backbones are shown in the below table.
Results and models are available in the [model zoo](docs/model_zoo.md).

|                    | ResNet   | ResNeXt  | SENet    |PointNet++ | HRNet | RegNetX | Res2Net |
|--------------------|:--------:|:--------:|:--------:|:---------:|:-----:|:--------:|:-----:|
| SECOND             | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| PointPillars       | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| FreeAnchor         | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| VoteNet            | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| H3DNet            | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| 3DSSD            | ✗        | ✗        | ✗        | ✓         | ✗     | ✗        | ✗     |
| Part-A2            | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| MVXNet             | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| CenterPoint        | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |
| SSN                | ☐        | ☐        | ☐        | ✗         | ☐     | ✓        | ☐     |

Other features
- [x] [Dynamic Voxelization](configs/carafe/README.md)

**Note:** All the about **300 models, methods of 40+ papers** in 2D detection supported by [MMDetection](https://github.com/open-mmlab/mmdetection/blob/master/docs/model_zoo.md) can be trained or used in this codebase.

## Installation

Please refer to [getting_started.md](docs/getting_started.md) for installation.

## Get Started

Please see [getting_started.md](docs/getting_started.md) for the basic usage of MMDetection3D. We provide guidance for quick run [with existing dataset](docs/1_exist_data_model.md) and [with customized dataset](docs/2_new_data_model.md) for beginners. There are also tutorials for [learning configuration systems](docs/tutorials/config.md), [adding new dataset](docs/tutorials/customize_dataset.md), [designing data pipeline](docs/tutorials/data_pipeline.md), [customizing models](docs/tutorials/customize_models.md), [customizing runtime settings](docs/tutorials/customize_runtime.md) and [waymo dataset](docs/tutorials/waymo.md).

## Contributing

We appreciate all contributions to improve MMDetection3D. Please refer to [CONTRIBUTING.md](.github/CONTRIBUTING.md) for the contributing guideline.

## Acknowledgement

MMDetection3D is an open source project that is contributed by researchers and engineers from various colleges and companies. We appreciate all the contributors as well as users who give valuable feedbacks.
We wish that the toolbox and benchmark could serve the growing research community by providing a flexible toolkit to reimplement existing methods and develop their own new 3D detectors.
