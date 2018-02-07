import org.apache.commons.lang3.StringUtils
import org.craftercms.site.videocenter.utils.VideoUtils

def q = 'content-type:"/component/video"'
def rows = contentModel.maxVideosToDisplay.text as int
def fieldsToReturn = [ "localId" ] as String[]

def query = searchService.createQuery()
		query.query = q
		query.rows = rows
		query.fieldsToReturn = fieldsToReturn
		query.addParam("sort", "date_dt desc")

def results = searchService.search(query)
def mongo = applicationContext.mongoClient
def db = mongo.getDB("videocenter")

templateModel.videos = VideoUtils.resolveVideosFromSearchResults(results, siteItemService, profileService, db)
