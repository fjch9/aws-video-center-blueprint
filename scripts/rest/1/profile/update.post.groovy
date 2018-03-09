import org.craftercms.engine.exception.HttpStatusCodeException

if(!profile) {
	throw new HttpStatusCodeException(403, "User not logged in")
}

def profileId = profile.id.toString()

def updates = [:]
updates.firstName = params.firstName
updates.lastName = params.lastName
updates.displayName = params.displayName
updates.bio = params.bio
updates.phone = params.phone

applicationContext.userService.updateProfile(profileId, updates, params.password)

response.sendRedirect("/account")
