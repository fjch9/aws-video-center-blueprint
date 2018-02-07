import org.apache.commons.lang3.StringUtils
import org.craftercms.site.videocenter.utils.VideoUtils

def q = params.q ?: 'content-type:"/component/video"'
def start = params.start? params.start as int : 0
def rows = params.rows? params.rows as int : 5
def sort = params.sort?: ""
def fieldsToReturn = [ "localId" ] as String[]

def mongo = applicationContext.mongoClient
def db = mongo.getDB("videocenter")

def query = searchService.createQuery()
		query.query = q
		query.start = start
		query.rows = rows
		query.fieldsToReturn = fieldsToReturn

if (sort) {
	query.addParam("sort", sort)
}

def results = searchService.search(query)

return [
	hasMore: (start + rows) < results.response.numFound,
	total: results.response.numFound,
	items: VideoUtils.resolveVideosFromSearchResults(results, siteItemService, profileService, db)
]
