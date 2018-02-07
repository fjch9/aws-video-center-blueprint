import org.craftercms.site.videocenter.utils.MailHelper

import org.craftercms.engine.exception.HttpStatusCodeException
import org.craftercms.profile.api.Profile
import org.craftercms.security.utils.SecurityUtils

def sendVerificationEmail(mailHelper, profile) {
    def token = profileService.createVerificationToken(profile.id.toString())
    def verificationUrl = urlTransformationService.transform("toFullUrl", "/verifyacct?token=${token.id}")
    def model = [:]
        model.profile = profile
        model.verificationUrl = verificationUrl

    mailHelper.sendEmail("noreply@example.com", profile.email, "Verify Account", "/templates/mail/verify-account.ftl", model)
}

def tenantName = tenantsResolver.tenants[0]
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

def profile = profileService.getProfileByUsername(tenantName, email)
if (profile == null) {
    profile = profileService.createProfile(tenantName, username, password, email, false, null, null, null)
    sendVerificationEmail(new MailHelper(siteContext.freeMarkerConfig.configuration), profile)

    response.sendRedirect("/login")
} else {
    throw new HttpStatusCodeException(400, "User '${email}' already exists")
}