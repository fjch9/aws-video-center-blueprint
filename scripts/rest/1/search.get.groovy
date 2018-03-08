def q = params.q ?: 'content-type:"/component/video"'
def start = params.start? params.start as int : 0
def rows = params.rows? params.rows as int : 5
def sort = params.sort?: ""

return applicationContext.videoService.searchVideos(q, start, rows, sort)
