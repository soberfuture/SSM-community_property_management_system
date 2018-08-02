package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.PropertyFeeMapper;
import com.property.ssm.po.FeeRecord;
import com.property.ssm.po.PropertyFee;
import com.property.ssm.service.PropertyFeeService;
@Service
@Transactional
public class PropertyFeeServiceimpl implements PropertyFeeService {
	@Resource
	private PropertyFeeMapper propertyFeeMapper;
	@Override
	public int deleteByPrimaryKey(Integer feeId) {
		return propertyFeeMapper.deleteByPrimaryKey(feeId);
	}

	@Override
	public int insert(PropertyFee record) {
		return propertyFeeMapper.insert(record);
	}

	@Override
	public int insertSelective(PropertyFee record) {
		return propertyFeeMapper.insertSelective(record);
	}

	@Override
	public PropertyFee selectByPrimaryKey(Integer feeId) {
		return propertyFeeMapper.selectByPrimaryKey(feeId);
	}

	@Override
	public int updateByPrimaryKeySelective(PropertyFee record) {
		return propertyFeeMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(PropertyFee record) {
		return propertyFeeMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return propertyFeeMapper.findCount();
	}

	@Override
	public List<PropertyFee> findByPagination(Map<String, Integer> map) {
		return propertyFeeMapper.findByPagination(map);
	}

	@Override
	public List<PropertyFee> findByPositionAndFeeState(String position) {
		return propertyFeeMapper.findByPositionAndFeeState(position);
	}

	@Override
	public int findCountByPositionAndFeeState(String position) {
		return propertyFeeMapper.findCountByPositionAndFeeState(position);
	}

	@Override
	public List<FeeRecord> findFeeRecord(Map<String, Object> map) {
		return propertyFeeMapper.findFeeRecord(map);
	}

	@Override
	public List<PropertyFee> findByYearAndMonth(Map<String, Object> map) {
		return propertyFeeMapper.findByYearAndMonth(map);
	}

	@Override
	public List<PropertyFee> findByPaginationAndCondition(Map<String, Object> map) {
		return propertyFeeMapper.findByPaginationAndCondition(map);
	}


	@Override
	public List<FeeRecord> findListByUserAndCondition(FeeRecord feeRecord) {
		return propertyFeeMapper.findListByUserAndCondition(feeRecord);
	}

}
