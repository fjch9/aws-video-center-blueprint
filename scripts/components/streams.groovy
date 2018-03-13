def limit = contentModel.maxVideosToDisplay.text as int

templateModel.videos = applicationContext.videoService.searchStreams(limit)
