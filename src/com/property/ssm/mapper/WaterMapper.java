package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Water;

public interface WaterMapper {
    int deleteByPrimaryKey(Integer waterId);

    int insert(Water record);

    int insertSelective(Water record);

    Water selectByPrimaryKey(Integer waterId);

    int updateByPrimaryKeySelective(Water record);

    int updateByPrimaryKey(Water record);
    
    int findCount();//所有记录数
    
    List<Water> findByPagination(Map<String, Integer> map);//按分页查询所有记录
    
    Water findByPosition(String position);
    
    int editprice(Double price);
    
    List<Water> findByPaginationAndCondition(Map<String, Object> map);
    
    List<String> findPosition();
}