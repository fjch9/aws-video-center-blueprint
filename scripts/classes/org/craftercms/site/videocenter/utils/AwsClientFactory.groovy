package org.craftercms.site.videocenter.utils

@Grab(group='com.amazonaws', module='aws-java-sdk-s3', version='1.11.210')
import com.amazonaws.services.s3.AmazonS3Client
import com.amazonaws.services.s3.AmazonS3ClientBuilder
import com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration
import com.amazonaws.regions.Regions
import com.amazonaws.auth.AWSStaticCredentialsProvider
import com.amazonaws.auth.BasicAWSCredentials

import org.springframework.beans.factory.FactoryBean

import groovy.util.logging.Slf4j

@Slf4j
class AwsClientFactory implements FactoryBean<AmazonS3Client> {
  
  def region
  def endpoint
  def accessKey
  def secretKey
  
  def AmazonS3Client getObject() {
    def client = AmazonS3ClientBuilder.standard()
    .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
    
    if (endpoint != null & endpoint != "") {
      client.withEndpointConfiguration(new EndpointConfiguration(endpoint, region))
      } else {
        client.withRegion(Regions.valueOf(region))
      }
      
      return client.build()
    }
    
    def Class<?> getObjectType() {
      return AmazonS3Client.class
    }
    
    def boolean isSingleton() {
      return true
    }
    
  }
