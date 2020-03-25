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

@Grab(group='com.amazonaws', module='aws-java-sdk-s3', version='1.11.210')
import com.amazonaws.HttpMethod

import org.craftercms.site.videocenter.utils.DeviceUtils

import groovy.util.logging.Slf4j

@Slf4j
class S3Service {
  
  def int urlExpiration
  def client
  
  def getUrl(request, videoItem) {
    def bucket = videoItem.output_bucket.text
    def expiration = new Date(new Date().getTime() + urlExpiration * 1000)
    def suffix = DeviceUtils.getSuffix(request)
    def key = "${videoItem.base_key.text}$suffix"
    
    return client.generatePresignedUrl(bucket, key, expiration, HttpMethod.GET)
  }
  
}
