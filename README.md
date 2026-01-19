# [hrpsys-superbuild](https://github.com/isri-aist/hrpsys-superbuild)
mc-rtc-superbuild extension for hrpsys and choreonoid

## Summary
This repository is an extension repository for [mc-rtc-superbuild](https://github.com/mc-rtc/mc-rtc-superbuild).

It downloads:
- [openrtm2](https://openrtm.org/openrtm/en) packages

It builds:
- [openhrp3](https://github.com/fkanehiro/openhrp3/tree/ubuntu2204%2Brtm2) and [hrpsys-base](https://github.com/fkanehiro/hrpsys-base/tree/ubuntu2204%2Brtm2) from [hrpsys-base.cmake](hrpsys-base.cmake)
- [choreonoid](https://github.com/ThomasDuvinage/choreonoid/tree/release-2.2) from [choreonoid.cmake](choreonoid.cmake)
- [mc_openrtm](https://github.com/ThomasDuvinage/mc_openrtm/tree/ubuntu2204%2Brtm2) and [mc_udp](https://github.com/ThomasDuvinage/mc_udp/tree/ubuntu2204%2Brtm2) from [mc-openrtm.cmake](mc-openrtm.cmake)

> Please note that PR have been opened and will be merged soon for `mc_openrtm` and `mc_udp`.

## Install
- Tested with Ubuntu 22.04 / ROS Humble

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
$ cmake --preset  relwithdebinfo
$ cmake --build --preset relwithdebinfo
```

Add the following line to `~/.bashrc`.
```bash
source $HOME/workspace/install/setup_mc_rtc.sh
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
$ mc_rtc_ticker
# Terminal 2
$ ros2 launch mc_rtc_ticker display.launch
```

Run a dynamics simulation.
```bash
# Terminal 1
$ cd ~/workspace/install/share/hrpsys/samples/JVRC1/
$ ./clear-omninames.sh # Only needed the first time after booting Ubuntu
$ choreonoid sim_mc.cnoid --start-simulation
# Terminal 2
$ ros2 launch mc_rtc_ticker display.launch
```
