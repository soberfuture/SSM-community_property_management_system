package com.property.ssm.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.property.ssm.po.Electricity;
import com.property.ssm.service.ElectricityService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/electricity")
public class ElectricityController {

	@Autowired
	private ElectricityService electricityService;
	
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
		int count = electricityService.findCount();
		List<Electricity> list = electricityService.findByPagination(map);
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
		List<Electricity> list = electricityService.findByPaginationAndCondition(map);
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows",JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/insertElectricity.action",method = RequestMethod.POST)
	public void insertElectricity(HttpServletResponse response,Electricity electricity,String startd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(startd=="") {
			map.put("success", false);
			map.put("message", "请选择启用时间！");
		}else {
			try {
				electricity.setStartdate(DateFormat.StringToDate(startd));
				electricityService.insert(electricity);
				map.put("success", true);
				map.put("message", "保存成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/updateElectricity.action",method = RequestMethod.POST)
	public void updateElectricity(HttpServletResponse response,Electricity electricity,String startd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(startd=="") {
			map.put("success", false);
			map.put("message", "请选择启用时间！");
		}else {
			try {
				electricity.setStartdate(DateFormat.StringToDate(startd));
				electricityService.updateByPrimaryKey(electricity);
				map.put("success", true);
				map.put("message", "保存成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/delElectricity.action",method = RequestMethod.POST)
	public void delElectricity(HttpServletResponse response,Integer electricityId) {
		Map<String, Object> map = new HashMap<>();
		if(electricityId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				electricityService.deleteByPrimaryKey(electricityId);
				map.put("success", true);
				map.put("message", "删除成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/editprice.action",method = RequestMethod.POST)
	public void editprice(HttpServletResponse response,Double price) {
		Map<String, Object> map = new HashMap<>();
		try {
			electricityService.editprice(price);
			map.put("success", true);
			map.put("message", "修改成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "输入不合法");
		}
	SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
}
