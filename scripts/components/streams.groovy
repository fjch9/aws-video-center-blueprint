def limit = contentModel.maxVideosToDisplay.text as int

templateModel.videos = applicationContext.videoService.getStreams(limit)
