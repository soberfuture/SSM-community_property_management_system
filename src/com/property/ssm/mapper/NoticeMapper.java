package com.property.ssm.mapper;

import java.util.List;
import java.util.Map;

import com.property.ssm.po.Notice;

public interface NoticeMapper {
	
	int findCount();
	
	List<Notice> findByPagination(Map<String, Object> map);
	
	Notice selectByPrimaryKey(Integer nid);
	
	int deleteByPrimaryKey(Integer nid);
	
	int insert(Notice notice);
	
	int updateByPrimaryKeySelective(Notice notice);
	
}
