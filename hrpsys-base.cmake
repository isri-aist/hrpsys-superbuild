add_custom_command(
  OUTPUT "/etc/omniORB.cfg"
  COMMAND sudo ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/omniORB.cfg" "/etc/omniORB.cfg"
  COMMENT "Copying omniORB.cfg to /etc/omniORB.cfg"
)
add_custom_target(copy-omniorb-config ALL DEPENDS "/etc/omniORB.cfg")

set(openhrp3_cmake_args -DCOMPILE_JAVA_STUFF=OFF -DBUILD_GOOGLE_TEST=OFF -DOPENRTM_DIR="/usr")
AddProject(openhrp3
  SUBFOLDER openhrp
  GITHUB fkanehiro/openhrp3
  GIT_TAG origin/ubuntu2204+rtm2
  CMAKE_ARGS ${openhrp3_cmake_args}
  SKIP_TEST
  APT_PACKAGES openhrp
)
add_dependencies(openhrp3 copy-omniorb-config)

set(hrpsys-base_cmake_args -DCOMPILE_JAVA_STUFF=OFF -DBUILD_KALMAN_FILTER=OFF -DBUILD_STABILIZER=OFF -DENABLE_DOXYGEN=OFF -DUSE_HRPSYSEXT=OFF -DENABLE_PCL=OFF -DUSE_HRPSYSUTIL=OFF -DOPENRTM_DIR="/usr")
AddProject(hrpsys-base
  SUBFOLDER openhrp
  GITHUB fkanehiro/hrpsys-base
  GIT_TAG origin/ubuntu2204+rtm2
  CMAKE_ARGS ${hrpsys-base_cmake_args}
  SKIP_TEST
  DEPENDS openhrp3
  APT_PACKAGES hrpsys-base
  CMAKE_ARGS -DCMAKE_POLICY_MINIMUM_VERSION=3.5
)
