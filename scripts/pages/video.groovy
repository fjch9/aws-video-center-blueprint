import org.craftercms.engine.exception.HttpStatusCodeException

def videoService = applicationContext.videoService
def userService = applicationContext.userService

// Get actual video
def videoId = params.id
def video = null

if (videoId) {
    video = siteItemService.getSiteItem("/site/videos/${videoId}.xml")
    if (video) {
    	templateModel.video = video
    } else {
    	throw new HttpStatusCodeException(404, "Video ${videoPath} not found")
    }
} else {
	throw new HttpStatusCodeException(400, "No param 'id' provided in request")
}

def views = videoService.updateVideoViewCount(videoId)
if (views) {
	templateModel.viewCount = views.count
}

def socialCounts = videoService.getVideoSocialCounts(videoId)
templateModel.likeCount = socialCounts.liked
templateModel.dislikeCount = socialCounts.disliked

templateModel.videoUrl = applicationContext.s3Service.getUrl(request, video.video.item)

// Get related videos
def rows = contentModel.maxRelatedVideosToDisplay.text as int
templateModel.relatedVideos = videoService.searchRelatedVideos(video, rows)

templateModel.breadcrumbs = [
	[url: "/", label: "Home"],
	[url: "/all-videos", label: "Videos"],
	[url: "/video?id=${videoId}", label: video.title_s]
]

if(profile) {
  templateModel.isFavorite = userService.videoIsInList(profile, videoId, "favoriteVideos")
  templateModel.isLiked = userService.videoIsInList(profile, videoId, "likedVideos")
  templateModel.isDisliked = userService.videoIsInList(profile, videoId, "dislikedVideos")
}
