package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Carport;

public interface CarportMapper {
    int deleteByPrimaryKey(Integer carportId); 

    int insert(Carport record);

    int insertSelective(Carport record);//有选择性的插入

    Carport selectByPrimaryKey(Integer carportId);

    int updateByPrimaryKeySelective(Carport record);//有选择性的更新

    int updateByPrimaryKey(Carport record);
    
    int findCount();//所有记录数
    
    List<Carport> findByPagination(Map<String, Integer> map);//按分页查询所有记录
    
    List<Carport> findByPosition(String position);
    
    Carport findByCarportPosition(String carportPosition);
    
    List<Carport> findByStatus(String status);
    
    int buyCarport(Carport carport);
}