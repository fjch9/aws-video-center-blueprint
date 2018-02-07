import org.apache.commons.io.IOUtils
import org.craftercms.engine.exception.HttpStatusCodeException

if(!profile) {
	throw new HttpStatusCodeException(403, "User not logged in")
}

def avatarInfo = profileService.getProfileAttachmentInformation(profile.id.toString(), "avatar")
if(avatarInfo.id) {
	def avatar = profileService.getProfileAttachment("avatar", profile.id.toString())
	response.setHeader("content-type", avatarInfo.contentType)
	response.setHeader("content-length", avatarInfo.fileSizeBytes as String)
	IOUtils.copy(avatar, response.outputStream)
	IOUtils.closeQuietly(avatar)
	return
}

throw new HttpStatusCodeException(404, "Avatar not found")