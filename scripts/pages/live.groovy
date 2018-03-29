import org.craftercms.engine.exception.HttpStatusCodeException

def videoService = applicationContext.videoService
def userService = applicationContext.userService

// Get actual video
def videoId = params.id
def video = null

if (videoId) {
    video = siteItemService.getSiteItem("/site/streams/${videoId}.xml")
    if (video) {
      templateModel.video = video
      templateModel.startTimestamp = video.startDate_dt.time / 1000 as int
      templateModel.endTimestamp = video.endDate_dt.time / 1000 as int
      templateModel.origins = video.origin.item.collect { siteItemService.getSiteItem(it.key.text) }
    } else {
    	throw new HttpStatusCodeException(404, "Video ${videoId} not found")
    }
} else {
	throw new HttpStatusCodeException(400, "No param 'id' provided in request")
}


templateModel.streamStatus = videoService.getStreamStatus(video)

def views = videoService.updateVideoViewCount(videoId)
if (views) {
	templateModel.viewCount = views.count
}

def socialCounts = videoService.getVideoSocialCounts(videoId)
templateModel.likeCount = socialCounts.liked
templateModel.dislikeCount = socialCounts.disliked

// Get related videos
def rows = contentModel.maxRelatedVideosToDisplay.text as int
templateModel.relatedVideos = videoService.searchRelatedVideos(video, rows)

templateModel.breadcrumbs = [
	[url: "/", label: "Home"],
	[url: "/all-videos", label: "Videos"],
	[url: "/live?id=${videoId}", label: video.title_s]
]

if(profile) {
  templateModel.isFavorite = userService.videoIsInList(profile, videoId, "favoriteVideos")
  templateModel.isLiked = userService.videoIsInList(profile, videoId, "likedVideos")
  templateModel.isDisliked = userService.videoIsInList(profile, videoId, "dislikedVideos")
}
