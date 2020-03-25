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

@Grapes(
  @Grab(group='commons-fileupload', module='commons-fileupload', version='1.3.3')
)
import org.apache.commons.fileupload.disk.DiskFileItemFactory
import org.apache.commons.fileupload.servlet.ServletFileUpload
import org.apache.commons.io.FilenameUtils
import org.craftercms.engine.exception.HttpStatusCodeException

if(!profile) {
	throw new HttpStatusCodeException(403, "User not logged in")
} else if(!ServletFileUpload.isMultipartContent(request)) {
	throw new HttpStatusCodeException(400, "No file uploaded")
}

def factory = new DiskFileItemFactory()
def upload = new ServletFileUpload(factory)
def files = upload.parseRequest(request)
def avatar = files.find { !it.isFormField() }
def fileName = "avatar.${FilenameUtils.getExtension(avatar.getName())}"
def inputStream = avatar.inputStream

def result = profileService.addProfileAttachment(profile.id.toString(), fileName, inputStream)

response.sendRedirect("/account")