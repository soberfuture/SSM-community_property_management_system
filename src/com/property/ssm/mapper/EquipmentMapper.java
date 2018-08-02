package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Equipment;

public interface EquipmentMapper {
    int deleteByPrimaryKey(Integer equipmentId);

    int insert(Equipment record);

    int insertSelective(Equipment record);

    Equipment selectByPrimaryKey(Integer equipmentId);

    int updateByPrimaryKeySelective(Equipment record);

    int updateByPrimaryKey(Equipment record);
    
    int findCount();//所有记录数
    
    List<Equipment> findByPagination(Map<String, Integer> map);//按分页查询所有记录
}