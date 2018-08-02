package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.ChargeMapper;
import com.property.ssm.po.Charge;
import com.property.ssm.po.FeeRecord;
import com.property.ssm.service.ChargeService;
@Service
@Transactional
public class ChargeServiceimpl implements ChargeService {
	@Resource
	private ChargeMapper chargeMapper;

	@Override
	public int deleteByPrimaryKey(Integer chargeId) {
		return chargeMapper.deleteByPrimaryKey(chargeId);
	}

	@Override
	public int insert(Charge record) {
		return chargeMapper.insert(record);
	}

	@Override
	public int insertSelective(Charge record) {
		return chargeMapper.insertSelective(record);
	}

	@Override
	public Charge selectByPrimaryKey(Integer chargeId) {
		return chargeMapper.selectByPrimaryKey(chargeId);
	}

	@Override
	public int updateByPrimaryKeySelective(Charge record) {
		return chargeMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Charge record) {
		return chargeMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return chargeMapper.findCount();
	}

	@Override
	public List<Charge> findByPagination(Map<String, Integer> map) {
		return chargeMapper.findByPagination(map);
	}

	@Override
	public int findCountByCondition(Map<String, Object> map) {
		return chargeMapper.findCountByCondition(map);
	}

	@Override
	public List<Charge> findByPaginationAndCondition(Map<String, Object> map) {
		return chargeMapper.findByPaginationAndCondition(map);
	}

	@Override
	public List<Charge> findByPositionAndFeeState(String position) {
		return chargeMapper.findByPositionAndFeeState(position);
	}

	@Override
	public List<FeeRecord> findFeeRecord(Map<String, Object> map) {
		return chargeMapper.findFeeRecord(map);
	}

	@Override
	public List<Charge> findByYearAndMonth(Map<String, Object> map) {
		return chargeMapper.findByYearAndMonth(map);
	}


	@Override
	public List<FeeRecord> findListByUserAndCondition(FeeRecord feeRecord) {
		return chargeMapper.findListByUserAndCondition(feeRecord);
	}
}
