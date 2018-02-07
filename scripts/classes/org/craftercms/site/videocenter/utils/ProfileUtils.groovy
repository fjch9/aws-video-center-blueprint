package org.craftercms.site.videocenter.utils

import org.craftercms.profile.api.Profile

import groovy.util.logging.Slf4j

@Slf4j
class ProfileUtils {
	
	private def ProfileUtils() {
	}
	
	static def toggleVideo(profileService, Profile profile, String videoId, String attributeName) {				
		def list = (profile.attributes[attributeName]) ?: []

		if (list && videoId in list) {
			list -= videoId
		} else {
			list << videoId
		}

		return profileService.updateAttributes(profile.id.toString(), [(attributeName): list])
	}
    
	static def removeVideo(profileService, Profile profile, String videoId, String attributeName) {				
		def list = (profile.attributes[attributeName]) ?: []

		if (list && videoId in list) {
			list -= videoId
            
            return profileService.updateAttributes(profile.id.toString(), [(attributeName): list])
		} else {
        	return profile
        }
	}
	
	static def videoIsInList(Profile profile, String videoId, String attributeName) {
		def list = profile.attributes[attributeName]
		
        return list && videoId in list
	}
	
}