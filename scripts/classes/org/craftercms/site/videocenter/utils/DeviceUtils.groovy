package org.craftercms.site.videocenter.utils

@Grab(group='org.springframework.mobile', module='spring-mobile-device', version='1.1.5.RELEASE')
import org.springframework.mobile.device.LiteDeviceResolver

class DeviceUtils {
  
  static def getSuffix(request) {
    def resolver = new LiteDeviceResolver()

    def device = resolver.resolveDevice(request)

    def suffix = "-large.mp4"

    if(device.isMobile()) {
      suffix = "-small.mp4"
    } else if(device.isTablet()) {
      suffix = "-medium.mp4"
    }

    return suffix
  }
  
}