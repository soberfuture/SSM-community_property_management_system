package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.EvaluateMapper;
import com.property.ssm.po.Evaluate;
import com.property.ssm.service.EvaluateService;
@Service
@Transactional
public class EvaluateServiceimpl implements EvaluateService {
	
	@Resource
	private EvaluateMapper evaluateMapper;
	
	@Override
	public int insert(Evaluate evaluate) {
		return evaluateMapper.insert(evaluate);
	}

	@Override
	public List<Evaluate> findByETypeAndYearAndMonth(Map<String, Object> map) {
		return evaluateMapper.findByETypeAndYearAndMonth(map);
	}

}
