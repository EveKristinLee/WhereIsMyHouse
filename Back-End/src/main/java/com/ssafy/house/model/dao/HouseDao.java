package com.ssafy.house.model.dao;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.house.model.dto.*;

public interface HouseDao {
	List<House> searchByApt(String aptName);
	List<House> searchByDong(String dongCode);
	House searchByNo(int no);
	// TODO: - 이거 찜목록 주소 받아오는거니까 favorite으로 넘겨야하
	String searchAddressName(String dongCode);
	// 페이지네이션 일단 keep..
	List<House> pagination(String aptName, int start, int len);
	List<House> dongPagination(String dongName, int start, int len);
}
