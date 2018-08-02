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

import com.property.ssm.po.Water;
import com.property.ssm.service.WaterService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/water")
public class WaterController {

	@Autowired
	private WaterService waterService;
	
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
		int count = waterService.findCount();
		List<Water> list = waterService.findByPagination(map);
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
		List<Water> list = waterService.findByPaginationAndCondition(map);
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows",JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/insertWater.action",method = RequestMethod.POST)
	public void insertWater(HttpServletResponse response,Water water,String startd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(startd=="") {
			map.put("success", false);
			map.put("message", "请选择启用时间！");
		}else {
			try {
				water.setStartdate(DateFormat.StringToDate(startd));
				waterService.insert(water);
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
	
	@RequestMapping(value="/updateWater.action",method = RequestMethod.POST)
	public void updateWater(HttpServletResponse response,Water water,String startd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(startd=="") {
			map.put("success", false);
			map.put("message", "请选择启用时间！");
		}else {
			try {
				water.setStartdate(DateFormat.StringToDate(startd));
				waterService.updateByPrimaryKey(water);
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
	
	@RequestMapping(value="/delWater.action",method = RequestMethod.POST)
	public void delWater(HttpServletResponse response,Integer waterId) {
		Map<String, Object> map = new HashMap<>();
		if(waterId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				waterService.deleteByPrimaryKey(waterId);
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
			waterService.editprice(price);
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
