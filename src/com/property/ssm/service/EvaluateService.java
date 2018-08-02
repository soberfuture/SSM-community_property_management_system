package com.property.ssm.service;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Evaluate;

public interface EvaluateService {
	int insert(Evaluate evaluate);
	
	List<Evaluate> findByETypeAndYearAndMonth(Map<String, Object> map);
}
