/* 
 *  MIT License
 *  
 *  Copyright (C) 2018-2020 Crafter Software Corporation. All Rights Reserved.
 *  
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *  
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import org.craftercms.engine.exception.HttpStatusCodeException

def videoService = applicationContext.videoService
def userService = applicationContext.userService

// Get actual video
def videoId = params.id
def video = null

if (videoId) {
    video = siteItemService.getSiteItem("/site/streams/${videoId}.xml")
    if (video) {
      templateModel.video = video
    } else {
    	throw new HttpStatusCodeException(404, "Video ${videoId} not found")
    }
} else {
	throw new HttpStatusCodeException(400, "No param 'id' provided in request")
}

def streamStatus = videoService.getStreamStatus(video)
templateModel.streamStatus = streamStatus

def origin = siteItemService.getSiteItem(video.origin.item.key.text)
templateModel.videoSource = origin.url.text
templateModel.videoType = origin.encoding.text

def getEpochSeconds(Date date) {
  return date.time / 1000 as int
}
def hasPassed(int timestamp, origin) {
  return getEpochSeconds(new Date()) > timestamp + (origin.segmentSize.text as int) + (origin.playlistDuration.text as int)
}
def startTimestamp = getEpochSeconds(video.startDate_dt)
templateModel.startTime = startTimestamp
def endTimestamp = getEpochSeconds(video.endDate_dt)
if ((streamStatus == "live" && hasPassed(startTimestamp, origin)) || streamStatus == "finished") {
  templateModel.videoSource += "?start=" + (startTimestamp as String)
}
if (streamStatus == "finished" && hasPassed(endTimestamp, origin)) {
  templateModel.videoSource += "&end=" + (endTimestamp as String)
}

def views = videoService.updateVideoViewCount(videoId)
if (views) {
	templateModel.viewCount = views.count
}

def socialCounts = videoService.getVideoSocialCounts(videoId)
templateModel.likeCount = socialCounts.liked
templateModel.dislikeCount = socialCounts.disliked

// Get related videos
def rows = contentModel.maxRelatedVideosToDisplay.text as int
templateModel.relatedVideos = videoService.searchRelatedVideos(video, rows)

templateModel.breadcrumbs = [
	[url: "/", label: "Home"],
	[url: "/all-videos", label: "Videos"],
	[url: "/live?id=${videoId}", label: video.title_s]
]

if(profile) {
  templateModel.isFavorite = userService.videoIsInList(profile, videoId, "favoriteVideos")
  templateModel.isLiked = userService.videoIsInList(profile, videoId, "likedVideos")
  templateModel.isDisliked = userService.videoIsInList(profile, videoId, "dislikedVideos")
}
