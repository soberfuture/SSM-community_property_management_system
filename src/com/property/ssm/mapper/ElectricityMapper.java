package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Electricity;

public interface ElectricityMapper {
    int deleteByPrimaryKey(Integer electricityId);

    int insert(Electricity record);

    int insertSelective(Electricity record);

    Electricity selectByPrimaryKey(Integer electricityId);

    int updateByPrimaryKeySelective(Electricity record);

    int updateByPrimaryKey(Electricity record);
    
    int findCount();//所有记录数
    
    List<Electricity> findByPagination(Map<String, Integer> map);//按分页查询所有记录
    
    Electricity findByPosition(String position);
    
    int editprice(Double price);
    
    List<Electricity> findByPaginationAndCondition(Map<String, Object> map);
    
    List<String> findPosition();
}