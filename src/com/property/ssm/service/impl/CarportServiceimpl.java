package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.CarportMapper;
import com.property.ssm.po.Carport;
import com.property.ssm.service.CarportService;
@Service
@Transactional
public class CarportServiceimpl implements CarportService {
	
	@Resource
	private CarportMapper carportMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer carportId) {
		int num = carportMapper.deleteByPrimaryKey(carportId);
		return num;
	}

	@Override
	public int insert(Carport record) {
		int num = carportMapper.insert(record);
		return num;
	}

	@Override
	public int insertSelective(Carport record) {
		int num = carportMapper.insertSelective(record);
		return num;
	}

	@Override
	public Carport selectByPrimaryKey(Integer carportId) {
		Carport carport = carportMapper.selectByPrimaryKey(carportId);
		return carport;
	}

	@Override
	public int updateByPrimaryKeySelective(Carport record) {
		int num = carportMapper.updateByPrimaryKey(record);
		return num;
	}

	@Override
	public int updateByPrimaryKey(Carport record) {
		int num = carportMapper.updateByPrimaryKey(record);
		return num;
	}

	@Override
	public int findCount() {
		int count = carportMapper.findCount();
		return count;
	}

	@Override
	public List<Carport> findByPagination(Map<String, Integer> map) {
		List<Carport> list = carportMapper.findByPagination(map);
		return list;
	}

	@Override
	public List<Carport> findByPosition(String position) {
		return carportMapper.findByPosition(position);
	}

	@Override
	public Carport findByCarportPosition(String carportPosition) {
		return carportMapper.findByCarportPosition(carportPosition);
	}

	@Override
	public List<Carport> findByStatus(String status) {
		return carportMapper.findByStatus(status);
	}

	@Override
	public int buyCarport(Carport carport) {
		return carportMapper.buyCarport(carport);
	}

}
