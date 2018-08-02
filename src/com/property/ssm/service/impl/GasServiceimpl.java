package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.GasMapper;
import com.property.ssm.po.Gas;
import com.property.ssm.service.GasService;
@Service
@Transactional
public class GasServiceimpl implements GasService {
	@Resource
	private GasMapper gasMapper;
	@Override
	public int deleteByPrimaryKey(Integer gasId) {
		return gasMapper.deleteByPrimaryKey(gasId);
	}

	@Override
	public int insert(Gas record) {
		return gasMapper.insert(record);
	}

	@Override
	public int insertSelective(Gas record) {
		return gasMapper.insertSelective(record);
	}

	@Override
	public Gas selectByPrimaryKey(Integer gasId) {
		return gasMapper.selectByPrimaryKey(gasId);
	}

	@Override
	public int updateByPrimaryKeySelective(Gas record) {
		return gasMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Gas record) {
		return gasMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return gasMapper.findCount();
	}

	@Override
	public List<Gas> findByPagination(Map<String, Integer> map) {
		return gasMapper.findByPagination(map);
	}

	@Override
	public int findCountByCondition(Map<String, Object> map) {
		return gasMapper.findCountByCondition(map);
	}

	@Override
	public List<Gas> findByPaginationAndCondition(Map<String, Object> map) {
		return gasMapper.findByPaginationAndCondition(map);
	}

	@Override
	public Gas findByPosition(String position) {
		return gasMapper.findByPosition(position);
	}

	@Override
	public int editprice(Double price) {
		return gasMapper.editprice(price);
	}

}
