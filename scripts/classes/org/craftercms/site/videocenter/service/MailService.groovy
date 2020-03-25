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
