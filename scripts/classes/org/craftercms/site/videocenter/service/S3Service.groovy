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
