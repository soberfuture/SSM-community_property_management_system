package com.property.ssm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.property.ssm.po.Building;
import com.property.ssm.service.BuildingService;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="building")
public class BuildingController {

	@Autowired
	private BuildingService buildingService;
	
	@RequestMapping(value="findAll.action")
	public void findAll(HttpServletResponse response) {
		List<Building> list = buildingService.findAll();
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
	
	@RequestMapping(value="findAllBuilding.action")
	public void findAllBuilding(HttpServletResponse response) {
		List<Building> list = buildingService.findAll();
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows", JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="insert.action")
	public void insert(HttpServletResponse response,Building building) {
		Map<String, Object> map = new HashMap<>();
		try {
			buildingService.insert(building);
			map.put("success", true);
			map.put("message", "保存成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="update.action")
	public void update(HttpServletResponse response,Building building) {
		Map<String, Object> map = new HashMap<>();
		try {
			buildingService.updateByPrimaryKeySelective(building);
			map.put("success", true);
			map.put("message", "更新成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="delete.action")
	public void delete(HttpServletResponse response,Integer bid) {
		Map<String, Object> map = new HashMap<>();
		if(bid==null) {
			map.put("success", false);
			map.put("message", "请选择删除行！");
		}else {
			try {
				buildingService.deleteByPrimaryKey(bid);
				map.put("success", true);
				map.put("message", "删除成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	@RequestMapping(value="isExist.action")
	public void isExist(HttpServletResponse response,String bName) {
		boolean success = false;
		Building building = buildingService.selectByName(bName);
		if(building!=null) {
			success = true;
		}
		SendJson.sendAsJson(response, success);
	}
}
