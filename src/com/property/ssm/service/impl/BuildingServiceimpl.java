package com.property.ssm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.BuildingMapper;
import com.property.ssm.po.Building;
import com.property.ssm.service.BuildingService;
@Service
@Transactional
public class BuildingServiceimpl implements BuildingService {

	@Resource
	private BuildingMapper buildingMapper;
	
	@Override
	public List<Building> findAll() {
		return buildingMapper.findAll();
	}

	@Override
	public Building selectByPrimaryKey(Integer bid) {
		return buildingMapper.selectByPrimaryKey(bid);
	}

	@Override
	public int deleteByPrimaryKey(Integer bid) {
		return buildingMapper.deleteByPrimaryKey(bid);
	}

	@Override
	public int insert(Building building) {
		return buildingMapper.insert(building);
	}

	@Override
	public int insertSelective(Building building) {
		return buildingMapper.insertSelective(building);
	}

	@Override
	public int updateByPrimaryKeySelective(Building building) {
		return buildingMapper.updateByPrimaryKeySelective(building);
	}

	@Override
	public Building selectByName(String bName) {
		return buildingMapper.selectByName(bName);
	}

}
