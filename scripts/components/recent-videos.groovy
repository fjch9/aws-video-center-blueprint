def rows = contentModel.maxVideosToDisplay.text as int

templateModel.videos = applicationContext.videoService.searchRecentVideos(rows)
