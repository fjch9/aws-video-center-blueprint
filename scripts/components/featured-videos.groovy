def rows = contentModel.carouselSize.text as int

templateModel.videos = applicationContext.videoService.searchFeaturedVideos(rows)
