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