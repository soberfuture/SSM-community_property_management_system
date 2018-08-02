package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.ElectricityMapper;
import com.property.ssm.po.Electricity;
import com.property.ssm.service.ElectricityService;
@Service
@Transactional
public class ElectricityServiceimpl implements ElectricityService {
	@Resource
	private ElectricityMapper electricityMapper;
	@Override
	public int deleteByPrimaryKey(Integer electricityId) {
		return electricityMapper.deleteByPrimaryKey(electricityId);
	}

	@Override
	public int insert(Electricity record) {
		return electricityMapper.insert(record);
	}

	@Override
	public int insertSelective(Electricity record) {
		return electricityMapper.insertSelective(record);
	}

	@Override
	public Electricity selectByPrimaryKey(Integer electricityId) {
		return electricityMapper.selectByPrimaryKey(electricityId);
	}

	@Override
	public int updateByPrimaryKeySelective(Electricity record) {
		return electricityMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Electricity record) {
		return electricityMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int findCount() {
		return electricityMapper.findCount();
	}

	@Override
	public List<Electricity> findByPagination(Map<String, Integer> map) {
		return electricityMapper.findByPagination(map);
	}

	@Override
	public Electricity findByPosition(String position) {
		return electricityMapper.findByPosition(position);
	}

	@Override
	public int editprice(Double price) {
		return electricityMapper.editprice(price);
	}

	@Override
	public List<Electricity> findByPaginationAndCondition(Map<String, Object> map) {
		return electricityMapper.findByPaginationAndCondition(map);
	}

}
