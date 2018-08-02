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

import com.property.ssm.po.Equipment;
import com.property.ssm.po.Maintenance;
import com.property.ssm.po.User;
import com.property.ssm.service.EquipmentService;
import com.property.ssm.service.MaintenanceService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/maintenance")
public class MaintenanceController {

	@Autowired
	private MaintenanceService maintenanceService;
	@Autowired
	private EquipmentService equipmentService;
	
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
		int count = maintenanceService.findCount();
		List<Maintenance> list = maintenanceService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="insert.action")
	public void insert(HttpServletResponse response,Maintenance maintenance) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		try {
			maintenance.setMaintenanceDate(new Date());
			maintenance.setMaintenanceStatus("未修");
			maintenanceService.insert(maintenance);
			map.put("success", true);
			map.put("message", "保存成功！");
		}catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="update.action")
	public void update(HttpServletResponse response,Maintenance maintenance,String maintenanceD,String finishedd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(maintenance.getMaintenanceId()==null) {
			map.put("success", false);
			map.put("message", "请选择要修改的行");
		}else {
			if(finishedd!=""&&finishedd!=null) {
				maintenance.setFinisheddate(DateFormat.StringToDate(finishedd));
			}
			try {
				maintenance.setMaintenanceDate(DateFormat.StringToDate(maintenanceD));
				maintenanceService.updateByPrimaryKeySelective(maintenance);
				map.put("success", true);
				map.put("message", "修改成功！");
			}catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="deal.action")
	public void deal(HttpServletRequest request,HttpServletResponse response,Maintenance maintenance) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		User admin = (User) request.getSession().getAttribute("adminuser");
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			try {
				maintenance.setFinisheddate(new Date());
				maintenance.setMaintenanceStatus("已修");
				maintenanceService.updateByPrimaryKeySelective(maintenance);
				Integer id = maintenance.getEquipmentId();
				if(id!=null) {
					Equipment equipment = new Equipment();
					equipment.setEquipmentId(id);
					equipment.setStatus("正常");
					equipmentService.updateByPrimaryKeySelective(equipment);
				}
				map.put("success", true);
				map.put("message", "处理成功！");
			}catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="delete.action")
	public void delete(HttpServletResponse response,Integer mid) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(mid==null) {
			map.put("success", false);
			map.put("message", "请选择要删除的行");
		}else {
			try {
				maintenanceService.deleteByPrimaryKey(mid);
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
