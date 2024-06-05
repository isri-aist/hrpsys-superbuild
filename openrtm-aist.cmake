execute_process(COMMAND uname -p OUTPUT_VARIABLE uname_p OUTPUT_STRIP_TRAILING_WHITESPACE)

string(TOLOWER "${CMAKE_BUILD_TYPE}" build_type)

if("${build_type}" STREQUAL "debug")
  set(openrtm-aist-configure-flags "--enable-debug")
else()
  set(openrtm-aist-configure-flags "")
endif()

AddProject(openrtm-aist
  SUBFOLDER 3rd-party/openrtm
  GITHUB isri-aist/openrtm-aist-cpp
  GIT_TAG origin/master
  CONFIGURE_COMMAND
    ${CMAKE_COMMAND} -E chdir <SOURCE_DIR>
    ${CMAKE_COMMAND} -E env LIBPATH=/usr/lib/${uname_p}-linux-gnu
    ./configure --prefix=${CMAKE_INSTALL_PREFIX} --without-doxygen ${openrtm-aist-configure-flags}
  BUILD_COMMAND make -C <SOURCE_DIR>
  INSTALL_COMMAND make -C <SOURCE_DIR> install
  SKIP_TEST
  NO_SOURCE_MONITOR
  APT_PACKAGES openrtm-aist-dev
)

if(NOT USE_MC_RTC_APT_MIRROR)
  ExternalProject_Add_Step(openrtm-aist generate-configure
    COMMAND ./build/autogen
    WORKING_DIRECTORY <SOURCE_DIR>
    DEPENDEES patch
    DEPENDERS configure
  )
endif()

AddProject(openrtm-aist-python
  SUBFOLDER 3rd-party/openrtm
  GITHUB gergondet/openrtm-aist-python-deb
  GIT_TAG origin/master
  CONFIGURE_COMMAND ""
  BUILD_COMMAND
    ${CMAKE_COMMAND} -E chdir <SOURCE_DIR>
    python2 setup.py build
  INSTALL_COMMAND
    ${CMAKE_COMMAND} -E chdir <SOURCE_DIR>
    sudo python2 setup.py install
  SKIP_TEST
  NO_SOURCE_MONITOR
  DEPENDS openrtm-aist
  APT_PACKAGES openrtm-aist-python
)
