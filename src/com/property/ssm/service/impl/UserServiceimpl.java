package com.property.ssm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.property.ssm.mapper.UserMapper;
import com.property.ssm.po.User;
import com.property.ssm.service.UserService;
@Service
@Transactional
public class UserServiceimpl implements UserService {

	@Resource
	private UserMapper userMapper;
	@Override
	public User selectByPrimaryKey(Integer userId) {
		User user = userMapper.selectByPrimaryKey(userId);
		return user;
	}
	
	@Override
	public int deleteByPrimaryKey(Integer userId) {
		return userMapper.deleteByPrimaryKey(userId);
	}

	@Override
	public int insert(User record) {
		return userMapper.insert(record);
	}

	@Override
	public int insertSelective(User record) {
		return userMapper.insertSelective(record);
	}

	

	@Override
	public int updateByPrimaryKeySelective(User record) {
		return userMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(User record) {
		return userMapper.updateByPrimaryKey(record);
	}

	@Override
	public User check(Map<String, Object> map) {
		User user = userMapper.check(map);
		return user;
	}

	@Override
	public List<User> findByPagination(Map<String, Integer> map) {
		List<User> list = userMapper.findByPagination(map);
		return list;
	}

	@Override
	public int findCount() {
		int count = userMapper.findCount();
		return count;
	}

	@Override
	public User getDetailedUser(String position) {
		return userMapper.getDetailedUser(position);
	}

	@Override
	public User selectByUsername(String username) {
		return userMapper.selectByUsername(username);
	}

}
