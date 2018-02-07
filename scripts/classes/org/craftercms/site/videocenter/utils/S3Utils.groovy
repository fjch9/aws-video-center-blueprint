package org.craftercms.site.videocenter.utils

@Grab(group='com.amazonaws', module='aws-java-sdk-s3', version='1.11.210')
import com.amazonaws.services.s3.AmazonS3ClientBuilder
import com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration
import com.amazonaws.regions.Regions
import com.amazonaws.auth.AWSStaticCredentialsProvider
import com.amazonaws.auth.BasicAWSCredentials
import com.amazonaws.HttpMethod

class S3Utils {
  
  static def KEY_CONFIG = "aws"
  static def KEY_REGION = "region"
  static def KEY_ENDPOINT = "endpoint"
  static def KEY_ACCESS_KEY = "accessKey"
  static def KEY_SECRET_KEY = "secretKey"
  static def KEY_BUCKET = "bucket"
  static def KEY_URL_EXPIRATION = "urlExpiration"
  
  static def getClient(awsConfig) {
    def endpoint = awsConfig.getString(KEY_ENDPOINT)
    def accessKey = awsConfig.getString(KEY_ACCESS_KEY)
    def secretKey = awsConfig.getString(KEY_SECRET_KEY)
    
    def client = AmazonS3ClientBuilder.standard()
            .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))

	if (endpoint) {
    	client.withEndpointConfiguration(new EndpointConfiguration(endpoint, awsConfig.getString(KEY_REGION)))
    } else {
    	client.withRegion(Regions.valueOf(awsConfig.getString(KEY_REGION)))
    }
    
    return client.build()
  }
  
  static def getUrl(client, bucket, key, expiration) {
    return client.generatePresignedUrl(bucket, key, expiration, HttpMethod.GET)
  }
  
  static def getUrl(request, config, videoItem) {
    def client = getClient(config)
    def bucket = config.getString(KEY_BUCKET, videoItem.output_bucket.text)
    def expiration = new Date(new Date().getTime() + config.getInt(KEY_URL_EXPIRATION) * 1000)
    def suffix = DeviceUtils.getSuffix(request)
    def key = "${videoItem.base_key.text}$suffix"
    
    return getUrl(client, bucket, key, expiration)
  }
  
}