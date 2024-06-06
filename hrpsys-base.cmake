set(STAMP_FILE "${CMAKE_CURRENT_BINARY_DIR}/omniorb-cfg.stamp")
add_custom_command(
  OUTPUT "${STAMP_FILE}"
  COMMAND sudo sed -i -e "s/giopMaxMsgSize = 2097152/giopMaxMsgSize = 2147483648/" /etc/omniORB.cfg
  COMMAND "${CMAKE_COMMAND}" -E touch "${STAMP_FILE}"
  COMMENT "Set omniORB giopMaxMsgSize"
)
add_custom_target(configure-omniorb DEPENDS "${STAMP_FILE}")

set(openhrp3_cmake_args -DCOMPILE_JAVA_STUFF=OFF -DCOMPILE_PYTHON_STUFF=ON -DBUILD_GOOGLE_TEST=OFF -DOPENRTM_DIR=${CMAKE_INSTALL_PREFIX})
AddProject(openhrp3
  SUBFOLDER openhrp
  GITHUB fkanehiro/openhrp3
  GIT_TAG origin/master
  CMAKE_ARGS ${openhrp3_cmake_args}
  SKIP_TEST
  DEPENDS openrtm-aist-python
  APT_PACKAGES openhrp
)
add_dependencies(openhrp3 configure-omniorb)

set(hrpsys-base_cmake_args -DCOMPILE_JAVA_STUFF=OFF -DBUILD_KALMAN_FILTER=ON -DBUILD_STABILIZER=OFF -DENABLE_DOXYGEN=OFF -DUSE_HRPSYSEXT=OFF -DOPENRTM_DIR=${CMAKE_INSTALL_PREFIX} -DINSTALL_HRPIO=ON)
AddProject(hrpsys-base
  SUBFOLDER openhrp
  GITHUB fkanehiro/hrpsys-base
  GIT_TAG origin/master
  CMAKE_ARGS ${hrpsys-base_cmake_args}
  SKIP_TEST
  DEPENDS openhrp3
  APT_PACKAGES hrpsys-base
)
