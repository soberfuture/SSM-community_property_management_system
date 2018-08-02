package com.property.ssm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.ParkingMapper;
import com.property.ssm.po.Parking;
import com.property.ssm.service.ParkingService;
@Service
@Transactional
public class ParkingServiceimpl implements ParkingService {
	
	@Resource
	private ParkingMapper parkingMapper;
	@Override
	public List<Parking> findAll() {
		return parkingMapper.findAll();
	}
	@Override
	public Parking selectByPrimaryKey(Integer pid) {
		return parkingMapper.selectByPrimaryKey(pid);
	}
	@Override
	public int deleteByPrimaryKey(Integer pid) {
		return parkingMapper.deleteByPrimaryKey(pid);
	}
	@Override
	public int insert(Parking parking) {
		return parkingMapper.insert(parking);
	}
	@Override
	public int insertSelective(Parking parking) {
		return parkingMapper.insertSelective(parking);
	}
	@Override
	public int updateByPrimaryKeySelective(Parking parking) {
		return parkingMapper.updateByPrimaryKeySelective(parking);
	}
	@Override
	public Parking selectByName(String pregion) {
		return parkingMapper.selectByName(pregion);
	}

}
