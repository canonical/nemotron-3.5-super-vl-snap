# Nemotron 3.5 Super VL inference snap
[![nemotron-3-5-super-vl](https://snapcraft.io/nemotron-3-5-super-vl/badge.svg)](https://snapcraft.io/nemotron-3-5-super-vl)



Nemotron 3.5 Super VL is a large language model published by NVIDIA. See the
[model card](https://build.nvidia.com/nvidia/nemotron-3.5-super-vl-120b-a12b/modelcard)
for details on capabilities, intended use and licensing.

Use this snap to quickly install an optimized environment for local inference with Nemotron 3.5 Super VL.

The snap includes the following hardware-optimized inference engines:

* cpu: Optimized for x64 and ARM (armv8, armv9) CPUs
* nvidia-gpu: CUDA-enabled GPU acceleration

The most suitable engine is automatically selected based on the available hardware.

#### Install
```
sudo snap install nemotron-3-5-super-vl
```

#### Run
```
nemotron-3-5-super-vl
```

> [!TIP]
> Some accelerators require extra [drivers](https://documentation.ubuntu.com/inference-snaps/how-to/setup/drivers/) to be usable with this snap.


## Resources

📚 **[Documentation](https://documentation.ubuntu.com/inference-snaps/)**, learn how to use inference snaps

💬 **[Discussions](https://github.com/canonical/inference-snaps/discussions)**, ask questions and share ideas

🐛 **[Issues](https://github.com/canonical/inference-snaps/issues)**, report bugs and request features

## Build and install from source

Clone the repo:
```shell
git clone https://github.com/canonical/nemotron-3-5-super-vl-snap
cd nemotron-3-5-super-snap-vl
```

Initialize the development environment:
```shell
make init
```

Build and install snap:
```shell
make build
make install
```
