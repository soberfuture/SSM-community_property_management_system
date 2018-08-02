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

import com.property.ssm.po.Complaint;
import com.property.ssm.po.FeeRecord;
import com.property.ssm.po.User;
import com.property.ssm.service.ComplaintService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.Pagination;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/complaint")
public class ComplaintController {
	
	@Autowired
	private ComplaintService complaintService;
	
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
		return "owner/complaint";
	}
	
	private Pagination getPaginationByCondition(FeeRecord feeRecord) {
		int count = complaintService.findCountByConditionAndPagination(feeRecord);
		int pagesize=0;
		int rows = feeRecord.getRows();
		if(count%rows==0) {
			pagesize=count/rows;
		}else {
			pagesize=count/rows+1;
		}
		List<Complaint> list = complaintService.findByConditionAndPagination(feeRecord);
		Pagination pagination = new Pagination(feeRecord.getPage(), rows, count, pagesize, "complaint" , list);
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
		int count = complaintService.findCount();
		List<Complaint> list = complaintService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/delComplaintList.action",method = RequestMethod.POST)
	public void delComplaintList(HttpServletResponse response,Integer complaintId) {
		Map<String, Object> map = new HashMap<>();
		if(complaintId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				complaintService.deleteByPrimaryKey(complaintId);
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
	
	@RequestMapping(value="/updateComplaint.action",method = RequestMethod.POST)
	public void updateComplaint(HttpServletResponse response,Complaint complaint,String complaintD,String handled) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(complaintD=="") {
			map.put("success", false);
			map.put("message", "请选择投诉日期");
		}else {
			try {
				complaint.setComplaintDate(DateFormat.StringToDate(complaintD));
				if(handled!="") {
					complaint.setHandledate(DateFormat.StringToDate(handled));
				}
				complaintService.updateByPrimaryKey(complaint);
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
	public void deal(HttpServletRequest request,HttpServletResponse response,Complaint complaint){
		Map<String, Object> map = new HashMap<>();
		User admin = (User) request.getSession().getAttribute("adminuser");
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			try {
				complaint.setComplaintStatus("已处理");
				complaint.setHandledate(new Date());
				complaint.setHandler(admin.getUserId());
				complaintService.updateByPrimaryKeySelective(complaint);
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
	
	@RequestMapping(value="/insertComplaint.action",method = RequestMethod.POST)
	public void insertComplaint(HttpServletResponse response,Complaint complaint) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		try {
			complaint.setComplaintDate(new Date());
			complaint.setComplaintStatus("未处理");
			complaintService.insert(complaint);
			map.put("success", true);
			map.put("message", "保存成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/addComplaint.action",method = RequestMethod.POST)
	public void addComplaint(HttpServletResponse response,Complaint complaint) {
		Map<String, Object> map = new HashMap<>();
		try {
			complaint.setComplaintDate(new Date());
			complaint.setComplaintStatus("未处理");
			complaintService.insert(complaint);
			map.put("success", true);
			map.put("message", "保存成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错！");
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	
	@RequestMapping(value="findByPosition.action")
	public void findByPosition(HttpServletResponse response,String position) {
		try {
			List<Complaint> list= complaintService.findByPosition(position);
			JSONObject result = new JSONObject();
			result.put("total", list.size());
			result.put("rows", JSONArray.fromObject(list));
			SendJson.sendAsJson(response, result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	
	@RequestMapping(value="findByPositionAndComplaintStatus.action")
	public void findByPositionAndComplaintStatus(HttpServletResponse response,FeeRecord feeRecord) {
		try {
			List<Complaint> list= complaintService.findByPositionAndComplaintStatus(feeRecord);
			JSONObject result = new JSONObject();
			result.put("total", list.size());
			result.put("rows", JSONArray.fromObject(list));
			SendJson.sendAsJson(response, result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
}
