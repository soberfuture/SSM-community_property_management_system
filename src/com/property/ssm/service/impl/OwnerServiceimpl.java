package com.property.ssm.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.HouseMapper;
import com.property.ssm.mapper.OwnerMapper;
import com.property.ssm.mapper.UserMapper;
import com.property.ssm.po.House;
import com.property.ssm.po.Owner;
import com.property.ssm.po.User;
import com.property.ssm.service.OwnerService;
@Service
@Transactional
public class OwnerServiceimpl implements OwnerService {
	@Resource
	private OwnerMapper ownerMapper;
	@Resource
	private UserMapper userMapper;
	@Resource
	private HouseMapper houseMapper;
	@Override
	public int deleteByPrimaryKey(Integer ownerId) {
		return ownerMapper.deleteByPrimaryKey(ownerId);
	}

	@Override
	public int insert(Owner record) {
		return ownerMapper.insert(record);
	}

	@Override
	public int insertSelective(Owner record) {
		return ownerMapper.insertSelective(record);
	}

	@Override
	public Owner selectByPrimaryKey(Integer ownerId) {
		return ownerMapper.selectByPrimaryKey(ownerId);
	}

	@Override
	public int updateByPrimaryKeySelective(Owner record) {
		return ownerMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Owner record) {
		return ownerMapper.updateByPrimaryKey(record);
	}

	@Override
	public int findCount() {
		return ownerMapper.findCount();
	}

	@Override
	public List<Owner> findByPagination(Map<String, Integer> map) {
		return ownerMapper.findByPagination(map);
	}

	@Override
	public void addOwner(Owner owner, String position) {
		ownerMapper.insert(owner);
		House house = houseMapper.findByPosition(position);
		house.setOwnerId(owner.getOwnerId());
		house.setWorkoff("已入住");
		houseMapper.updateByPrimaryKeySelective(house);
		User user = new User();
		user.setUsername(position);
		user.setPassword(owner.getTel());
		user.setType("业主");
		user.setRetime(new Date());
		userMapper.insertSelective(user);
	}

}
