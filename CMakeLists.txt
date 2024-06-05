execute_process(COMMAND lsb_release -sc OUTPUT_VARIABLE DISTRO OUTPUT_STRIP_TRAILING_WHITESPACE)
iF("${DISTRO}" STREQUAL "bionic")
  set(PYTHON2DEV_PKG python-dev)
else()
  set(PYTHON2DEV_PKG python2-dev)
endif()

option(WITH_CHOREONOID "Build choreonoid" ON)

# Extra APT dependencies
set(hrpsys_APT_DEPENDENCIES
  autoconf
  f2c
  libtool-bin
  libsdl-dev
  libglew-dev
  libopencv-dev
  libqhull-dev
  libyaml-dev
  libncurses5-dev
  libzbar-dev
  freeglut3-dev
  libxmu-dev
  libglpk-dev
  libpcl-dev
  libproj-dev
  libusb-1.0-0-dev
  libusb-dev
  libzip-dev
  doxygen
  libqt5x11extras5-dev
  libxfixes-dev
  libomniorb4-dev
  python-omniorb
  omniorb-nameserver
  omniidl
  omniidl-python
  libqt5svg5-dev
  python-yaml
  python-tk
  libfmt-dev
  gettext
  libcollada-dom-dev
  ${PYTHON2DEV_PKG}
  python3-dev
  libzip-dev
)

AptInstall(${hrpsys_APT_DEPENDENCIES})

include(openrtm-aist.cmake)
include(hrpsys-base.cmake)

if (WITH_CHOREONOID)
  include(choreonoid.cmake)
  include(mc-openrtm.cmake)
endif()
