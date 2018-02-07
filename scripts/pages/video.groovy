import org.craftercms.engine.exception.HttpStatusCodeException
import org.craftercms.site.videocenter.utils.ProfileUtils
import org.craftercms.site.videocenter.utils.S3Utils
import org.craftercms.site.videocenter.utils.VideoUtils
import org.apache.commons.lang3.StringUtils

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

def mongo = applicationContext.mongoClient
def db = mongo.getDB("videocenter")

// Increment view count
db.videoViews.update([videoId: videoId], [$inc: [count: 1]], true)

// Get current view count
def views = db.videoViews.findOne(videoId: videoId)
if (views) {
	templateModel.viewCount = views.count
}

def tenantName = tenantsResolver.tenants[0]
templateModel.likeCount = profileService.getProfileCountByQuery(tenantName, "{ \"attributes.likedVideos\":\"$videoId\"  }")
templateModel.dislikeCount = profileService.getProfileCountByQuery(tenantName, "{ \"attributes.dislikedVideos\":\"$videoId\"  }")

def awsConfig = siteConfig.configurationAt(S3Utils.KEY_CONFIG)
templateModel.videoUrl = S3Utils.getUrl(request, awsConfig, video.video.item)

// Get related videos
def categories = video.queryValues("//categories/item/key")
def categoriesStr = StringUtils.join(categories, " OR ")
def q = "content-type:\"/component/video\" AND categories.item.key:(${categoriesStr}) AND -localId:\"${video.storeUrl}\""
def rows = contentModel.maxRelatedVideosToDisplay.text as int
def fieldsToReturn = [ "localId" ] as String[]

def query = searchService.createQuery()
		query.query = q
		query.rows = rows
		query.fieldsToReturn = fieldsToReturn
		query.addParam("sort", "date_dt desc")

def results = searchService.search(query)

templateModel.relatedVideos = VideoUtils.resolveVideosFromSearchResults(results, siteItemService, profileService, db)
templateModel.breadcrumbs = [
	[url: "/", label: "Home"],
	[url: "/all-videos", label: "Videos"],
	[url: "/video?id=${videoId}", label: video.title_s]
]

if(profile) {
  templateModel.isFavorite = ProfileUtils.videoIsInList(profile, videoId, "favoriteVideos")
  templateModel.isLiked = ProfileUtils.videoIsInList(profile, videoId, "likedVideos")
  templateModel.isDisliked = ProfileUtils.videoIsInList(profile, videoId, "dislikedVideos")
}