package com.property.ssm.service;

import java.util.List;

import com.property.ssm.po.Parking;

public interface ParkingService {

	List<Parking> findAll();
	
	Parking selectByPrimaryKey(Integer pid);
    
    int deleteByPrimaryKey(Integer pid);
    
    int insert(Parking parking);
    
    int insertSelective(Parking parking);
    
    int updateByPrimaryKeySelective(Parking parking);
    
    Parking selectByName(String pregion);
}
