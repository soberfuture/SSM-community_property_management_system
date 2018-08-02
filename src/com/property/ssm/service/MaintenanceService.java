package com.property.ssm.service;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Maintenance;

public interface MaintenanceService {
    int deleteByPrimaryKey(Integer maintenanceId);

    int insert(Maintenance record);

    int insertSelective(Maintenance record);

    Maintenance selectByPrimaryKey(Integer maintenanceId);

    int updateByPrimaryKeySelective(Maintenance record);

    int updateByPrimaryKey(Maintenance record);
    
    int findCount();//所有记录数
    
    List<Maintenance> findByPagination(Map<String, Integer> map);//按分页查询所有记录 
    
    List<Maintenance> findByYearAndMonth(Map<String, Object> map);
}
