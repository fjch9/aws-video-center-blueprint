import org.springframework.web.util.HtmlUtils

def userQuery = params.q ? HtmlUtils.htmlEscape(params.q) : ""

templateModel.userQuery = userQuery
templateModel.q = templateModel.userQuery ? "content-type:\"/component/video\" AND (title_t:($userQuery)^2 OR description_html:($userQuery) OR categories.item.value_smv:($userQuery) OR tags.item.value_smv($userQuery)) " : 'content-type:"/component/video"'
templateModel.start = params.start ? params.start as int : 0
templateModel.rows = contentModel.maxVideosToDisplay.text as int
