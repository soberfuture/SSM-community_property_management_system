package com.property.ssm.service;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Gas;

public interface GasService {
    int deleteByPrimaryKey(Integer gasId);

    int insert(Gas record);

    int insertSelective(Gas record);

    Gas selectByPrimaryKey(Integer gasId);

    int updateByPrimaryKeySelective(Gas record);

    int updateByPrimaryKey(Gas record);
    
    int findCount();//所有记录数
    
    List<Gas> findByPagination(Map<String, Integer> map);//按分页查询所有记录  
    
    int findCountByCondition(Map<String, Object> map);//按条件所有记录数
    
    List<Gas> findByPaginationAndCondition(Map<String, Object> map);//按条件分页查询所有记录
    
    Gas findByPosition(String position);
    
    int editprice(Double price);
}
