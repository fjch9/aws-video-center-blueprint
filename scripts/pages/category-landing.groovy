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
