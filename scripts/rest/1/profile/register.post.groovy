import org.craftercms.engine.exception.HttpStatusCodeException

def email = params.email
def username = params.username
def password = params.password

if (!email) {
    throw new HttpStatusCodeException(400, "Bad request: missing email")
} else if (!username) {
    throw new HttpStatusCodeException(400, "Bad request: missing username")
} else if (!password) {
    throw new HttpStatusCodeException(400, "Bad request: missing password")
}

def created = applicationContext.userService.createProfile(email, username, password)
if (created) {
    response.sendRedirect("/login")
} else {
    throw new HttpStatusCodeException(400, "User '${email}' already exists")
}
