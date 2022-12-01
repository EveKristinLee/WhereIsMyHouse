package com.ssafy.house.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.house.model.dao.HouseDao;
import com.ssafy.house.model.dto.House;

@Service
public class HouseServiceImpl implements HouseService {

	@Autowired
	private HouseDao dao;
	
	@Override
	public List<House> searchByApt(String aptName) throws SQLException {
		
		return dao.searchByApt(aptName);
	}

	@Override
	public List<House> searchByDong(String dongCode) throws SQLException {
		return dao.searchByDong(dongCode);
	}

	@Override
	public House searchByNo(int no) throws SQLException {
		return dao.searchByNo(no);
	}

	// TODO: - 이거 찜목록 주소 받아오는거니까 favorite으로 넘겨야하
	@Override
	public String searchAddressName(String dongCode) throws SQLException {
		return dao.searchAddressName(dongCode);
	}

	@Override
	public List<House> pagination(String aptName, int start, int len) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<House> dongPagination(String dongName, int start, int len) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	
}
