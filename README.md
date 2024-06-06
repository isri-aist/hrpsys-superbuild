# [hrpsys-superbuild](https://github.com/isri-aist/hrpsys-superbuild)
mc-rtc-superbuild extension for hrpsys and choreonoid

## Summary
This repository is an extension repository for [mc-rtc-superbuild](https://github.com/mc-rtc/mc-rtc-superbuild).

It builds:
- [openrtm-aist](https://github.com/isri-aist/openrtm-aist-cpp) and [openrtm-aist-python](https://github.com/gergondet/openrtm-aist-python-deb) from [openrtm-aist.cmake](openrtm-aist.cmake)
- [openhrp3](https://github.com/fkanehiro/openhrp3) and [hrpsys-base](https://github.com/fkanehiro/hrpsys-base) from [hrpsys-base.cmake](hrpsys-base.cmake)
- [choreonoid](https://github.com/choreonoid/choreonoid) from [choreonoid.cmake](choreonoid.cmake)
- [mc_openrtm](https://github.com/jrl-umi3218/mc_openrtm) and [mc_udp](https://github.com/jrl-umi3218/mc_udp) from [mc-openrtm.cmake](mc-openrtm.cmake)

## Install
- Tested with Ubuntu 20.04 / ROS Noetic

First, install ROS. See [here](https://wiki.ros.org/noetic/Installation/Ubuntu) for details.

Install ccache and increase the cache size for ccache.
```bash
$ sudo apt install ccache
$ ccache -M 10G
```

Clone all sources, build, and install.
```bash
$ mkdir ~/workspace
$ cd ~/workspace
$ git clone https://github.com/mc-rtc/mc-rtc-superbuild
$ git clone git@github.com:isri-aist/hrpsys-superbuild mc-rtc-superbuild/extensions/hrpsys-superbuild
$ cd mc-rtc-superbuild
$ ./utils/bootstrap-linux.sh
$ mkdir -p build && cd build
$ cmake ../ -DSOURCE_DESTINATION=$HOME/workspace/src/ -DBUILD_DESTINATION=$HOME/workspace/build -DCMAKE_INSTALL_PREFIX=$HOME/workspace/install -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_COMPILER_LAUNCHER="ccache" -DCMAKE_CXX_COMPILER_LAUNCHER="ccache"
$ cmake --build .
```

Add the following line to `~/.bashrc`.
```bash
export PATH=$HOME/workspace/install/bin:$PATH
export PKG_CONFIG_PATH=$HOME/workspace/install/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$HOME/workspace/install/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/workspace/install/lib/python3.8/site-packages:$PYTHONPATH
source $HOME/workspace/src/catkin_ws/devel/setup.bash
```

## Example
Put the following contents in `~/.config/mc_rtc/mc_rtc.yaml`.
```bash
MainRobot: JVRC1
Timestep: 0.005
Enabled: Posture
```

Run a kinematics simulation.
```bash
# Terminal 1
$ roscore
# Terminal 2
$ mc_rtc_ticker
# Terminal 3
$ roslaunch mc_rtc_ticker display.launch
```

Run a dynamics simulation.
```bash
# Terminal 1
$ roscore
# Terminal 2
$ cd ~/workspace/install/share/hrpsys/samples/JVRC1/
$ ./clear-omninames.sh # Only needed the first time after booting Ubuntu
$ choreonoid sim_mc.cnoid --start-simulation
# Terminal 3
$ roslaunch mc_rtc_ticker display.launch
```
