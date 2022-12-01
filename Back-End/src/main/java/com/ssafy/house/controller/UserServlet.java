//package com.ssafy.house.controller;
//
//import java.io.IOException;
//import java.security.KeyPairGenerator;
//import java.security.PrivateKey;
//import java.sql.SQLException;
//
//import java.security.KeyFactory;
//import java.security.KeyPair;
//import java.security.PublicKey;
//import java.security.spec.RSAPublicKeySpec;
//
//import javax.crypto.Cipher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//
//import com.ssafy.dto.User;
//import com.ssafy.model.service.FavoriteService;
//import com.ssafy.model.service.FavoriteServiceImpl;
//import com.ssafy.model.service.UserService;
//import com.ssafy.model.service.UserServiceImpl;
//
//@WebServlet("*.userdo")
//public class UserServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//	
//	private static String RSA_WEB_KEY = "_RSA_WEB_Key_"; // 개인키 session key
//	private static String RSA_INSTANCE = "RSA"; // rsa transformation
//	
//	
//	@Autowired
//	private UserService userService;
//	@Autowired
//	private FavoriteService favService;
//	
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		process(request, response);
//	}
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setCharacterEncoding("UTF-8");
//		process(request, response);
//	}
//
//	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String action = request.getServletPath();
//		System.out.println("!!!!!!! action : " + action);
//		String url = "redirect:index.jsp";
//		try {
//			switch (action) {
//			case "/signupForm.userdo":
//				url = signupForm(request, response);
//				break;
//			case "/signup.userdo":
//				url = signup(request, response);
//				break;
//			case "/loginForm.userdo":
//				url = loginForm(request, response);
//				break;
//			case "/login.userdo":
//				url = login(request, response);
//				break;
//			case "/logout.userdo":
//				url = logout(request, response);
//				break;
//			case "/userinfo.userdo":
//				url = userinfo(request, response);
//				break;
//			case "/userUpdateForm.userdo":
//				url = userUpdateForm(request, response);
//				break;
//			case "/userRemove.userdo":
//				url = userRemove(request, response);
//				break;
//			case "/userUpdate.userdo":
//				url = userUpdate(request, response);
//				break;
//			case "/userCancel.userdo":
//				url = "redirect:userinfo.userdo";
//				break;
//			case "/findPassForm.userdo":
//				url = findPassForm(request, response);
//				break;
//			case "/findPassword.userdo":
//				url = findPassword(request, response);
//				break;
//			case "/addFavorite.userdo":
//				url = addFavorite(request, response);
//				break;
//			case "/removeFavorite.userdo":
//				url = removeFavorite(request, response);
//				break;
//			default:
//				break;
//			}
//			
//			if (url.startsWith("redirect:")) {
//				response.sendRedirect(url.substring(9));
//			} else {
//				request.getRequestDispatcher(url).forward(request, response);
//			}
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//
//	private String removeFavorite(HttpServletRequest request, HttpServletResponse response) throws SQLException {
//		HttpSession session = request.getSession();
//		User user = (User) session.getAttribute("userInfo");
//		String id = user.getId();
//		String dongCode = request.getParameter("dongCode");
//		favService.removeFavorite(id, dongCode);
//		
//		return "redirect:dongFind.housedo?dongCode="+dongCode;
//	}
//
//	private String addFavorite(HttpServletRequest request, HttpServletResponse response) throws SQLException {
//		HttpSession session = request.getSession();
//		User user = (User) session.getAttribute("userInfo");
//		String id = user.getId();
//		String dongCode = request.getParameter("dongCode");
//		System.out.println(dongCode);
//		favService.insertFavorite(id, dongCode);
//		
//		return "redirect:dongFind.housedo?dongCode="+dongCode;
//	}
//
//	private String findPassword(HttpServletRequest request, HttpServletResponse response) throws SQLException {
//		String id = request.getParameter("id");
//		String name = request.getParameter("name");
//		String email = request.getParameter("email");
//		String password = userService.findPassword(id, name, email);
//		
//		if (password != null) {
//			request.setAttribute("msg", String.format("회원님의 비밀번호는 %s 입니다!", password));
//			return "user/login.jsp";
//		} else {
//			request.setAttribute("msg", "일치하는 회원 정보가 없습니다!");
//			return "user/findPassword.jsp";
//		}
//	}
//
//	private String findPassForm(HttpServletRequest request, HttpServletResponse response) {
//		return "redirect:user/findPassword.jsp";
//	}
//
//	private String userUpdate(HttpServletRequest request, HttpServletResponse response) throws SQLException {
//		String id = request.getParameter("id");
//		String password = request.getParameter("password");
//		String name = request.getParameter("name");
//		String email = request.getParameter("email");
//		User user = new User(id, password, name, email);
//		userService.update(user);
//		
//		HttpSession session = request.getSession();
//		session.setAttribute("userInfo", user);
//		
//		return "redirect:userinfo.userdo";
//	}
//
//	private String userRemove(HttpServletRequest request, HttpServletResponse response) throws SQLException {
//		HttpSession session = request.getSession();
//		User user = (User) session.getAttribute("userInfo");
//		userService.remove(user.getId());
//		session.invalidate();
//		return "redirect:index.jsp";
//	}
//
//	private String userUpdateForm(HttpServletRequest request, HttpServletResponse response) {
//		return "user/userUpdate.jsp";
//	}
//
//	private String userinfo(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		request.setAttribute("userInfo", (User) session.getAttribute("userInfo"));
//		return "user/userInfo.jsp";
//	}
//
//	private String logout(HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		session.invalidate();
//		return "redirect:index.jsp";
//	}
//
//	private String login(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String id = request.getParameter("id_rsa");
//		String password = request.getParameter("password_rsa");
//		HttpSession session = request.getSession();
//		PrivateKey privateKey = (PrivateKey) session.getAttribute(RSA_WEB_KEY);
//		
//		// 복호화
//		id = decryptRsa(privateKey, id);
//		password = decryptRsa(privateKey, password);
//		
//		// 개인키 삭제
//		session.removeAttribute(RSA_WEB_KEY);
//		
//		User user = userService.search(id, password);
//		
//		if (user != null) {
//			session.setAttribute("userInfo", user);
//			return "redirect:index.jsp";
//		} else {
//			request.setAttribute("msg", "아이디 또는 비밀번호가 잘못 되었습니다!");
//			return "user/login.jsp";
//		}
//	}
//
//	private String loginForm(HttpServletRequest request, HttpServletResponse response) {
//		// RSA 키 생성
//		initRsa(request);
//		return "user/login.jsp";
//	}
//
//	private String signup(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String id = request.getParameter("id_rsa");
//		String password = request.getParameter("password_rsa");
//		HttpSession session = request.getSession();
//		PrivateKey privateKey = (PrivateKey) session.getAttribute(RSA_WEB_KEY);
//		
//		// 복호화
//		id = decryptRsa(privateKey, id);
//		password = decryptRsa(privateKey, password);
//		
//		// 개인키 삭제
//		session.removeAttribute(RSA_WEB_KEY);
//				
//		String name = request.getParameter("name");
//		String email = request.getParameter("email");
//		userService.insert(new User(id, password, name, email));
//		
//		return "redirect:index.jsp";
//	}
//
//	private String signupForm(HttpServletRequest request, HttpServletResponse response) {
//		// RSA 키 생성
//		initRsa(request);
//		return "user/signup.jsp";
//	}
//	
//
//	//////////////////////////////////    RSA    ////////////////////////////////////////
//	/**
//	 * 복호화
//	 */
//	private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
//		Cipher cipher = Cipher.getInstance(RSA_INSTANCE);
//		byte[] encryptedBytes = hexToByteArray(securedValue);
//		cipher.init(Cipher.DECRYPT_MODE, privateKey);
//		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
//		String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
//		return decryptedValue;
//	}
//
//	/**
//	 * 16진 문자열을 byte 배열로 변환한다.     
//	 */
//	public static byte[] hexToByteArray(String hex) {
//		if (hex == null || hex.length() % 2 != 0) { return new byte[] {}; }
//		byte[] bytes = new byte[hex.length() / 2];
//		for (int i = 0; i < hex.length(); i += 2) {
//			byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
//			bytes[(int) Math.floor(i / 2)] = value;
//			}
//		return bytes;
//	}
//	
//	/**
//	 * rsa 공개키, 개인키 생성
//	 */
//	public void initRsa(HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		
//		KeyPairGenerator generator;
//		try {
//			generator = KeyPairGenerator.getInstance(RSA_INSTANCE);
//			generator.initialize(1024);
//			
//			KeyPair keyPair = generator.genKeyPair();
//			KeyFactory keyFactory = KeyFactory.getInstance(RSA_INSTANCE);
//			PublicKey publicKey = keyPair.getPublic();
//			PrivateKey privateKey = keyPair.getPrivate();
//			
//			session.setAttribute(RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장
//			
//			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
//			String publicKeyModulus = publicSpec.getModulus().toString(16);
//			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
//			
//			request.setAttribute("RSAModulus", publicKeyModulus); // rsa modulus 를 request 에 추가
//			request.setAttribute("RSAExponent", publicKeyExponent); // rsa exponent 를 request 에 추가
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//}
