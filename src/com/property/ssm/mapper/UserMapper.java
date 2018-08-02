package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    User check(Map<String, Object> map);
    
    int findCount();
    
    List<User> findByPagination(Map<String, Integer> map);
    
    /*获得该业主的详细信息*/
    User getDetailedUser(String position);
    
    User selectByUsername(String username);
}