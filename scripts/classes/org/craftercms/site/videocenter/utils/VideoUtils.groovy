package org.craftercms.site.videocenter.utils

import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils

class VideoUtils {

	private static def logger = LoggerFactory.getLogger(VideoUtils.class)

	private VideoUtils() {
	}
	
	static def processItem(profileService, db, videoItem) {
		def video = [:]
		video.id = StringUtils.substringBefore(videoItem["file-name"].text, ".xml")
		video.thumbnail = videoItem.thumbnail.text
		video.title_s = videoItem.title_s.text
		video.date_dt = DateUtils.toShortDisplayDate(videoItem.date_dt)
		video.summary_s = videoItem.summary_s.text
		video.categories = videoItem.queryValues("categories/item/value_smv")
		video.tags = videoItem.queryValues("tags/item/value_smv")

		def views = db.videoViews.findOne(videoId: video.id)
		if (views) {
			video.viewCount = views.count
		} else {
			video.viewCount = 0
		}
		
		video.likeCount = profileService.getProfileCountByQuery("default", "{ \"attributes.likedVideos\":\"${video.id}\"  }")
		video.dislikeCount = profileService.getProfileCountByQuery("default", "{ \"attributes.dislikedVideos\":\"${video.id}\"  }")
		
		return video
	}

	static def resolveVideosFromSearchResults(searchResults, siteItemService, profileService, db) {
		def documents = searchResults.response.documents
		def videos = []

		if (documents) {
			documents.each {doc ->
				def url = doc.localId
				def videoItem = siteItemService.getSiteItem(url)

				if (videoItem) {
					videos << processItem(profileService, db, videoItem)
				}	else {
					logger.warn("Video ${url} not found")
				}
			}
		}

		return videos
	}

}
