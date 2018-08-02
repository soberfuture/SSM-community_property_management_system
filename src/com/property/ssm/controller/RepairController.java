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

import com.property.ssm.po.FeeRecord;
import com.property.ssm.po.Repair;
import com.property.ssm.po.User;
import com.property.ssm.service.RepairService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.Pagination;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/repair")
public class RepairController {

	@Autowired
	private RepairService repairService;
	
	@RequestMapping(value="/sendPagination.action")
	public String sendPagination(HttpServletRequest request,FeeRecord feeRecord) {
		User user = (User) request.getSession().getAttribute("user");
		if(user==null) {
			return "error";
		}else {
			feeRecord.setPosition(user.getUsername());
		}
		if(feeRecord.getPage()==null) {
			feeRecord.setPage(1);
		}
		if(feeRecord.getRows()==null) {
			feeRecord.setRows(10);
		}
		feeRecord.setIndex((feeRecord.getPage()-1)*feeRecord.getRows());
		feeRecord.setPagesize(feeRecord.getRows());
		Pagination pagination = getPaginationByCondition(feeRecord);
		request.getSession().setAttribute("pagination", pagination);
		return "owner/repair";
	}
	
	private Pagination getPaginationByCondition(FeeRecord feeRecord) {
		int count = repairService.findCountByConditionAndPagination(feeRecord);
		int pagesize=0;
		int rows = feeRecord.getRows();
		if(count%rows==0) {
			pagesize=count/rows;
		}else {
			pagesize=count/rows+1;
		}
		List<Repair> list = repairService.findByConditionAndPagination(feeRecord);
		Pagination pagination = new Pagination(feeRecord.getPage(), rows, count, pagesize, "repair" , list);
		String way = feeRecord.getWay();
		if(way!=null&&!way.equals("")) {
			pagination.setWay(way);
		}
		return pagination;
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
		int count = repairService.findCount();
		List<Repair> list = repairService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/updateRepair.action",method = RequestMethod.POST)
	public void updateRepair(HttpServletResponse response,Repair repair,String repairD,String handled) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(repairD=="") {
			map.put("success", false);
			map.put("message", "请选择报修时间");
		}else {
			try {
				repair.setRepairDate(DateFormat.StringToDate(repairD));
				if(handled!="") {
					repair.setHandledate(DateFormat.StringToDate(handled));
				}
				repairService.updateByPrimaryKey(repair);
				map.put("success", true);
				map.put("message", "保存成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/deal.action",method = RequestMethod.POST)
	public void deal(HttpServletRequest request,HttpServletResponse response,Repair repair) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		User admin = (User) request.getSession().getAttribute("adminuser");
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			try {
				repair.setHandledate(new Date());
				repair.setSituation("已处理");
				repairService.updateByPrimaryKeySelective(repair);
				map.put("success", true);
				map.put("message", "保存成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/insertRepair.action",method = RequestMethod.POST)
	public void insertRepair(HttpServletResponse response,Repair repair) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		try {
			repair.setRepairDate(new Date());
			repair.setSituation("未处理");
			repairService.insert(repair);
			map.put("success", true);
			map.put("message", "保存成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/delRepair.action",method = RequestMethod.POST)
	public void delRepair(HttpServletResponse response,Integer repairId) {
		Map<String, Object> map = new HashMap<>();
		if(repairId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				repairService.deleteByPrimaryKey(repairId);
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
	
	@RequestMapping(value="/addRepair.action",method = RequestMethod.POST)
	public void addRepair(HttpServletResponse response,Repair repair) {
		Map<String, Object> map = new HashMap<>();
		if(repair.getPosition()==null||repair.getPosition().equals("")) {
			map.put("success", false);
			map.put("message", "没有获取到物业地址信息！");
		}else {
			try {
				repair.setRepairDate(new Date());
				repair.setSituation("未处理");
				repairService.insert(repair);
				map.put("success", true);
				map.put("message", "保存成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="findByPosition.action")
	public void findByPosition(HttpServletResponse response,String position) {
		try {
			List<Repair> list= repairService.findByPosition(position);
			JSONObject result = new JSONObject();
			result.put("total", list.size());
			result.put("rows", JSONArray.fromObject(list));
			SendJson.sendAsJson(response, result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	@RequestMapping(value="findByPositionAndSituation.action")
	public void findByPositionAndSituation(HttpServletResponse response,FeeRecord feeRecord) {
		System.out.println(feeRecord.getPosition()+feeRecord.getWay());
		try {
			List<Repair> list= repairService.findByPositionAndSituation(feeRecord);
			JSONObject result = new JSONObject();
			result.put("total", list.size());
			result.put("rows", JSONArray.fromObject(list));
			SendJson.sendAsJson(response, result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
