package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.MaintenanceMapper;
import com.property.ssm.po.Maintenance;
import com.property.ssm.service.MaintenanceService;
@Service
@Transactional
public class MaintenanceServiceimpl implements MaintenanceService {
	@Resource
	private MaintenanceMapper maintenanceMapper;
	@Override
	public int deleteByPrimaryKey(Integer maintenanceId) {
		return maintenanceMapper.deleteByPrimaryKey(maintenanceId);
	}

	@Override
	public int insert(Maintenance record) {
		return maintenanceMapper.insert(record);
	}

	@Override
	public int insertSelective(Maintenance record) {
		return maintenanceMapper.insertSelective(record);
	}

	@Override
	public Maintenance selectByPrimaryKey(Integer maintenanceId) {
		return maintenanceMapper.selectByPrimaryKey(maintenanceId);
	}

	@Override
	public int updateByPrimaryKeySelective(Maintenance record) {
		return maintenanceMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Maintenance record) {
		return maintenanceMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return maintenanceMapper.findCount();
	}

	@Override
	public List<Maintenance> findByPagination(Map<String, Integer> map) {
		return maintenanceMapper.findByPagination(map);
	}

	@Override
	public List<Maintenance> findByYearAndMonth(Map<String, Object> map) {
		return maintenanceMapper.findByYearAndMonth(map);
	}

}
