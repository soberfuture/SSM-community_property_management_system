package com.property.ssm.service;

import java.util.List;

import com.property.ssm.po.Building;

public interface BuildingService {
	
	List<Building> findAll();
	
    Building selectByPrimaryKey(Integer bid);
    
    int deleteByPrimaryKey(Integer bid);
    
    int insert(Building building);
    
    int insertSelective(Building building);
    
    int updateByPrimaryKeySelective(Building building);
    
    Building selectByName(String bName);
}
