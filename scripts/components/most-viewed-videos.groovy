import org.apache.commons.lang3.StringUtils
import org.craftercms.site.videocenter.utils.VideoUtils

def mongo = applicationContext.mongoClient
def db = mongo.getDB("videocenter")
def limit = contentModel.maxVideosToDisplay.text as int
def videos = []

def mostViews = db.videoViews.find().limit(limit).sort(count: -1)
if (mostViews) {
	mostViews.each {singleVideoViews ->
		def videoId = singleVideoViews.videoId
		def videoPath = "/site/videos/${videoId}.xml"
		def videoItem = siteItemService.getSiteItem(videoPath)

		if (videoItem) {
			def video = [:]
					videos << VideoUtils.processItem(profileService, db, videoItem)
		}	else {
			logger.warn("Video ${url} not found")
		}
	}
}

templateModel.videos = videos
