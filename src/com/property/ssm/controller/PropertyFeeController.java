package com.property.ssm.controller;

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

import com.property.ssm.po.Carport;
import com.property.ssm.po.PropertyFee;
import com.property.ssm.po.User;
import com.property.ssm.service.CarportService;
import com.property.ssm.service.PropertyFeeService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/propertyFee")
public class PropertyFeeController {

	@Autowired
	private PropertyFeeService propertyFeeService;
	@Autowired
	private CarportService carportService;
	
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
		int count = propertyFeeService.findCount();
		List<PropertyFee> list = propertyFeeService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/doSearch.action",method = RequestMethod.POST)
	public void doSearch(HttpServletResponse response,String name,String value,Integer page,Integer rows) {
		if(page==null) {
			page=1;
		}
		if(rows==null) {
			rows=10;
		}
		Map<String, Object> map = new HashMap<>();
		map.put("index", (page-1)*rows);
		map.put("pagesize", rows);
		map.put("name", name);
		map.put("value", value);
		List<PropertyFee> list = propertyFeeService.findByPaginationAndCondition(map);
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/findByPositionAndFeeState.action",method = RequestMethod.POST)
	public void findByPositionAndFeeState(HttpServletResponse response,String position) {
		int count = propertyFeeService.findCountByPositionAndFeeState(position);
		List<PropertyFee> list = propertyFeeService.findByPositionAndFeeState(position);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows", JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/payment.action",method = RequestMethod.POST)
	public void payment(HttpServletRequest request,HttpServletResponse response,String idString,String role) {
		Map<String, Object> map = new HashMap<>();
		User admin = (User) request.getSession().getAttribute("adminuser");
		User user = (User) request.getSession().getAttribute("user");
		if(user==null&&admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			String[] idlist = idString.split(" ");
			for(int i=0;i<idlist.length;i++) {
				PropertyFee propertyFee = new PropertyFee();
				propertyFee.setFeeId(Integer.parseInt(idlist[i]));
				if(role.equals("user")) {
					propertyFee.setWay("在线");
					propertyFee.setOwnerId(user.getUserId());
				}
				if(role.equals("admin")){
					propertyFee.setWay("现金");
					propertyFee.setTransactor(admin.getUserId());
				}
				propertyFee.setDeliverdate(new Date());
				try {
					propertyFeeService.updateByPrimaryKeySelective(propertyFee);
					map.put("success", true);
					map.put("message", "缴费成功！");
				} catch (Exception e) {
					System.out.println(e.getMessage());
					map.put("success", false);
					map.put("message", "出错！");
				}
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	/*录入费用*/
	@RequestMapping(value="inputFee.action")
	public void inputFee(HttpServletResponse response,PropertyFee propertyFee) {
		Map<String, Object> map = new HashMap<>();
		try {
			propertyFee.setInputdate(new Date());
			propertyFee.setWay("未交");
			propertyFeeService.insertSelective(propertyFee);
			map.put("success", true);
			map.put("message", "录入成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	/*录入车位缴费信息*/
	@RequestMapping(value="addCarport.action")
	public void addCarport(HttpServletRequest request,HttpServletResponse response,PropertyFee propertyFee,Carport carport,String start,String stop) {
		Map<String, Object> map = new HashMap<>();
		User admin = getStaff(request);
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			try {
				propertyFee.setProject("车位费");
				Date date = new Date();
				propertyFee.setInputdate(date);
				propertyFee.setDeliverdate(date);
				propertyFee.setWay("现金");
				propertyFee.setTransactor(admin.getUserId());
				propertyFeeService.insertSelective(propertyFee);
				carport.setCfee(propertyFee.getFeeId());
				carport.setCarportFee(propertyFee.getTotal());
				carport.setStatus("已使用");
				carport.setStartdate(DateFormat.StringToDate(start));
				carport.setStopdate(DateFormat.StringToDate(stop));
				carportService.buyCarport(carport);
				map.put("success", true);
				map.put("message", "购买成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	private User getStaff(HttpServletRequest request) {
		User admin = (User) request.getSession().getAttribute("adminuser");
		return admin;
	}

	/*删除费用*/
	@RequestMapping(value="delFee.action")
	public void delFee(HttpServletResponse response,Integer feeId) {
		Map<String, Object> map = new HashMap<>();
		try {
			propertyFeeService.deleteByPrimaryKey(feeId);
			map.put("success", true);
			map.put("message", "删除成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
}
