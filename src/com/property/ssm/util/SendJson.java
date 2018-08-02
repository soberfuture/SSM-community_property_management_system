package com.property.ssm.util;

import java.io.IOException;
import javax.servlet.http.HttpServletResponse;

public class SendJson {

	  public static final void sendAsJson(HttpServletResponse response, Object obj){
		    response.setContentType("application/json;charset=UTF-8");
		    if (null != obj)
		      try {
		    	  System.out.println(obj.toString());
		    	  response.getWriter().write(obj.toString());
		      } catch (IOException e) {
		    	  e.printStackTrace();
		      }
	  }

	  public static final void sendAsText(HttpServletResponse response, String str){
		    response.setContentType("text/html;charset=UTF-8");
		    if (null != str)
		      try {
		        response.getWriter().write(str);
		      } catch (IOException e) {
		        e.printStackTrace();
		      }
	  }
}
