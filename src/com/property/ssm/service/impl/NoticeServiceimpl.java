package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.NoticeMapper;
import com.property.ssm.po.Notice;
import com.property.ssm.service.NoticeService;
@Service
@Transactional
public class NoticeServiceimpl implements NoticeService {

	@Resource
	private NoticeMapper noticeMapper;
	
	@Override
	public int findCount() {
		return noticeMapper.findCount();
	}

	@Override
	public List<Notice> findByPagination(Map<String, Object> map) {
		return noticeMapper.findByPagination(map);
	}

	@Override
	public Notice selectByPrimaryKey(Integer nid) {
		return noticeMapper.selectByPrimaryKey(nid);
	}

	@Override
	public int deleteByPrimaryKey(Integer nid) {
		return noticeMapper.deleteByPrimaryKey(nid);
	}

	@Override
	public int insert(Notice notice) {
		return noticeMapper.insert(notice);
	}

	@Override
	public int updateByPrimaryKeySelective(Notice notice) {
		return noticeMapper.updateByPrimaryKeySelective(notice);
	}

}
