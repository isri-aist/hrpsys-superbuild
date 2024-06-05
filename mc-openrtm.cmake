set(mc_openrtm_DEPENDS mc_rtc choreonoid)
AddProject(mc_openrtm
  GITHUB jrl-umi3218/mc_openrtm
  GIT_TAG origin/master
  DEPENDS ${mc_openrtm_DEPENDS}
  APT_PACKAGES jvrc-choreonoid
)

AddProject(mc_udp
  GITHUB jrl-umi3218/mc_udp
  GIT_TAG origin/master
  DEPENDS mc_rtc choreonoid
  APT_PACKAGES libmc-udp-dev python-mc-udp python3-mc-udp mc-udp-openrtm mc-udp-control
)
