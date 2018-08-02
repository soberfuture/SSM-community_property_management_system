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

import com.property.ssm.po.Carport;
import com.property.ssm.service.CarportService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/carport")
public class CarportController {
	
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
		int count = carportService.findCount();
		List<Carport> list = carportService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/findByPosition.action",method = RequestMethod.POST)
	public void findByPosition(HttpServletResponse response,String position) {
		try {
			List<Carport> list = carportService.findByPosition(position);
			JSONObject result = new JSONObject();
			result.put("total", list.size());
			result.put("rows",JSONArray.fromObject(list));
			SendJson.sendAsJson(response, result);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	@RequestMapping(value="/findByCarportId.action",method = RequestMethod.POST)
	public void findByCarportId(HttpServletResponse response,int id) {
		Carport carport = carportService.selectByPrimaryKey(id);
		SendJson.sendAsJson(response, carport);
	}
	
	
	@RequestMapping(value="/insertCarport.action",method = RequestMethod.POST)//插入车位
	public void insertCarport(HttpServletResponse response,Carport carport) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		try {
			carportService.insert(carport);//插入操作
			map.put("success", true);
			map.put("message", "保存成功！");//反馈成功信息
		} catch (Exception e) {//发生异常
			System.out.println(e.getMessage());//异常输出
			map.put("success", false);
			map.put("message", "出错！");//反馈失败信息
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));//使用json反馈信息到页面
	}
	
	@RequestMapping(value="/updateCarport.action",method = RequestMethod.POST)
	public void updateCarport(HttpServletResponse response,Carport carport,String startd,String stopd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		try {
			if(!startd.equals("")&&!stopd.equals("")&&startd!=null&&stopd!=null) {
				carport.setStartdate(DateFormat.StringToDate(startd));
				carport.setStopdate(DateFormat.StringToDate(stopd));
			}
			carportService.updateByPrimaryKey(carport);
			map.put("success", true);
			map.put("message", "保存成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/delCarportList.action",method = RequestMethod.POST)
	public void delCarportList(HttpServletResponse response,Integer carportId) {
		Map<String, Object> map = new HashMap<>();
		if(carportId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				carportService.deleteByPrimaryKey(carportId);
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
	
	@RequestMapping(value="carportExist.action")
	public void carportExist(HttpServletResponse response,String carportPosition) {
		boolean success = false;
		try {
			Carport carport = carportService.findByCarportPosition(carportPosition);
			if(carport!=null) {
				success = true;
			}else {
				success = false;
			}
			SendJson.sendAsJson(response, success);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	@RequestMapping(value="findByStatus.action")
	public void findByStatus(HttpServletResponse response,String status) {
		List<Carport> list = carportService.findByStatus(status);
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
}
