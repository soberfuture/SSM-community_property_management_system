package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.ComplaintMapper;
import com.property.ssm.po.Complaint;
import com.property.ssm.po.FeeRecord;
import com.property.ssm.service.ComplaintService;
@Service
@Transactional
public class ComplaintServiceimpl implements ComplaintService {
	@Resource
	private ComplaintMapper complaintMapper;
	@Override
	public int deleteByPrimaryKey(Integer complaintId) {
		return complaintMapper.deleteByPrimaryKey(complaintId);
	}

	@Override
	public int insert(Complaint record) {
		return complaintMapper.insert(record);
	}

	@Override
	public int insertSelective(Complaint record) {
		return complaintMapper.insertSelective(record);
	}

	@Override
	public Complaint selectByPrimaryKey(Integer complaintId) {
		return complaintMapper.selectByPrimaryKey(complaintId);
	}

	@Override
	public int updateByPrimaryKeySelective(Complaint record) {
		return complaintMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Complaint record) {
		return complaintMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return complaintMapper.findCount();
	}

	@Override
	public List<Complaint> findByPagination(Map<String, Integer> map) {
		return complaintMapper.findByPagination(map);
	}

	@Override
	public List<Complaint> findByPosition(String position) {
		return complaintMapper.findByPosition(position);
	}

	@Override
	public List<Complaint> findByPositionAndComplaintStatus(FeeRecord feeRecord) {
		return complaintMapper.findByPositionAndComplaintStatus(feeRecord);
	}

	@Override
	public List<Complaint> findComplaintAndEvaluate() {
		return complaintMapper.findComplaintAndEvaluate();
	}

	@Override
	public List<Complaint> findByStatus(Map<String, Object> map) {
		return complaintMapper.findByStatus(map);
	}

	@Override
	public int findCountByConditionAndPagination(FeeRecord feeRecord) {
		return complaintMapper.findCountByConditionAndPagination(feeRecord);
	}

	@Override
	public List<Complaint> findByConditionAndPagination(FeeRecord feeRecord) {
		return complaintMapper.findByConditionAndPagination(feeRecord);
	}

}
