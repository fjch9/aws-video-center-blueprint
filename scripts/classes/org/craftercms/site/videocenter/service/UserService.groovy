package org.craftercms.site.videocenter.service

import groovy.util.logging.Slf4j

@Slf4j
class UserService {
  
  def tenantsResolver
  def profileService
  def mailService
  
  def verifyUrl
  def emailAddress
  def emailSubject
  def emailTemplate
  
  def updateProfile(profileId, updates, password) {
    profileService.updateAttributes(profileId, updates)
    
    if(password) {
      profileService.updateProfile(profileId, null, password, null, null, null, null)
    }
  }
  
  def sendVerificationEmail(profile) {
    def token = profileService.createVerificationToken(profile.id.toString())
    def verificationUrl = urlTransformationService.transform("toFullUrl", "${verifyUrl}?token=${token.id}")
    def model = [:]
    model.profile = profile
    model.verificationUrl = verificationUrl
    
    mailService.sendEmail(emailAddress, profile.email, emailSubject, emailTemplate, model)
  }
  
  def createProfile(email, username, password) {
    def tenantName = tenantsResolver.tenants[0]
    def profile = profileService.getProfileByUsername(tenantName, email)
    if (profile == null) {
      profile = profileService.createProfile(tenantName, username, password, email, false, null, null, null)
      sendVerificationEmail(profile)
      return true
    } else {
      return false
    }
  }
    
  def toggleVideo(profile, String videoId, String attributeName) {				
    def list = (profile.attributes[attributeName]) ?: []
    
    if (list && videoId in list) {
      list -= videoId
    } else {
      list << videoId
    }
    
    return profileService.updateAttributes(profile.id.toString(), [(attributeName): list])
  }
      
  def removeVideo(profile, String videoId, String attributeName) {				
    def list = (profile.attributes[attributeName]) ?: []
    
    if (list && videoId in list) {
      list -= videoId
      
      return profileService.updateAttributes(profile.id.toString(), [(attributeName): list])
    } else {
      return profile
    }
  }
  
  def videoIsInList(profile, String videoId, String attributeName) {
    def list = profile.attributes[attributeName]
    
    return list && videoId in list
  }
  
}
