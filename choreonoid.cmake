set(choreonoid_DEPENDS hrpsys-base)
set(CUSTOMIZERS "")
set(CUSTOMIZER_OPTIONS -DBODY_CUSTOMIZERS=${CUSTOMIZERS})
set(CMAKE_EXTRA_ARGS -DCHOREONOID_PLUGIN_LINK_USE_KEYWORD:BOOL=ON)
set(choreonoid_cmake_args
  -DCMAKE_BUILD_TYPE=$<CONFIG>
  ${CUSTOMIZER_OPTIONS}
  -DCMAKE_CXX_STANDARD=17
  -DENABLE_CORBA=ON
  -DBUILD_CORBA_PLUGIN=ON
  -DBUILD_OPENRTM_PLUGIN=ON
  -DUSE_BUILTIN_CAMERA_IMAGE_IDL=ON
  -DBUILD_PCL_PLUGIN=ON
  -DBUILD_OPENHRP_PLUGIN=ON
  -DBUILD_GRXUI_PLUGIN=ON
  -DBUILD_DRC_USER_INTERFACE_PLUGIN=ON
  -DROBOT_HOSTNAME="$ENV{ROBOT_HOSTNAME}"
  -DBUILD_ASSIMP_PLUGIN=OFF
  -DUSE_PYBIND11=ON
  -DUSE_PYTHON3=ON
  -DBUILD_BALANCER_PLUGIN=OFF
  -DENABLE_PYTHON=ON
  -DBUILD_PYTHON_SIM_SCRIPT_PLUGIN=OFF
  -DBUILD_BOOST_PYTHON_MODULES=OFF
  -DUSE_EXTERNAL_PYBIND11=ON
  -DBUILD_PYTHON_PLUGIN=ON
  -DBUILD_PYTHON_SIM_SCRIPT_PLUGIN=ON
  -DBUILD_HRPSYS31_PLUGIN=ON
  -DBUILD_ROBOT_ACCESS_PLUGIN=ON
  ${CMAKE_EXTRA_ARGS}
)

if(NOT USE_MC_RTC_APT_MIRROR)
  AddProject(pybind11
    GITHUB pybind/pybind11
    GIT_TAG v2.13
    CMAKE_ARGS -DPYBIND11_INSTALL=ON -DPYBIND11_TEST=OFF
  )
  list(APPEND choreonoid_DEPENDS pybind11)
endif()

# TODO change to choreonoid master branch when https://github.com/choreonoid/robot-access-plugin/issues/2 will be fixed 
AddProject(choreonoid
  GITHUB ThomasDuvinage/choreonoid
  GIT_TAG origin/release-2.2
  CMAKE_ARGS -DUSE_BUNDLED_PYBIND11=OFF ${choreonoid_cmake_args}
  DEPENDS ${choreonoid_DEPENDS}
  APT_PACKAGES choreonoid libcnoid-dev
)

if(USE_MC_RTC_APT_MIRROR)
  return()
endif()

AddProjectPlugin(choreonoid-openrtm choreonoid
  GITHUB fkanehiro/choreonoid-openrtm
  GIT_TAG origin/ubuntu2204+rtm2
  SUBFOLDER ext
)

AddProjectPlugin(openhrp-plugin choreonoid
  GITHUB isri-aist/openhrp-plugin
  GIT_TAG origin/master
  SUBFOLDER ext
)

AddProjectPlugin(grxui-plugin choreonoid
  GITHUB isri-aist/grxui-plugin
  GIT_TAG origin/master
  SUBFOLDER ext
)

# TODO change to main repo when PR is merged https://github.com/choreonoid/robot-access-plugin/pull/3
AddProjectPlugin(robot-access-plugin choreonoid
  GITHUB ThomasDuvinage/robot-access-plugin
  GIT_TAG origin/master
  SUBFOLDER ext
)
