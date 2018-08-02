package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.House;

public interface HouseMapper {
	
	/*按主键删除*/
    int deleteByPrimaryKey(Integer houseId);
    
    /*按主键查询*/
    House selectByPrimaryKey(Integer houseId);
    
    /*查询总记录数*/
    int findCount();
    
    /*按分页查询*/
    List<House> findByPagination(Map<String, Integer> map);
    
    /*添加或更新*/
    int insert(House record);
    
    int insertSelective(House record);
    
    int updateByPrimaryKeySelective(House record);
    
    int updateByPrimaryKey(House record);
    
    /*获得所有房间信息*/
    List<House> findAllHouse();
    
    /*添加用户id*/
    int updateOwnerId(House record);
    
    House findByPosition(String position);
    
    /*按房间状态查询所有房间*/
    List<House> findHouseByStatus(String status);
    
    House findByPositionAndStatus(Map<String, String> map);
    
    List<String> findPositionByStatus(String status);
}