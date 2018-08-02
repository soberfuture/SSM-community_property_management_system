package com.property.ssm.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
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

import com.property.ssm.po.Charge;
import com.property.ssm.po.Electricity;
import com.property.ssm.po.Gas;
import com.property.ssm.po.PropertyFee;
import com.property.ssm.po.User;
import com.property.ssm.po.Water;
import com.property.ssm.service.ChargeService;
import com.property.ssm.service.ElectricityService;
import com.property.ssm.service.GasService;
import com.property.ssm.service.OwnerService;
import com.property.ssm.service.PropertyFeeService;
import com.property.ssm.service.UserService;
import com.property.ssm.service.WaterService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.Pagination;
import com.property.ssm.util.SendJson;
import com.property.ssm.util.StringToInt;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/charge")
public class ChargeController {
	@Autowired
	private ChargeService chargeService;
	@Autowired
	private WaterService waterService;
	@Autowired
	private GasService gasService;
	@Autowired
	private ElectricityService electricityService;
	@Autowired
	private PropertyFeeService propertyFeeService;
	@Autowired
	private OwnerService ownerService;
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/findListByUser.action")
	public String findListByUser(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		if(user==null) {
			return "error";
		}else {
			double total = 0;
			List<Charge> chargelist = chargeService.findByPositionAndFeeState(user.getUsername());
			List<PropertyFee> propertyFeelist = propertyFeeService.findByPositionAndFeeState(user.getUsername());
			for(Charge charge:chargelist) {
				total+=charge.getTotal();
			}
			for(PropertyFee propertyFee:propertyFeelist) {
				total+=propertyFee.getTotal();
			}
			request.getSession().setAttribute("totalPay", total);
			request.getSession().setAttribute("chargelist", chargelist);
			request.getSession().setAttribute("propertyFeelist", propertyFeelist);
			Pagination pagination = new Pagination();
			pagination.setNavigation("charge");
			request.getSession().setAttribute("pagination", pagination);
			return "owner/charge";
		}
		
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
		int count = chargeService.findCount(); 
		List<Charge> list = chargeService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/delChargeList.action",method = RequestMethod.POST)
	public void delChargeList(HttpServletResponse response,Integer chargeId) {
		Map<String, Object> map = new HashMap<>();
		if(chargeId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				chargeService.deleteByPrimaryKey(chargeId);
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
	
	@RequestMapping(value="/insertCharge.action",method = RequestMethod.POST)
	public void insertCharge(HttpServletRequest request,HttpServletResponse response,Charge charge) throws IOException {
		Map<String, Object> map = new HashMap<>();
		User admin = (User) request.getSession().getAttribute("adminuser");
		if(admin==null) {
			System.out.println("未登录");
			response.sendRedirect("../jspuser/login.jsp");
		}else {
			try {
				String position = charge.getPosition();
				if(charge.getProject().equals("电费")) {
					Electricity electricity = electricityService.findByPosition(position);
					charge.setPrice(electricity.getPrice());
				}
				if(charge.getProject().equals("水费")) {
					Water water = waterService.findByPosition(position);
					charge.setPrice(water.getPrice());
				}
				if(charge.getProject().equals("天然气费")) {
					Gas gas = gasService.findByPosition(position);
					charge.setPrice(gas.getPrice());
				}
				charge.setInperson(admin.getUserId());
				charge.setTotal(charge.getPrice()*charge.getUsed());
				charge.setIndate(new Date());
				charge.setWay("未交");
				chargeService.insert(charge);
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
	
	@RequestMapping(value="/updateCharge.action",method = RequestMethod.POST)
	public void updateCharge(HttpServletResponse response,Charge charge,String ind,String payd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(ind=="") {
			map.put("success", false);
			map.put("message", "请选择录入时间");
		}else {
			try {
				charge.setIndate(DateFormat.StringToDate(ind));
				if(payd!="") {
					charge.setPaydate(DateFormat.StringToDate(payd));
				}
				chargeService.updateByPrimaryKey(charge);
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
	
	@RequestMapping(value="/doSearch.action",method = RequestMethod.POST)
	public void doSearch(HttpServletResponse response,String name,String value,Integer page,Integer rows) {
		if(page==null) {
			page=1;
		}
		if(rows==null) {
			rows=10;
		}
		Map<String, Object> map = new HashMap<>();
		map.put("index", (page-1)*rows);
		map.put("pagesize", rows);
		map.put("name", name);
		map.put("value", value);
		int count = chargeService.findCountByCondition(map); 
		List<Charge> list = chargeService.findByPaginationAndCondition(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/findByPositionAndFeeState.action")
	public void findByPositionAndFeeState(HttpServletResponse response,String position) {
		List<Charge> list = chargeService.findByPositionAndFeeState(position);
		JSONObject result = new JSONObject();
		result.put("total", list.size());
		result.put("rows", JSONArray.fromObject(list));
		System.out.println(list.size());
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/paymentOffline.action",method = RequestMethod.POST)
	public void payment(HttpServletRequest request,HttpServletResponse response,String cid,String fid) throws Exception {
		Map<String, Object> map = new HashMap<>();
		User admin = (User) request.getSession().getAttribute("adminuser");
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			/*水电费与物业费都不为空*/
			if((cid!=null&&!cid.equals(""))&&(fid!=null&&!fid.equals(""))) {
				int[] cidArray = StringToInt.StringtoInt(cid, " ");
				int[] fidArray = StringToInt.StringtoInt(fid, " ");
					/*水电费缴纳*/
					cpayOffline(cidArray,admin.getUserId());
					/*物业费缴纳*/
					fpayOffline(fidArray,admin.getUserId());
					map.put("success", true);
					map.put("message", "缴费成功！");
			}
			/*水电费为空，物业费不为空*/
			if((cid==null||cid.equals(""))&&(fid!=null&&!fid.equals(""))) {
				int[] fidArray = StringToInt.StringtoInt(fid, " ");
					/*物业费缴纳*/
					fpayOffline(fidArray,admin.getUserId());
					map.put("success", true);
					map.put("message", "缴费成功！");
			}
			/*水电费不为空，物业费为空*/
			if((cid!=null&&!cid.equals(""))&&(fid==null||fid.equals(""))) {
				int[] cidArray = StringToInt.StringtoInt(cid, " ");
					/*水电费缴纳*/
					cpayOffline(cidArray,admin.getUserId());
					map.put("success", true);
					map.put("message", "缴费成功！");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	private void fpayOffline(int[] fidArray, Integer adminId) {
		PropertyFee propertyFee = new PropertyFee();
		for(int fid:fidArray) {
			propertyFee.setFeeId(fid);
			propertyFee.setWay("现金");
			propertyFee.setDeliverdate(new Date());
			propertyFee.setTransactor(adminId);
			propertyFeeService.updateByPrimaryKeySelective(propertyFee);
		}
	}

	private void cpayOffline(int[] cidArray, Integer adminId) {
		Charge charge = new Charge();
		for(int cid:cidArray) {
			charge.setChargeId(cid);
			charge.setWay("现金");
			charge.setPaydate(new Date());
			charge.setTransactor(adminId);
			chargeService.updateByPrimaryKeySelective(charge);
		}
	}

	@RequestMapping(value="/paymentOnline.action",method = RequestMethod.POST)
	public void paymentOnline(HttpServletRequest request,HttpServletResponse response,String cid,String fid) throws Exception {
		Map<String, Object> map = new HashMap<>();
		User userExist = (User) request.getSession().getAttribute("user");
		User user = userService.getDetailedUser(userExist.getUsername());
		if(user==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			double total = 0;
			/*水电费与物业费都不为空*/
			if((cid!=null&&!cid.equals(""))&&(fid!=null&&!fid.equals(""))) {
				int[] cidArray = StringToInt.StringtoInt(cid, " ");
				int[] fidArray = StringToInt.StringtoInt(fid, " ");
				/*查询到要缴费的信息*/
				Map<String, Object> cmap = findListByIdArray(cidArray);
				Map<String, Object> fmap = FeefindListByIdArray(fidArray);
				total = (double)cmap.get("total") + (double)fmap.get("total");
				/*比较余额是否足够缴费*/
				if(total>user.getHouse().getOwner().getAccount()) {
					map.put("success", false);
					map.put("message", "余额不足！");
				}else {
					user.getHouse().getOwner().pay(total);
					ownerService.updateByPrimaryKey(user.getHouse().getOwner());
					request.getSession().setAttribute("user", user);
					/*水电费缴纳*/
					cpayOnline(cidArray,user.getHouse().getOwnerId());
					/*物业费缴纳*/
					fpayOnline(fidArray,user.getHouse().getOwnerId());
					map.put("success", true);
					map.put("message", "缴费成功！");
					map.put("balance", user.getHouse().getOwner().getAccount());
				}
			}
			/*水电费为空，物业费不为空*/
			if((cid==null||cid.equals(""))&&(fid!=null&&!fid.equals(""))) {
				int[] fidArray = StringToInt.StringtoInt(fid, " ");
				Map<String, Object> fmap = FeefindListByIdArray(fidArray);
				total = (double)fmap.get("total");
				/*比较余额是否足够缴费*/
				if(total>user.getHouse().getOwner().getAccount()) {
					map.put("success", false);
					map.put("message", "余额不足！");
				}else {
					user.getHouse().getOwner().pay(total);
					ownerService.updateByPrimaryKey(user.getHouse().getOwner());
					request.getSession().setAttribute("user", user);
					/*物业费缴纳*/
					fpayOnline(fidArray,user.getHouse().getOwnerId());
					map.put("success", true);
					map.put("message", "缴费成功！");
					map.put("balance", user.getHouse().getOwner().getAccount());
				}
			}
			/*水电费不为空，物业费为空*/
			if((cid!=null&&!cid.equals(""))&&(fid==null||fid.equals(""))) {
				int[] cidArray = StringToInt.StringtoInt(cid, " ");
				/*查询到要缴费的信息*/
				Map<String, Object> cmap = findListByIdArray(cidArray);
				total = (double)cmap.get("total");
				/*比较余额是否足够缴费*/
				if(total>user.getHouse().getOwner().getAccount()) {
					map.put("success", false);
					map.put("message", "余额不足！");
				}else {
					user.getHouse().getOwner().pay(total);
					ownerService.updateByPrimaryKey(user.getHouse().getOwner());
					request.getSession().setAttribute("user", user);
					/*水电费缴纳*/
					cpayOnline(cidArray,user.getHouse().getOwnerId());
					map.put("success", true);
					map.put("message", "缴费成功！");
					map.put("balance", user.getHouse().getOwner().getAccount());
				}
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}

	private void fpayOnline(int[] fidArray, Integer oid) {
		PropertyFee propertyFee = new PropertyFee();
		for(int fid:fidArray) {
			propertyFee.setFeeId(fid);
			propertyFee.setWay("在线");
			propertyFee.setDeliverdate(new Date());
			propertyFee.setOwnerId(oid);
			propertyFeeService.updateByPrimaryKeySelective(propertyFee);
		}
	}

	private void cpayOnline(int[] cidArray, Integer oid) {
		Charge charge = new Charge();
		for(int cid:cidArray) {
			charge.setChargeId(cid);
			charge.setWay("在线");
			charge.setPaydate(new Date());
			charge.setOwnerId(oid);
			chargeService.updateByPrimaryKeySelective(charge);
		}
	}

	private Map<String, Object> FeefindListByIdArray(int[] fidArray) {
		double total = 0;
		List<PropertyFee> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		for(int fid:fidArray) {
			PropertyFee propertyFee = propertyFeeService.selectByPrimaryKey(fid);
			total+=propertyFee.getTotal();
			list.add(propertyFee);
		}
		map.put("total", total);
		map.put("list", list);
		return map;
	}

	private Map<String, Object> findListByIdArray(int[] cidArray) {
		double total = 0;
		List<Charge> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		for(int cid:cidArray) {
			Charge charge = chargeService.selectByPrimaryKey(cid);
			total+=charge.getTotal();
			list.add(charge);
		}
		map.put("total", total);
		map.put("list", list);
		return map;
	}

	
}
