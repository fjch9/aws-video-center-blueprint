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

package org.craftercms.site.videocenter.service

import org.apache.commons.lang3.StringUtils

import org.craftercms.site.videocenter.utils.DateUtils

import groovy.util.logging.Slf4j

@Slf4j
class VideoService {
  
  def searchService
  def profileService
  def siteItemService
  def tenantsResolver
  
  def mongoClient
  def dbName
  def db
  
  def init() {
    db = mongoClient.getDB(dbName)
  }
  
  def updateVideoViewCount(videoId) {
    // Increment view count
    db.videoViews.update([videoId: videoId], [$inc: [count: 1]], true)
    // Get current view count
    def views = db.videoViews.findOne(videoId: videoId)
    return views
  }
  
  def getVideoSocialCounts(videoId) {
    def tenantName = tenantsResolver.tenants[0]
    return [
    liked: profileService.getProfileCountByQuery(tenantName, "{ \"attributes.likedVideos\":\"$videoId\"  }"),
    disliked: profileService.getProfileCountByQuery(tenantName, "{ \"attributes.dislikedVideos\":\"$videoId\"  }")
    ]
  }
  
  def getMostViewedVideos(limit) {
    def videos = []
    
    def mostViews = db.videoViews.find().limit(limit).sort(count: -1)
    if (mostViews) {
      mostViews.each { singleVideoViews ->
        def videoId = singleVideoViews.videoId
        def videoItem = resolveVideoFromId(videoId)
        
        if (!videoItem) {
          log.warn("Video ID ${videoId} not found")
        }	else if (videoItem.type == "video") {
          videos << videoItem
        }
      }
    }
      
    return videos
  }
    
  def buildSolrQuery(q, rows, sort = "score desc, date_dt desc") {
    def fieldsToReturn = [ "localId" ] as String[]
    
    def query = searchService.createQuery()
    query.query = q
    query.rows = rows
    query.fieldsToReturn = fieldsToReturn
    query.addParam("sort", sort)
    
    return query
  }
    
  def searchVideos(q, start, rows, sort) {
    def fieldsToReturn = [ "localId" ] as String[]
    def query = searchService.createQuery()
    query.query = q
    query.start = start
    query.rows = rows
    query.fieldsToReturn = fieldsToReturn
    
    if (sort) {
      query.addParam("sort", sort)
    }
    
    def results = searchService.search(query)
    
    return [
      hasMore: (start + rows) < results.response.numFound,
      total: results.response.numFound,
      items: resolveVideosFromSearchResults(results)
    ]
  }
    
  def searchRecentVideos(rows) {
    def q = 'content-type:"/component/video"'
    def query = buildSolrQuery(q, rows)
    
    def results = searchService.search(query)
    
    return resolveVideosFromSearchResults(results)
  }
    
  def searchRelatedVideos(video, rows) {
    def categories = video.queryValues("//categories/item/key")
    def categoriesStr = StringUtils.join(categories, " OR ")
    def q = "content-type:\"/component/video\" AND categories.item.key:(${categoriesStr}) AND -localId:\"${video.storeUrl}\""
    def query = buildSolrQuery(q, rows)
    
    def results = searchService.search(query)
    
    return resolveVideosFromSearchResults(results)
  }

  def searchStreams(rows) {
    def query = buildSolrQuery("content-type:\"/component/stream\" AND endDate_dt:[NOW TO *]",
                                rows, "startDate_dt asc")
    
    def results = searchService.search(query)
    
    return resolveVideosFromSearchResults(results)
  }
    
  def resolveVideosFromSearchResults(searchResults) {
    def documents = searchResults.response.documents
    def videos = []
    
    if (documents) {
      documents.each { doc ->
        def url = doc.localId
        def videoItem = siteItemService.getSiteItem(url)
        
        if (videoItem) {
          videos << processItem(videoItem)
        }	else {
          log.warn("Video Item ${url} not found")
        }
      }
    }
      
    return videos
  }
  
  def resolveVideosFromIds(ids) {
    ids.findResults { videoId ->
      return resolveVideoFromId(videoId)
    }
  }

  def resolveVideoFromId(id) {
    def item = siteItemService.getSiteItem("/site/videos/${id}.xml")
    if(!item) {
      item = siteItemService.getSiteItem("/site/streams/${id}.xml")
      if(item && getStreamStatus(item) == 'finished') {
        item = null
      }
    }
    return item ? processItem(item) : null
  }
  
  def processItem(videoItem) {
    def video = [:]
    video.id = StringUtils.substringBefore(videoItem["file-name"].text, ".xml")
    video.thumbnail = videoItem.thumbnail.text
    video.title_s = videoItem.title_s
    video.date_dt = DateUtils.toShortDisplayDate(videoItem.date_dt)
    video.summary_s = videoItem.summary_s
    video.categories = videoItem.queryValues("categories/item/value_smv")
    video.tags = videoItem.queryValues("tags/item/value_smv")
    video.type = videoItem["content-type"].text.equals("/component/video") ? "video" : "stream"
    if(video.type == "stream") {
      video.startDate_dt = DateUtils.toIsoString(videoItem.startDate_dt)
      video.endDate_dt = DateUtils.toIsoString(videoItem.endDate_dt)
      def now = new Date()
      video.liveNow = videoItem.startDate_dt < now && now < videoItem.endDate_dt
    }
    
    def views = db.videoViews.findOne(videoId: video.id)
    if (views) {
      video.viewCount = views.count
    } else {
      video.viewCount = 0
    }
    def tenantName = tenantsResolver.tenants[0]
    video.likeCount = profileService.getProfileCountByQuery(tenantName, "{ \"attributes.likedVideos\":\"${video.id}\"  }")
    video.dislikeCount = profileService.getProfileCountByQuery(tenantName, "{ \"attributes.dislikedVideos\":\"${video.id}\"  }")
    
    return video
  }
  
  def getStreamStatus(video) {
    def now = new Date()
    if(video.startDate_dt > now) {
      return "waiting"
    } else if(video.endDate_dt < now) {
      return "finished"
    } else {
      return "live"
    }
  }
}
