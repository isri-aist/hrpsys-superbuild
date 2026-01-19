find_package(OpenRTM QUIET)

# Execute OpenRTM install once if it has not already been installed
if (NOT OpenRTM_FOUND)
  execute_process(
    COMMAND curl -s -o /tmp/openrtm2_install_ubuntu.sh https://raw.githubusercontent.com/OpenRTM/OpenRTM-aist/master/scripts/openrtm2_install_ubuntu.sh
    RESULT_VARIABLE download_result
  )

  if(NOT download_result EQUAL 0)
    message(FATAL_ERROR "Failed to download the openrtm2 installation script")
  endif()

  execute_process(
    COMMAND bash "-c" "yes | bash /tmp/openrtm2_install_ubuntu.sh"
    RESULT_VARIABLE install_result
  )

  if(NOT install_result EQUAL 0)
    message(FATAL_ERROR "OPENRTM2 installation script failed to execute")
  endif()

  execute_process(
    COMMAND ${SUDO_CMD} sed -i "s/dl rt Threads::Threads/-ldl -lrt/g" /usr/bin/rtm2-config
  )

  execute_process(
    COMMAND ${SUDO_CMD} sed -i "s/-lrtmCamera -lrtmManipulator//g" /usr/bin/rtm2-config
  )
else()
  message(STATUS "OpenRTM Found : Not running the installation procedure")
endif()

