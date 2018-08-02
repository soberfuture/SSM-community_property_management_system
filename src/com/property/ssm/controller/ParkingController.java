package com.property.ssm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.property.ssm.po.Parking;
import com.property.ssm.service.ParkingService;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="parking")
public class ParkingController {

	@Autowired
	private ParkingService parkingService;
	
	@RequestMapping(value="findAll.action")
	public void findAll(HttpServletResponse response) {
		List<Parking> list = parkingService.findAll();
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
	
	@RequestMapping(value="findAllParking.action")
	public void findAllParking(HttpServletResponse response) {
		List<Parking> list = parkingService.findAll();
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows", JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="insert.action")
	public void insert(HttpServletResponse response,Parking parking) {
		Map<String, Object> map = new HashMap<>();
		try {
			parkingService.insert(parking);
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
	public void update(HttpServletResponse response,Parking parking) {
		Map<String, Object> map = new HashMap<>();
		try {
			parkingService.updateByPrimaryKeySelective(parking);
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
	public void delete(HttpServletResponse response,Integer pid) {
		Map<String, Object> map = new HashMap<>();
		if(pid==null) {
			map.put("success", false);
			map.put("message", "请选择删除行！");
		}else {
			try {
				parkingService.deleteByPrimaryKey(pid);
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
	public void isExist(HttpServletResponse response,String pregion) {
		boolean success = false;
		Parking parking = parkingService.selectByName(pregion);
		if(parking!=null) {
			success = true;
		}
		SendJson.sendAsJson(response, success);
	}
}
