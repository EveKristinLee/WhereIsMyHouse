package com.ssafy.house.model.dao;

import com.ssafy.house.model.dto.User;

public interface UserDao {
	void insert(User user);
	User search(User user);
	void update(User user);
	void remove(String id);
	String findPassword(User user);
}
