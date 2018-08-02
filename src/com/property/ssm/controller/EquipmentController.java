package com.property.ssm.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.property.ssm.po.Equipment;
import com.property.ssm.po.Maintenance;
import com.property.ssm.service.EquipmentService;
import com.property.ssm.service.MaintenanceService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/equipment")
public class EquipmentController {

	@Autowired
	private EquipmentService equipmentService;
	@Autowired
	private MaintenanceService maintenanceService;
	
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
		int count = equipmentService.findCount();
		List<Equipment> list = equipmentService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="insert.action")//插入设备
	public void insert(HttpServletResponse response,Equipment equipment,String costd,String startd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		equipment.setCostdate(DateFormat.StringToDate(costd));
		equipment.setStartdate(DateFormat.StringToDate(startd));
		try {
			equipmentService.insert(equipment);//插入操作
			map.put("success", true);
			map.put("message", "保存成功！");//反馈成功信息
		}catch (Exception e) {//发生异常
			System.out.println(e.getMessage());//输出异常信息
			map.put("success", false);
			map.put("message", "出错！");//反馈失败信息
		}	
		SendJson.sendAsJson(response, JSONObject.fromObject(map));//反馈信息到页面
	}
	
	@RequestMapping(value="update.action")
	public void update(HttpServletResponse response,Equipment equipment,String costd,String startd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(equipment.getEquipmentId()==null) {
			map.put("success", false);
			map.put("message", "未获取选中行信息！");
		}
		equipment.setCostdate(DateFormat.StringToDate(costd));
		equipment.setStartdate(DateFormat.StringToDate(startd));
		try {
			equipmentService.updateByPrimaryKey(equipment);
			map.put("success", true);
			map.put("message", "修改成功！");
		}catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="repair.action")
	public void repair(HttpServletResponse response,Maintenance maintenance) {
		Map<String, Object> map = new HashMap<>();
		try {
			maintenance.setMaintenanceDate(new Date());
			maintenance.setMaintenanceStatus("未修");
			maintenanceService.insert(maintenance);
			Equipment equipment = new Equipment();
			equipment.setEquipmentId(maintenance.getEquipmentId());
			equipment.setStatus("维修");
			equipmentService.updateByPrimaryKeySelective(equipment);
			map.put("success", true);
			map.put("message", "报修成功！");
		}catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="delete.action")
	public void delete(HttpServletResponse response,Integer eid) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(eid==null) {
			map.put("success", false);
			map.put("message", "请选择要删除的行");
		}else {
			try {
				equipmentService.deleteByPrimaryKey(eid);
				map.put("success", true);
				map.put("message", "删除成功！");
			}catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
}
