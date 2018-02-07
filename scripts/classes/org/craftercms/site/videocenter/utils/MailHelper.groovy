package org.craftercms.site.videocenter.utils

import java.util.Properties

import org.craftercms.commons.mail.impl.EmailFactoryImpl
import org.craftercms.engine.exception.HttpStatusCodeException
import org.springframework.mail.javamail.JavaMailSenderImpl

class MailHelper {

    def emailFactory

    def MailHelper(freeMarkerConfig) {
        def javaMailProperties = new Properties()
            javaMailProperties["mail.smtp.auth"] = "false"
            javaMailProperties["mail.smtp.starttls.enable"] = "false"

        def mailSender = new JavaMailSenderImpl()
            mailSender.host = "localhost"
            mailSender.port = 25
            mailSender.protocol = "smtp"
            mailSender.defaultEncoding = "UTF-8"
            mailSender.javaMailProperties = javaMailProperties

        emailFactory = new EmailFactoryImpl()
        emailFactory.mailSender = mailSender
        emailFactory.freeMarkerConfig = freeMarkerConfig
    }

    def sendEmail(from, to, subject, templateName, templateModel) {
        emailFactory.getEmail(from, (String[])[ to ], null, null, subject, templateName, templateModel, true).send()
    }

}