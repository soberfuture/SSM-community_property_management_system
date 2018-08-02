package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.RepairMapper;
import com.property.ssm.po.FeeRecord;
import com.property.ssm.po.Repair;
import com.property.ssm.service.RepairService;
@Service
@Transactional
public class RepairServiceimpl implements RepairService {
	@Resource
	private RepairMapper repairMapper;
	@Override
	public int deleteByPrimaryKey(Integer repairId) {
		return repairMapper.deleteByPrimaryKey(repairId);
	}

	@Override
	public int insert(Repair record) {
		return repairMapper.insert(record);
	}

	@Override
	public int insertSelective(Repair record) {
		return repairMapper.insertSelective(record);
	}

	@Override
	public Repair selectByPrimaryKey(Integer repairId) {
		return repairMapper.selectByPrimaryKey(repairId);
	}

	@Override
	public int updateByPrimaryKeySelective(Repair record) {
		return repairMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Repair record) {
		return repairMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return repairMapper.findCount();
	}

	@Override
	public List<Repair> findByPagination(Map<String, Integer> map) {
		return repairMapper.findByPagination(map);
	}

	@Override
	public List<Repair> findByPosition(String position) {
		return repairMapper.findByPosition(position);
	}

	@Override
	public List<Repair> findByPositionAndSituation(FeeRecord feeRecord) {
		return repairMapper.findByPositionAndSituation(feeRecord);
	}

	@Override
	public List<Repair> findByStatus(Map<String, Object> map) {
		return repairMapper.findByStatus(map);
	}

	@Override
	public int findCountByConditionAndPagination(FeeRecord feeRecord) {
		return repairMapper.findCountByConditionAndPagination(feeRecord);
	}

	@Override
	public List<Repair> findByConditionAndPagination(FeeRecord feeRecord) {
		return repairMapper.findByConditionAndPagination(feeRecord);
	}

}
