package com.property.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.ElectricityMapper;
import com.property.ssm.mapper.GasMapper;
import com.property.ssm.mapper.HouseMapper;
import com.property.ssm.mapper.OwnerMapper;
import com.property.ssm.mapper.WaterMapper;
import com.property.ssm.po.House;
import com.property.ssm.po.Owner;
import com.property.ssm.service.HouseService;
@Service
@Transactional
public class HouseServiceimpl implements HouseService {

	@Resource
	private HouseMapper houseMapper;
	@Resource
	private OwnerMapper ownerMapper;
	@Resource
	private ElectricityMapper electricityMapper;
	@Resource
	private GasMapper gasMapper;
	@Resource
	private WaterMapper waterMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer houseId) {
		int num = houseMapper.deleteByPrimaryKey(houseId);
		return num;
	}

	@Override
	public House selectByPrimaryKey(Integer houseId) {
		House house = houseMapper.selectByPrimaryKey(houseId);
		return house;
	}

	@Override
	public int findCount() {
		int count = houseMapper.findCount();
		return count;
	}

	@Override
	public List<House> findByPagination(Map<String, Integer> map) {
		List<House> list = houseMapper.findByPagination(map);
		return list;
	}

	@Override
	public List<House> findAllHouse() {
		List<House> list = houseMapper.findAllHouse();
		return list;
	}

	@Override
	public int updateOwnerId(House record) {
		return houseMapper.updateOwnerId(record);
	}

	@Override
	public House findByPosition(String position) {
		return houseMapper.findByPosition(position);
	}

	@Override
	public List<House> findHouseByStatus(String status) {
		return houseMapper.findHouseByStatus(status);
	}

	@Override
	public int insert(House record) {
		return houseMapper.insert(record);
	}

	@Override
	public int insertSelective(House record) {
		return houseMapper.insertSelective(record);
	}

	@Override
	public int updateByPrimaryKeySelective(House record) {
		return houseMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(House record) {
		return houseMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Owner> findOwner(Integer houseId) {
		House house = houseMapper.selectByPrimaryKey(houseId);
		List<Owner> list = new ArrayList<>();
		list.add(ownerMapper.selectByPrimaryKey(house.getOwnerId()));
		return list;
	}

	@Override
	public House checkPosition(Map<String, String> map) {
		return houseMapper.findByPositionAndStatus(map);
	}

	@Override
	public List<String> findPositionByStatus(String status) {
		return houseMapper.findPositionByStatus(status);
	}

	@Override
	public List<House> findEleHouse() {
		List<String> eleList = electricityMapper.findPosition();
		List<House> list = getHouse(eleList);
		return list;
	}

	@Override
	public List<House> findGasHouse() {
		List<String> gasList = gasMapper.findPosition();
		List<House> list = getHouse(gasList);
		return list;
	}
	
	@Override
	public List<House> findWaterHouse() {
		List<String> waterList = electricityMapper.findPosition();
		List<House> list = getHouse(waterList);
		return list;
	}
	
	/*计算已入住的房间未装水电气表的房间*/
	private List<House> getHouse(List<String> otherList) {
		List<String> houseList = houseMapper.findPositionByStatus("已入住");
		houseList.removeAll(otherList);
		List<House> list = new ArrayList<>();
		for(String position:houseList) {
			House house = houseMapper.findByPosition(position);
			list.add(house);
		}
		return list;
	}
	
}
