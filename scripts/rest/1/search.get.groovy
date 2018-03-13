def q = params.q ?: 'content-type:"/component/video" OR (content-type:"/component/stream" AND endDate_dt:[NOW TO *])'
def start = params.start? params.start as int : 0
def rows = params.rows? params.rows as int : 5
def sort = params.sort?: ""

return applicationContext.videoService.searchVideos(q, start, rows, sort)
