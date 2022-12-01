package com.ssafy.house.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.house.model.dto.Favorite;



public interface FavoriteService {
	List<Favorite> getFavorites(String id) throws SQLException;
	boolean searchFavorite(String id, String dongCode) throws SQLException;
	void insertFavorite(String id, String dongCode) throws SQLException;
	void removeFavorite(String id, String dongCode) throws SQLException;
	List<Favorite> doPagination(String id, int start, int len) throws SQLException;
}
