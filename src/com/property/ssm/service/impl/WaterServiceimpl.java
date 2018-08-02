package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.WaterMapper;
import com.property.ssm.po.Water;
import com.property.ssm.service.WaterService;
@Service
@Transactional
public class WaterServiceimpl implements WaterService {
	@Resource
	private WaterMapper waterMapper;
	@Override
	public int deleteByPrimaryKey(Integer waterId) {
		return waterMapper.deleteByPrimaryKey(waterId);
	}

	@Override
	public int insert(Water record) {
		return waterMapper.insert(record);
	}

	@Override
	public int insertSelective(Water record) {
		return waterMapper.insertSelective(record);
	}

	@Override
	public Water selectByPrimaryKey(Integer waterId) {
		return waterMapper.selectByPrimaryKey(waterId);
	}

	@Override
	public int updateByPrimaryKeySelective(Water record) {
		return waterMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Water record) {
		return waterMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return waterMapper.findCount();
	}

	@Override
	public List<Water> findByPagination(Map<String, Integer> map) {
		return waterMapper.findByPagination(map);
	}

	@Override
	public Water findByPosition(String position) {
		return waterMapper.findByPosition(position);
	}

	@Override
	public int editprice(Double price) {
		return waterMapper.editprice(price);
	}

	@Override
	public List<Water> findByPaginationAndCondition(Map<String, Object> map) {
		return waterMapper.findByPaginationAndCondition(map);
	}

}
