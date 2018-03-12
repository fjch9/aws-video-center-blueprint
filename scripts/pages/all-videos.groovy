templateModel.title = contentModel.title
templateModel.q = 'content-type:"/component/video" OR (content-type:"/component/stream" AND endDate_dt:[NOW TO *])'
templateModel.rows = contentModel.videoPageSize.text as int
