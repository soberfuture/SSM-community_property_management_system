package com.property.ssm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.property.ssm.po.Charge;
import com.property.ssm.po.Complaint;
import com.property.ssm.po.Evaluate;
import com.property.ssm.po.Maintenance;
import com.property.ssm.po.PropertyFee;
import com.property.ssm.po.Repair;
import com.property.ssm.po.StaMaintenance;
import com.property.ssm.po.StatistcsFee;
import com.property.ssm.po.Statistics;
import com.property.ssm.service.ChargeService;
import com.property.ssm.service.ComplaintService;
import com.property.ssm.service.EvaluateService;
import com.property.ssm.service.HouseService;
import com.property.ssm.service.MaintenanceService;
import com.property.ssm.service.PropertyFeeService;
import com.property.ssm.service.RepairService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.DeFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="statistics")
public class StatisticsController {

	@Autowired
	private ComplaintService complaintService;
	@Autowired
	private EvaluateService evaluateService;
	@Autowired
	private RepairService repairService;
	@Autowired
	private ChargeService chargeService;
	@Autowired
	private PropertyFeeService propertyFeeService;
	@Autowired
	private HouseService houseService;
	@Autowired
	private MaintenanceService maintenanceService;
	
	@RequestMapping(value="stacomplaint.action")
	public void stacomplaint(HttpServletResponse response,String year) {
		List<Statistics> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		if(year==null) {
			year="2017";
		}
		map.put("year", year);
		for(int i=1;i<=12;i++) {
			map.put("month", i);
			map.put("status", "未处理");
			List<Complaint> list1 = complaintService.findByStatus(map);
			map.put("status", "已处理");
			List<Complaint> list2 = complaintService.findByStatus(map);
			map.put("status", "已评价");
			List<Complaint> list3 = complaintService.findByStatus(map);
			if(list1.size()==0&&list2.size()==0&&list3.size()==0) {
				continue;
			}else {
				int count = list1.size()+list2.size()+list3.size();
				int socount = list2.size()+list3.size();
				Double score = null;
				Double time = null;
				map.put("eType", "complaint");
				List<Evaluate> list4 = evaluateService.findByETypeAndYearAndMonth(map);
				if(list4!=null && list4.size()!=0) {
					int day1=0;
					int day2=0;
					score = getScore(list4);
					if(list2!=null&&list2.size()!=0) {
						day1 = getDay(list2);
					}
					if(list3!=null&&list3.size()!=0) {
						day2 = getDay(list3);
					}
					time = (day1+day2)*1.0/socount;
				}		
				Statistics statistics = new Statistics();
				statistics.setCount(count);
				statistics.setMonth(i+"月");
				statistics.setScore(DeFormat.DoubleFormat(score));
				statistics.setCtime(DeFormat.DoubleFormat(time));
				statistics.setProportion(DeFormat.DoubleFormat(socount*1.0/count));
				statistics.setSolved(socount);
				statistics.setUnsolved(list1.size());
				if(statistics.getCount()!=0) {
					list.add(statistics);
				}
			}
		}
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows", JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}

	@RequestMapping(value="starepair.action")
	public void starepair(HttpServletResponse response,String year) {
		List<Statistics> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		if(year==null) {
			year="2017";
		}
		map.put("year", year);
		for(int i=1;i<=12;i++) {
			map.put("month", i);
			map.put("status", "未处理");
			List<Repair> list1 = repairService.findByStatus(map);
			map.put("status", "已处理");
			List<Repair> list2 = repairService.findByStatus(map);
			map.put("status", "已评价");
			List<Repair> list3 = repairService.findByStatus(map);
			if(list1.size()==0&&list2.size()==0&&list3.size()==0) {
				continue;
			}else {
				int count = list1.size()+list2.size()+list3.size();
				int socount = list2.size()+list3.size();
				Double score = null;
				Double time = null;
				map.put("eType", "repair");
				List<Evaluate> list4 = evaluateService.findByETypeAndYearAndMonth(map);
				if(list4!=null&&list4.size()!=0) {
					int day1=0;
					int day2=0;
					score = getScore(list4);
					if(list2!=null&&list2.size()!=0) {
						day1 = getDayRepair(list2);
					}
					if(list3!=null&&list3.size()!=0) {
						day2 = getDayRepair(list3);
					}
					time = (day1+day2)*1.0/socount;
				}		
				Statistics statistics = new Statistics();
				statistics.setCount(count);
				statistics.setMonth(i+"月");
				statistics.setScore(DeFormat.DoubleFormat(score));
				statistics.setCtime(DeFormat.DoubleFormat(time));
				statistics.setProportion(DeFormat.DoubleFormat(socount*1.0/count));
				statistics.setSolved(socount);
				statistics.setUnsolved(list1.size());
				if(statistics.getCount()!=0) {
					list.add(statistics);
				}
			}
		}
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows", JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="stafee.action")
	public void stafee(HttpServletResponse response,String year) {
		List<StatistcsFee> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		if(year==null) {
			year="2017";
		}
		map.put("year", year);
		for(int i=1;i<=12;i++) {
			map.put("month", i);
			List<Charge> list1 = chargeService.findByYearAndMonth(map);
			List<PropertyFee> list2 = propertyFeeService.findByYearAndMonth(map);
			if(list1.size()==0&&list2.size()==0) {
				continue;
			}else {
				Map<String, Object> cmap = ChargeMap(list1);
				Map<String, Object> pmap = PropertyFeeMap(list2);
				StatistcsFee statistcsFee = new StatistcsFee();
				statistcsFee.setMonth(i+"月");
				statistcsFee.setWmoney((Double) cmap.get("wmoney"));
				statistcsFee.setWater((Double) cmap.get("wcount"));
				statistcsFee.setPmoney((Double) pmap.get("pmoney"));
				statistcsFee.setGmoney((Double) cmap.get("gmoney"));
				statistcsFee.setGas((Double) cmap.get("gcount"));
				statistcsFee.setEmoney((Double) cmap.get("emoney"));
				statistcsFee.setElectricity((Double) cmap.get("ecount"));
				statistcsFee.setAvere((Double) cmap.get("avere"));
				statistcsFee.setAverg((Double) cmap.get("averg"));
				statistcsFee.setAverp((Double) pmap.get("averp"));
				statistcsFee.setAverw((Double) cmap.get("averw"));
				if(list1!=null||list2!=null) {
					list.add(statistcsFee);
				}
			}
		}
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows", JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="stamaintenance.action")
	public void stamaintenance(HttpServletResponse response,String year) {
		Map<String, Object> map = new HashMap<>();
		List<StaMaintenance> list = new ArrayList<>();
		if(year==null) {
			year="2017";
		}
		map.put("year", year);
		for(int i=1;i<=12;i++) {
			map.put("month", i);
			List<Maintenance> mlist = maintenanceService.findByYearAndMonth(map);
			if(mlist.size()!=0) {
				StaMaintenance staMaintenance = stamt(mlist);
				staMaintenance.setMonth(i+"月");
				list.add(staMaintenance);
			}
		}
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows", JSONArray.fromObject(list));
		SendJson.sendAsJson(response, result);
	}
	
	private StaMaintenance stamt(List<Maintenance> list) {
		StaMaintenance sta = new StaMaintenance();
		Double countmoney=0.0;
		int mcount = 0;
		int day = 0;
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getMaintenanceStatus().equals("已修")) {
				countmoney+=list.get(i).getMaintenanceFee();
				mcount++;
				day+=DateFormat.getDaySubDate(list.get(i).getFinisheddate(), list.get(i).getMaintenanceDate());
			}
		}
		sta.setCount(list.size());
		try {
			sta.setCosttime(DeFormat.DoubleFormat(day*1.0/mcount));//mcount可能为0
			sta.setAvercm(countmoney/mcount);
		} catch (Exception e) {
			sta.setCosttime(0.0);
			sta.setAvercm(0.0);
		}
		sta.setCostmoney(countmoney);
		return sta;
	}

	private Map<String, Object> PropertyFeeMap(List<PropertyFee> list) {
		Map<String, Object> map  = new HashMap<>();
		Double pmoney = 0.0;
		int housecount = houseService.findCount();
		for(int i=0;i<list.size();i++) {
			pmoney+=list.get(i).getTotal();
		}
		map.put("pmoney", pmoney);
		map.put("averp", DeFormat.DoubleFormat(pmoney/housecount));
		return map;
	}

	private Map<String, Object> ChargeMap(List<Charge> list) {
		Map<String, Object> map = new HashMap<>();
		Double wcount=0.0;
		Double ecount=0.0;
		Double gcount=0.0;
		Double wmoney=0.0;
		Double emoney=0.0;
		Double gmoney=0.0;
		int housecount = houseService.findCount();
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getProject().equals("水费")) {
				wcount+=list.get(i).getUsed();
				wmoney+=list.get(i).getTotal();
			}
			if(list.get(i).getProject().equals("电费")) {
				ecount+=list.get(i).getUsed();
				emoney+=list.get(i).getTotal();
			}
			if(list.get(i).getProject().equals("天然气费")) {
				gcount+=list.get(i).getUsed();
				gmoney+=list.get(i).getTotal();
			}
		}
		map.put("wcount", wcount);
		map.put("ecount", ecount);
		map.put("gcount", gcount);
		map.put("wmoney", wmoney);
		map.put("emoney", emoney);
		map.put("gmoney", gmoney);
		map.put("averw", DeFormat.DoubleFormat(wcount/housecount));
		map.put("avere", DeFormat.DoubleFormat(ecount/housecount));
		map.put("averg", DeFormat.DoubleFormat(gcount/housecount));
		return map;
	}

	private int getDayRepair(List<Repair> list) {
		int day = 0;
		for(int i=0;i<list.size();i++) {
			day+=DateFormat.getDaySubDate(list.get(i).getHandledate(), list.get(i).getRepairDate());
		}
		return day;
	}

	private int getDay(List<Complaint> list) {
		int day = 0;
		for(int i=0;i<list.size();i++) {
			day+=DateFormat.getDaySubDate(list.get(i).getHandledate(), list.get(i).getComplaintDate());
		}
		return day;
	}

	private Double getScore(List<Evaluate> list) {
		int score=0;
		for(int i=0;i<list.size();i++) {
			score+=list.get(i).getStar();
		}
		return score*1.0/list.size();
	}
	
}
