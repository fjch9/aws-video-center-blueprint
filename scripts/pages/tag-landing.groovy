import org.craftercms.engine.exception.HttpStatusCodeException

def tagId = params.id
if (!tagId) {
	throw new HttpStatusCodeException(400, "No param 'id' provided in request")
}

templateModel.title = tagId
templateModel.q = "(content-type:\"/component/video\" OR content-type:\"/component/stream\") AND tags.item.value_smv:\"${tagId}\""
templateModel.rows = contentModel.videoPageSize.text as int
templateModel.breadcrumbs = [
	[url: "/", label: "Home"],
	[url: "/all-videos", label: "Videos"],
	[url: "/tag?id=${tagId}", label: tagId]
]
