package com.ssafy.house.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.house.model.dao.UserDao;
import com.ssafy.house.model.dto.User;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao dao;
	
	@Transactional
	@Override
	public void insert(User user) {
		User find = dao.search(user);
		if(find != null) {
			throw new RuntimeException("이미 등록된 사용자 입니다.");
		}
		dao.insert(user);
	}

	@Transactional(readOnly = true)
	@Override
	public User search(User user) {
		return dao.search(user);
	}

	@Override
	public void update(User user) {
		User find = dao.search(user);
		if(find != null) {
			throw new RuntimeException("사용자 정보를 수정할 수 없습니다.");
		}
		dao.update(user);
	}

	@Transactional
	@Override
	public void remove(String id) {
		dao.remove(id);
	}

	@Transactional(readOnly = true)
	@Override
	public String findPassword(User user) {
		return dao.findPassword(user);
	}

}
