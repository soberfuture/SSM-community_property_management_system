package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.FeeRecord;
import com.property.ssm.po.PropertyFee;

public interface PropertyFeeMapper {
    int deleteByPrimaryKey(Integer feeId);

    int insert(PropertyFee record);

    int insertSelective(PropertyFee record);

    PropertyFee selectByPrimaryKey(Integer feeId);

    int updateByPrimaryKeySelective(PropertyFee record);

    int updateByPrimaryKey(PropertyFee record);
    
    int findCount();//所有记录数
    
    List<PropertyFee> findByPagination(Map<String, Integer> map);//按分页查询所有记录

    int findCountByPositionAndFeeState(String position);
    
    List<PropertyFee> findByPositionAndFeeState(String position);
    
    List<FeeRecord> findFeeRecord(Map<String, Object> map);
    
    List<PropertyFee> findByYearAndMonth(Map<String, Object> map);
    
    List<PropertyFee> findByPaginationAndCondition(Map<String, Object> map);
    
    List<FeeRecord> findListByUserAndCondition(FeeRecord feeRecord);
}