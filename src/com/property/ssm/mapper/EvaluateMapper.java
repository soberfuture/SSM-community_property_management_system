package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Evaluate;

public interface EvaluateMapper {
	
	int insert(Evaluate evaluate);
	
	List<Evaluate> findByETypeAndYearAndMonth(Map<String, Object> map);
}
