import org.craftercms.engine.exception.HttpStatusCodeException

if(!params.id) {
	throw new HttpStatusCodeException(400, "Missing id parameter")
} else if(!profile) {
	throw new HttpStatusCodeException(403, "User not logged in")
}

def userService = applicationContext.userService

return userService.toggleVideo(profile, params.id, "favoriteVideos")
