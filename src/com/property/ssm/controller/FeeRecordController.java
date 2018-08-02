package com.property.ssm.controller;

import java.util.Collections;
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
import com.property.ssm.po.User;
import com.property.ssm.service.ChargeService;
import com.property.ssm.service.PropertyFeeService;
import com.property.ssm.util.Pagination;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/feeRecord")
public class FeeRecordController {
	@Autowired
	private ChargeService chargeService;
	@Autowired
	private PropertyFeeService propertyFeeService;
	
	@RequestMapping(value="/findFeeRecord.action",method = RequestMethod.POST)
	public void findFeeRecord(HttpServletResponse response,String position,String startdate,String stopdate) {
		Map<String, Object> map = new HashMap<>();
		map.put("position", position);
		if(startdate!=null&&stopdate!=null) {
			map.put("startdate", startdate);
			map.put("stopdate", stopdate);
		}
		try {
			List<FeeRecord> list1 = chargeService.findFeeRecord(map);
			List<FeeRecord> list2 = propertyFeeService.findFeeRecord(map);
			list1.addAll(list2);
			Collections.sort(list1);
			Collections.reverse(list1);
			JSONObject result = new JSONObject();
			result.put("total", list1.size());
			result.put("rows",JSONArray.fromObject(list1));
			SendJson.sendAsJson(response, result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	@RequestMapping(value="/sendPagination.action")
	public String sendPagination(HttpServletRequest request,FeeRecord feeRecord) {
		
		User user = (User) request.getSession().getAttribute("user");
		if(user==null) {
			return "error";
		}else {
			feeRecord.setPosition(user.getUsername());
		}
		try {
			List<FeeRecord> list1 = chargeService.findListByUserAndCondition(feeRecord);
			List<FeeRecord> list2 = propertyFeeService.findListByUserAndCondition(feeRecord);
			list1.addAll(list2);
			Collections.sort(list1);
			Collections.reverse(list1);
			Pagination pagination = new Pagination();
			pagination.setCount(list1.size());
			pagination.setList(list1);
			pagination.setNavigation("feeRecord");
			pagination.setWay("已交");
			if(feeRecord.getStartdate()!=null&&feeRecord.getStopdate()!=null) {
				request.setAttribute("startdate", feeRecord.getStartdate());
				request.setAttribute("stopdate", feeRecord.getStopdate());
			}
			request.getSession().setAttribute("pagination", pagination);
			return "owner/feeRecord";
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return "error";
		}
	}
	
}
