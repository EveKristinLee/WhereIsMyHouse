package com.ssafy.house.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.house.model.dto.House;

public interface HouseService {
	List<House> searchByApt(String aptName) throws SQLException;
	List<House> searchByDong(String dongCode) throws SQLException;
	House searchByNo(int no) throws SQLException;
	// TODO: - 이거 찜목록 주소 받아오는거니까 favorite으로 넘겨야하
	String searchAddressName(String dongCode) throws SQLException;
	List<House> pagination(String aptName, int start, int len) throws SQLException;
	List<House> dongPagination(String dongName, int start, int len) throws SQLException;
}
