def limit = params.limit ? params.limit as int : 10

return applicationContext.videoService.searchStreams(limit)
