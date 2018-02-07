import org.craftercms.engine.exception.HttpStatusCodeException

def token = params.token
if (token) {
    profileService.verifyProfile(token)

    return "redirect:/"
} else {
    throw new HttpStatusCodeException(400, "Bad request: token param is missing")
}