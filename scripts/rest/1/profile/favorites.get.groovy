import org.craftercms.engine.exception.HttpStatusCodeException
import org.craftercms.site.videocenter.utils.VideoUtils

if(!profile) {
	throw new HttpStatusCodeException(403, "User not logged in")
}

def mongo = applicationContext.mongoClient
def db = mongo.getDB("videocenter")

def videos = profile.attributes?.favoriteVideos?.collect { videoId ->
	def item = siteItemService.getSiteItem("/site/videos/${videoId}.xml")
    
    VideoUtils.processItem(profileService, db, item)
}

return [
	items: videos,
	total: videos?.size() ?: 0
]