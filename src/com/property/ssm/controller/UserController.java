package com.property.ssm.controller;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.property.ssm.po.House;
import com.property.ssm.po.Owner;
import com.property.ssm.po.User;
import com.property.ssm.service.CarportService;
import com.property.ssm.service.HouseService;
import com.property.ssm.service.OwnerService;
import com.property.ssm.service.UserService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.Pagination;
import com.property.ssm.util.SendEmail;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private HouseService houseService;
	@Autowired
	private OwnerService ownerService;
	@Autowired
	private CarportService carportService;
	
	@RequestMapping(value="life.action")
	public String life(HttpServletRequest request,String bar) {
		User user = (User) request.getSession().getAttribute("user");
		if(user==null) {
			return "jspuser/login";
		}else {
			User detailedUser = userService.getDetailedUser(user.getUsername());
			request.getSession().setAttribute("user", detailedUser);
			request.getSession().setAttribute("carportList", carportService.findByPosition(detailedUser.getUsername()));
		}
		Pagination pagination = new Pagination();
		pagination.setNavigation(bar);
		request.getSession().setAttribute("pagination", pagination);
		return "owner/"+bar;
	}
	
	@RequestMapping(value="navigation.action")
	public String navigation(HttpServletRequest request,String bar) {
		User user = (User) request.getSession().getAttribute("user");
		if(user==null) {
			return "error";
		}
		if(bar==null||bar.equals("")) {
			request.getSession().setAttribute("bar", "userinfo");
			return "owner/userinfo";
		}else {
			request.getSession().setAttribute("bar", bar);
			return "owner/"+bar;
		}
	}
	
	
	@RequestMapping(value="addadmin.action")
	public void addadmin(HttpServletResponse response,HttpServletRequest request) {
		User user = userService.selectByPrimaryKey(1);
		request.getSession().setAttribute("adminuser", user);
	}
	
	@RequestMapping(value="refreshUser.action")
	public void refreshUser(HttpServletResponse response,HttpServletRequest request,String position) {
		User detailed = userService.getDetailedUser(position);
		request.getSession().setAttribute("user", detailed);
		SendJson.sendAsJson(response, JSONObject.fromObject(detailed));
	}
	
	@RequestMapping(value="login.action",method = RequestMethod.POST)//登录模块代码
	public void login(HttpServletRequest request,HttpServletResponse response,String username,String password) {
		Map<String, Object> map = new HashMap<String, Object>();//使用map集合向service接口传递数据
		Map<String, Object> msg = new HashMap<>();//使用map集合向前台页面传递信息
		map.put("username", username);
		map.put("password", password);
		User user = userService.check(map);//查询是否存在该用户
		if(user==null) {//不存在
			msg.put("success", false);
		}else {//存在
			HttpSession session = request.getSession();//使用session携带用户信息到页面
			User user1 = new User();
			user1.setUserId(user.getUserId());
			user1.setLasttime(new Date());
			userService.updateByPrimaryKeySelective(user1);//记录用户这一次登录的时间
			if(user.getType().equals("业主")) {//判断是否为业主
				try {
					User detailedUser = userService.getDetailedUser(username);
					session.setAttribute("user", detailedUser);
					session.setAttribute("carportList", carportService.findByPosition(detailedUser.getUsername()));
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
			}else {//工作人员
				session.setAttribute("adminuser", user);
			}
			msg.put("success", true);
			msg.put("type", user.getType());
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(msg));//使用json将反馈信息返回到前台页面
	}
	
	@RequestMapping(value="exit.action")
	public void exit(HttpServletRequest request,HttpServletResponse response) throws IOException {
		request.getSession().invalidate();
		response.sendRedirect("../jspuser/login.jsp");
	}
	
	@RequestMapping(value="/findByPagination.action",method = RequestMethod.POST)
	public void findByPagination(HttpServletResponse response,Integer page,Integer rows) {
		if(page==null) {
			page=1;
		}
			
		if(rows==null) {
			rows=10;
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("index", (page-1)*rows);
		map.put("pagesize", rows);
		int count = userService.findCount();
		List<User> list = userService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/modificationPsw.action",method = RequestMethod.POST)
	public void modificationPsw(HttpServletRequest request,HttpServletResponse response,String password,String newPassword,String reNewPassword) {
		Map<String, Object> map = new HashMap<>();
		User userExist = (User) request.getSession().getAttribute("user");
		if(userExist==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			User user = userService.getDetailedUser(userExist.getUsername());
			if(password==null||password.equals("")||newPassword==null||newPassword.equals("")
					||reNewPassword==null||reNewPassword.equals("")
					||newPassword.equals(user.getPassword())||!newPassword.equals(reNewPassword)) {
				map.put("success", false);
				map.put("message", "密码不符合条件！");
			}else {
				if(password.equals(user.getPassword())) {
					user.setPassword(newPassword);
					userService.updateByPrimaryKeySelective(user);
					request.getSession().setAttribute("user", user);
					map.put("success", true);
					map.put("message", "密码修改成功！");
				}else {
					map.put("success", false);
					map.put("message", "原密码错误！");
				}
			}
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/revisePsw.action",method = RequestMethod.POST)
	public void revisePsw(HttpServletRequest request,HttpServletResponse response,String npassword,String rnpassword) {
			Map<String, Object> map = new HashMap<>();
			Integer uid = (Integer) request.getSession().getAttribute("uid");
			if(uid!=null) {
				User user = userService.selectByPrimaryKey(uid);
				if(user!=null) {
					if((npassword!=null&&!npassword.equals(""))&&(rnpassword!=null&&!rnpassword.equals(""))&&npassword.endsWith(rnpassword)) {					
						if(!npassword.equals(user.getPassword())) {
							Date now = new Date();
							if(DateFormat.getSecondSubDate(now, user.getRepswTime())>0&&DateFormat.getMinutesSubDate(now, user.getRepswTime())<=10) {
								user.setPassword(rnpassword);
								user.setRepswTime(new Date());
								userService.updateByPrimaryKeySelective(user);
								request.getSession().removeAttribute("uid");
								map.put("success", true);
								map.put("message", "重置成功，请登录！");
							}else {
								map.put("success", false);
								map.put("message", "链接已失效,请重新发送！");
							}
						}else {
							map.put("success", false);
							map.put("message", "新密码不能与原密码相同！");
						}
					}else {
						map.put("success", false);
						map.put("message", "密码不相同或为空！");
					}
				}else {
					map.put("success", false);
					map.put("message", "没有找到用户！");
				}
			}else {
				map.put("success", false);
				map.put("message", "链接已失效,请重新发送！");
			}
			SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/sendEmail.action",method = RequestMethod.POST)
	public void sendEmail(HttpServletRequest request,HttpServletResponse response,String username) {
			Map<String, Object> map = new HashMap<>();
			if(username!=null&&!"".equals(username)) {
				User user = userService.selectByUsername(username);
				if(user!=null) {
					if(user.getType().equals("业主")) {
						House house = houseService.findByPosition(user.getUsername());
						Owner owner = ownerService.selectByPrimaryKey(house.getOwnerId());
						user.setRepswTime(new Date());
						userService.updateByPrimaryKeySelective(user);
						request.getSession().setAttribute("uid", user.getUserId());
						String content = "尊敬的业主：<p>这是一封重置密码的邮件，请谨慎点击，重置密码请<a href='http://127.0.0.1:8080/SSM/jspuser/rePsw.jsp'>点击这里</a></p>";
						try {
							SendEmail.send("重置密码", content, owner.getEmail());
							map.put("success", true);
							map.put("message", "已发送邮件，请在邮箱中查看,有效时间为10分钟！");
						} catch (GeneralSecurityException e) {
							e.printStackTrace();
						}
					}else {
						map.put("success", false);
						map.put("message", "无法修改！");
					}
				}else {
					map.put("success", false);
					map.put("message", "没有该用户！");
				}
			}else {
				map.put("success", false);
				map.put("message", "请输入账号！");
			}
			SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
}
