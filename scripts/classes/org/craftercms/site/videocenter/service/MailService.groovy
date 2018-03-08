package org.craftercms.site.videocenter.service

import java.util.Properties

import org.craftercms.commons.mail.impl.EmailFactoryImpl
import org.craftercms.engine.service.context.SiteContext
import org.craftercms.engine.exception.HttpStatusCodeException
import org.springframework.mail.javamail.JavaMailSenderImpl

import groovy.util.logging.Slf4j

@Slf4j
class MailService {
  
  def host
  def port
  def protocol
  def encoding
  
  def auth
  def secure
  
  def emailFactory
  
  def init() {
    def javaMailProperties = new Properties()
    javaMailProperties["mail.smtp.auth"] = auth
    javaMailProperties["mail.smtp.starttls.enable"] = secure
    
    def mailSender = new JavaMailSenderImpl()
    mailSender.host = host
    mailSender.port = port
    mailSender.protocol = protocol
    mailSender.defaultEncoding = encoding
    mailSender.javaMailProperties = javaMailProperties
    
    emailFactory = new EmailFactoryImpl()
    emailFactory.mailSender = mailSender
    emailFactory.freeMarkerConfig = SiteContext.current.freeMarkerConfig
  }
  
  def sendEmail(from, to, subject, templateName, templateModel) {
    emailFactory.getEmail(from, (String[])[ to ], null, null, subject, templateName, templateModel, true).send()
  }
  
}
