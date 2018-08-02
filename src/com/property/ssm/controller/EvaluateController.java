package com.property.ssm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.property.ssm.po.Complaint;
import com.property.ssm.po.Evaluate;
import com.property.ssm.po.Repair;
import com.property.ssm.service.ComplaintService;
import com.property.ssm.service.EvaluateService;
import com.property.ssm.service.RepairService;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="evaluate")
public class EvaluateController {
	@Autowired
	private EvaluateService evaluateService;
	@Autowired
	private ComplaintService complaintService;
	@Autowired
	private RepairService repairService;
	
	@RequestMapping(value="insert.action")
	public void insert(HttpServletResponse response,Evaluate evaluate) {
		Map<String, Object> map = new HashMap<>();
		try {
			evaluate.seteDate(new Date());
			evaluateService.insert(evaluate);
			if(evaluate.geteType().equals("complaint")) {
				Complaint record = new Complaint();
				record.setComplaintId(evaluate.getTargetId());
				record.setComplaintStatus("已评价");
				complaintService.updateByPrimaryKeySelective(record);
			}
			if(evaluate.geteType().equals("repair")) {
				Repair repair = new Repair();
				repair.setRepairId(evaluate.getTargetId());
				repair.setSituation("已评价");
				repairService.updateByPrimaryKeySelective(repair);
			}
			map.put("success", true);
			map.put("message", "评价成功");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错");
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}

}
