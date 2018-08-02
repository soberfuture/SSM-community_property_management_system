package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.EquipmentMapper;
import com.property.ssm.po.Equipment;
import com.property.ssm.service.EquipmentService;
@Service
@Transactional
public class EquipmentServiceimpl implements EquipmentService {
	@Resource
	private EquipmentMapper equipmentMapper;
	@Override
	public int deleteByPrimaryKey(Integer equipmentId) {
		return equipmentMapper.deleteByPrimaryKey(equipmentId);
	}

	@Override
	public int insert(Equipment record) {
		return equipmentMapper.insert(record);
	}

	@Override
	public int insertSelective(Equipment record) {
		return equipmentMapper.insertSelective(record);
	}

	@Override
	public Equipment selectByPrimaryKey(Integer equipmentId) {
		return equipmentMapper.selectByPrimaryKey(equipmentId);
	}

	@Override
	public int updateByPrimaryKeySelective(Equipment record) {
		return equipmentMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Equipment record) {
		return equipmentMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return equipmentMapper.findCount();
	}

	@Override
	public List<Equipment> findByPagination(Map<String, Integer> map) {
		return equipmentMapper.findByPagination(map);
	}

}
