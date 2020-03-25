/* 
 *  MIT License
 *  
 *  Copyright (C) 2018-2020 Crafter Software Corporation. All Rights Reserved.
 *  
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *  
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

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