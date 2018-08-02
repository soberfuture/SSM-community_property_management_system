package com.property.ssm.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.property.ssm.po.Notice;
import com.property.ssm.po.User;
import com.property.ssm.service.NoticeService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping(value="/findByPagination.action",method = RequestMethod.POST)
	public void findByPagination(HttpServletResponse response,Integer page,Integer rows) {
		if(page==null) {
			page=1;
		}
			
		if(rows==null) {
			rows=10;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("index", (page-1)*rows);
		map.put("pagesize", rows);
		int count = noticeService.findCount();
		List<Notice> list = noticeService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/insert.action",method = RequestMethod.POST)//插入公告
	public void insert(HttpServletRequest request,HttpServletResponse response,Notice notice) throws ParseException {
		User admin = (User) request.getSession().getAttribute("adminuser");//获取页面用户信息
		Map<String, Object> map = new HashMap<>();
		if(admin==null) {//没有登录的工作人员
			map.put("success", false);
			map.put("message", "请登录！");//反馈信息
		}else {//已登录
			try {
				notice.setPerson(admin.getUsername());
				notice.setDate(DateFormat.DateToString(new Date()));
				noticeService.insert(notice);//插入操作
				map.put("success", true);
				map.put("message", "保存成功！");//反馈成功信息
			} catch (Exception e) {//发生异常
				System.out.println(e.getMessage());//输出异常
				map.put("success", false);
				map.put("message", "出错！");//反馈失败信息
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));//使用json反馈信息到页面
	}
	
	@RequestMapping(value="/selectByPrimaryKey.action",method = RequestMethod.POST)
	public void selectByPrimaryKey(HttpServletResponse response,Integer nid){
		Notice notice = noticeService.selectByPrimaryKey(nid);
		SendJson.sendAsJson(response,JSONObject.fromObject(notice));
	}
	
	@RequestMapping(value="/update.action",method = RequestMethod.POST)
	public void update(HttpServletRequest request,HttpServletResponse response,Notice notice){
		User admin = (User) request.getSession().getAttribute("adminuser");
		Map<String, Object> map = new HashMap<>();
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			if(notice.getNid()==null) {
				map.put("success", false);
				map.put("message", "请选择编辑行！");
			}else {
				try {
					noticeService.updateByPrimaryKeySelective(notice);
					map.put("success", true);
					map.put("message", "更新成功！");
				} catch (Exception e) {
					System.out.println(e.getMessage());
					map.put("success", false);
					map.put("message", "出错！");
				}
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/delete.action",method = RequestMethod.POST)
	public void delete(HttpServletRequest request,HttpServletResponse response,Integer nid){
		User admin = (User) request.getSession().getAttribute("adminuser");
		Map<String, Object> map = new HashMap<>();
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			if(nid==null) {
				map.put("success", false);
				map.put("message", "请选择删除行！");
			}else {
				try {
					noticeService.deleteByPrimaryKey(nid);
					map.put("success", true);
					map.put("message", "删除成功！");
				} catch (Exception e) {
					System.out.println(e.getMessage());
					map.put("success", false);
					map.put("message", "出错！");
				}
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
}
