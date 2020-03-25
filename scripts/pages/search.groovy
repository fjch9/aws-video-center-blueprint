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

import org.springframework.web.util.HtmlUtils

def userQuery = params.q ? HtmlUtils.htmlEscape(params.q) : ""

templateModel.userQuery = userQuery
templateModel.q = templateModel.userQuery ? "(content-type:\"/component/video\" OR (content-type:\"/component/stream\" AND endDate_dt:[NOW TO *])) AND (title_t:($userQuery)^2 OR description_html:($userQuery) OR categories.item.value_smv:($userQuery) OR tags.item.value_smv($userQuery)) " : 'content-type:"/component/video OR (content-type:"/component/stream" AND endDate_dt:[NOW TO *])"'
templateModel.start = params.start ? params.start as int : 0
templateModel.rows = contentModel.maxVideosToDisplay.text as int
