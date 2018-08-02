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

import com.property.ssm.po.Owner;
import com.property.ssm.po.User;
import com.property.ssm.service.HouseService;
import com.property.ssm.service.OwnerService;
import com.property.ssm.util.DateFormat;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/owner")
public class OwnerController {

	@Autowired
	private OwnerService ownerService;
	@Autowired
	private HouseService houseService;
	
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
		int count = ownerService.findCount();
		List<Owner> list = ownerService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	@RequestMapping(value="/updateOwner.action",method = RequestMethod.POST)//更新业主信息
	public void updateOwner(HttpServletResponse response,Owner owner,String ind) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(ind==""||ind==null) {//判断入住日期是否选择
			map.put("success", false);
			map.put("message", "请选择入住时间");
		}else {
			try {
				owner.setIndate(DateFormat.StringToDate(ind));
				ownerService.updateByPrimaryKeySelective(owner);//更新业主信息
				map.put("success", true);//操作成功反馈信息
				map.put("message", "保存成功！");
			} catch (Exception e) {//出现异常
				System.out.println(e.getMessage());//异常输出
				map.put("success", false);//操作失败反馈信息
				map.put("message", "出错！");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));//使用json反馈信息到页面
	}
	
	@RequestMapping(value="/insertOwner.action",method = RequestMethod.POST)
	public void insertOwner(HttpServletResponse response,Owner owner,String ind,String outd) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(ind=="") {
			map.put("success", false);
			map.put("message", "请选择入住时间");
		}else {
			try {
				owner.setIndate(DateFormat.StringToDate(ind));
				if(outd!="") {
					owner.setOutdate(DateFormat.StringToDate(outd));
				}
				ownerService.insert(owner);
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
	
	@RequestMapping(value="/delOwner.action",method = RequestMethod.POST)
	public void delOwner(HttpServletResponse response,Integer ownerId) {
		Map<String, Object> map = new HashMap<>();
		if(ownerId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				Owner owner = new Owner();
				owner.setOwnerId(ownerId);
				owner.setOutdate(new Date());
				ownerService.updateByPrimaryKeySelective(owner);
				map.put("success", true);
				map.put("message", "迁出成功！");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				map.put("success", false);
				map.put("message", "出错");
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	/*增加新业主*/
	@RequestMapping(value="/addOwner.action",method = RequestMethod.POST)
	public void addOwner(HttpServletRequest request,HttpServletResponse response,Owner owner,String position) {
		Map<String, Object> map = new HashMap<>();
		User admin = (User) request.getSession().getAttribute("adminuser");
		if(admin==null) {
			map.put("success", false);
			map.put("message", "请登录！");
		}else {
			if(position==null||position.equals("")||checkPosition(position,"售出")) {
				map.put("success", false);
				map.put("message", "房间选择错误！");
			}else {
				try {
					owner.setIndate(new Date());
					owner.setAccount(0.0);
					ownerService.addOwner(owner,position);
					map.put("success", true);
					map.put("message", "新增业主成功！");
				} catch (Exception e) {
					System.out.println(e.getMessage());
					map.put("success", false);
					map.put("message", "出错");
				}
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));		
	}
	
	private boolean checkPosition(String position, String status) {
		Map<String, String> map = new HashMap<>();
		map.put("position", position);
		map.put("status", status);
		if(houseService.checkPosition(map)==null) {
			return true;
		}else {
			return false;
		}
	}

	@RequestMapping(value="/revise.action",method = RequestMethod.POST)
	public void revise(HttpServletRequest request,HttpServletResponse response,Owner owner) {
		User user = (User) request.getSession().getAttribute("user");
		Map<String, Object> map = new HashMap<>();
		try {
			ownerService.updateByPrimaryKeySelective(owner);
			Owner owner1 = ownerService.selectByPrimaryKey(user.getHouse().getOwnerId());
			user.getHouse().setOwner(owner1);
			request.getSession().setAttribute("user", user);
			map.put("success", true);
			map.put("message", "修改成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错");
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));		
	}
	
	@RequestMapping(value="/deposit.action",method = RequestMethod.POST)
	public void deposit(HttpServletResponse response,Integer ownerId,Double money) {
		Map<String, Object> map = new HashMap<>();
		if(ownerId==null) {
			map.put("success", true);
			map.put("message", "请选择充值业主！");
		}else {
			if(money==null) {
				map.put("success", true);
				map.put("message", "充值金额不能为空！");
			}else {
				try {
					Owner owner = ownerService.selectByPrimaryKey(ownerId);
					owner.deposit(money);
					ownerService.updateByPrimaryKeySelective(owner);
					map.put("success", true);
					map.put("message", "充值成功！");
				} catch (Exception e) {
					System.out.println(e.getMessage());
					map.put("success", false);
					map.put("message", "出错");
				}
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));		
	}
	
	@RequestMapping(value="/findOwner.action",method = RequestMethod.POST)
	public void findOwner(HttpServletResponse response,Integer houseId) {
		List<Owner> list = houseService.findOwner(houseId);
		JSONObject result = new JSONObject();
		result.put("rows", list);
		result.put("total", list.size());
		SendJson.sendAsJson(response,result);		
	}
}
