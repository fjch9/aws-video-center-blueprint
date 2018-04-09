import org.craftercms.engine.exception.HttpStatusCodeException

def categoryId = params.id
if (!categoryId) {
	throw new HttpStatusCodeException(400, "No param 'id' provided in request")
}

def categoryLabel = contentModel.queryValue("//supportedCategories/item[key='${categoryId}']/value_smv")
if (!categoryLabel) {
	throw new HttpStatusCodeException(404, "Category ${categoryId} not found")
}

templateModel.title = categoryLabel
templateModel.q = "(content-type:\"/component/video\" OR (content-type:\"/component/stream\" AND endDate_dt:[NOW TO *])) AND categories.item.key:\"${categoryId}\""
templateModel.rows = contentModel.videoPageSize.text as int
templateModel.breadcrumbs = [
	[url: "/", label: "Home"],
	[url: "/all-videos", label: "Videos"],
	[url: "/category?id=${categoryId}", label: categoryLabel]
]
