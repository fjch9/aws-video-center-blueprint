import org.craftercms.engine.exception.HttpStatusCodeException

if(!profile) {
	throw new HttpStatusCodeException(403, "User not logged in")
}

def videos = applicationContext.videoService.resolveVideosFromIds(profile.attributes?.favoriteVideos)

return [
	items: videos,
	total: videos?.size() ?: 0
]
