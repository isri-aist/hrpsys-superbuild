set(mc_openrtm_DEPENDS mc_rtc choreonoid)
AddProject(mc_openrtm
  GITHUB ThomasDuvinage/mc_openrtm.git
  GIT_TAG origin/ubuntu2204+rtm2
  DEPENDS ${mc_openrtm_DEPENDS}
  APT_PACKAGES jvrc-choreonoid
)

AddProject(mc_udp
  GITHUB ThomasDuvinage/mc_udp
  GIT_TAG origin/ubuntu2204+rtm2
  DEPENDS mc_rtc choreonoid
  APT_PACKAGES libmc-udp-dev python-mc-udp python3-mc-udp mc-udp-openrtm mc-udp-control
)