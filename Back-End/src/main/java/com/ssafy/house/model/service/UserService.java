package com.ssafy.house.model.service;

import com.ssafy.house.model.dto.User;

public interface UserService {
	void insert(User user);
	User search(User user);
	void update(User user);
	void remove(String id);
	String findPassword(User user);
}
