package com.property.ssm.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.property.ssm.po.House;
import com.property.ssm.service.HouseService;
import com.property.ssm.util.SendJson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/house")
public class HouseController {

	@Autowired
	private HouseService houseService;
	
	@RequestMapping(value="/housePage.action")
	public String housePage(HttpServletRequest request) {
		
		return "houselist";
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
		int count = houseService.findCount();
		List<House> list = houseService.findByPagination(map);
		JSONObject result = new JSONObject();
		result.put("total", count);
		result.put("rows",JSONArray.fromObject(list) );
		SendJson.sendAsJson(response, result);
	}
	
	
	@RequestMapping(value="/findByHouseId.action",method = RequestMethod.POST)
	public void findByHouseId(HttpServletResponse response,int id) {
		House house = houseService.selectByPrimaryKey(id);
		SendJson.sendAsJson(response, house);
	}
	
	@RequestMapping(value="/insertHouse.action",method = RequestMethod.POST)//插入房产
	public void insertHouse(HttpServletResponse response,House house) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		if(house.getPosition()==null||house.getPosition().equals("")) {//房产地址为空
			map.put("success", false);
			map.put("message", "请选择地址");
		}else {
			House existHouse = houseService.findByPosition(house.getPosition());//通过物业地址查询房产信息
			if(existHouse!=null) {//房产不存在
				map.put("success", false);
				map.put("message", "该地址已存在");
			}else {//房产存在
				try {
					houseService.insert(house);//插入操作
					map.put("success", true);
					map.put("message", "保存成功！");//反馈信息
				} catch (Exception e) {//发生异常
					System.out.println(e.getMessage());//输出异常信息
					map.put("success", false);
					map.put("message", "出错");//反馈信息
				}
			}
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));//使用json反馈信息到页面
	}
	
	@RequestMapping(value="/updateHouse.action",method = RequestMethod.POST)
	public void updateHouse(HttpServletResponse response,House house) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		try {
			houseService.updateByPrimaryKeySelective(house);
			map.put("success", true);
			map.put("message", "保存成功！");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			map.put("success", false);
			map.put("message", "出错");
		}
		SendJson.sendAsJson(response,JSONObject.fromObject(map));
	}
	
	@RequestMapping(value="/delHouseList.action",method = RequestMethod.POST)
	public void delHouseList(HttpServletResponse response,Integer houseId) {
		Map<String, Object> map = new HashMap<>();
		if(houseId==null) {
			map.put("success", false);
			map.put("message", "请选择删除的行！");
		}else {
			try {
				houseService.deleteByPrimaryKey(houseId);
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
	
	/*获得所有房间的信息*/
	@RequestMapping(value="/findAllHouse.action",method = RequestMethod.POST)
	public void findAllHouse(HttpServletResponse response) {
		List<House> list = houseService.findAllHouse();
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
	
	@RequestMapping(value="houseExist.action")
	public void houseExist(HttpServletResponse response,String position) {
		Map<String, Object> map= new HashMap<>();
		try {
			House house = houseService.findByPosition(position);
			if(house==null) {
				map.put("success", false);
			}else {
				map.put("success", true);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		SendJson.sendAsJson(response, JSONObject.fromObject(map));
	}
	
	/*获得所有已售房间*/
	@RequestMapping(value="/findHouseByStatus.action")
	public void findHouseByStatus(HttpServletResponse response,String status) {
		List<House> list = houseService.findHouseByStatus(status);
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
	
	@RequestMapping(value="/isExist.action")
	public void isExist(HttpServletResponse response,String position) {
		boolean success = false;
		House house = houseService.findByPosition(position);
		if(house!=null) {
			success = true;
		}else {
			success = false;
		}
		SendJson.sendAsJson(response, success);
	}
	
	/*查询已入住房间中未装电表的房间*/
	@RequestMapping(value="findEleHouse.action")
	public void findEleHouse(HttpServletResponse response) {
		List<House> list = houseService.findEleHouse();
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
	
	/*查询已入住房间中未装水表的房间*/
	@RequestMapping(value="findWaterHouse.action")
	public void findWaterHouse(HttpServletResponse response) {
		List<House> list = houseService.findWaterHouse();
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
	
	/*查询已入住房间中未装天然气表的房间*/
	@RequestMapping(value="findGasHouse.action")
	public void findGasHouse(HttpServletResponse response) {
		List<House> list = houseService.findGasHouse();
		SendJson.sendAsJson(response, JSONArray.fromObject(list));
	}
}
