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
