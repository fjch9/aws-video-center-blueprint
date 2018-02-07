import org.craftercms.engine.exception.HttpStatusCodeException

import org.craftercms.site.videocenter.utils.ProfileUtils

if(!params.id) {
	throw new HttpStatusCodeException(400, "Missing id parameter")
} else if(!profile) {
	throw new HttpStatusCodeException(403, "User not logged in")
}

return ProfileUtils.toggleVideo(profileService, profile, params.id, "favoriteVideos")