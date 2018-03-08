def limit = contentModel.maxVideosToDisplay.text as int

templateModel.videos = applicationContext.videoService.getMostViewedVideos(limit)
