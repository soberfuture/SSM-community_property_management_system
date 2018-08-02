package com.property.ssm.util;

import java.security.GeneralSecurityException;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.mail.util.MailSSLSocketFactory;

public class SendEmail {
	public static void send(String title,String content,String to) throws GeneralSecurityException {
	        // 发件人电子邮箱
	        String from = "1510197456@qq.com";
	        
	        String code = "cerepqnxinvxbagd";

	        // 指定发送邮件的主机为 smtp.qq.com
	        String host = "smtp.qq.com";  //QQ 邮件服务器

	        // 获取系统属性
	        Properties properties = System.getProperties();

	        // 设置邮件服务器
	        properties.setProperty("mail.smtp.host", host);

	        properties.put("mail.smtp.auth", "true");
	        MailSSLSocketFactory sf = new MailSSLSocketFactory();
	        sf.setTrustAllHosts(true);
	        properties.put("mail.smtp.ssl.enable", "true");
	        properties.put("mail.smtp.ssl.socketFactory", sf);
	        // 获取默认session对象
	        Session session = Session.getDefaultInstance(properties,new Authenticator(){
	            public PasswordAuthentication getPasswordAuthentication(){
	                return new PasswordAuthentication(from, code); //发件人邮件用户名、密码
	            }
	        });

	        try{
	            // 创建默认的 MimeMessage 对象
	            MimeMessage message = new MimeMessage(session);

	            // Set From: 头部头字段
	            message.setFrom(new InternetAddress(from));

	            // Set To: 头部头字段
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	            // Set Subject: 头部头字段
	            message.setSubject(title);
	            
	            // 设置消息体
	            message.setContent(content, "text/html;charset=utf-8");

	            // 发送消息
	            Transport.send(message);
	            System.out.println("邮件发送成功！");
	        }catch (MessagingException mex) {
	            mex.printStackTrace();
	        }
	    }
}
