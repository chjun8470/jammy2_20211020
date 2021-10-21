<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import = "java.sql.*, java.lang.*" %>


 <%

		Connection conn = null; // null로 초기화 한다.
		PreparedStatement pstmt = null;
		ResultSet equRs = null;
		ResultSet yeyaRs = null;
		ResultSet userRs = null;
		
		try {
			
			String url = "jdbc:mysql://192.168.20.11:3306/jnspcms?characterEncoding=utf8"; // 사용하려는 데이터베이스명을 포함한 URL 기술
			String id = "jnspcms"; // 사용자 계정
			String pw = "jnspcms!@12"; // 사용자 계정의 패스워드

			Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
			conn = DriverManager.getConnection(url, id, pw); // DriverManager 객체로부터 Connection 객체를 얻어온다.
			
			String equOrderIdx = (String)request.getParameter("equOrderIdx");
			String rndEquIdx = (String)request.getParameter("rndEquIdx");
			String userIdx = (String)request.getParameter("userIdx");
			
			String sql_equSql = "SELECT A.RND_EQU_IDX, A.FIXED_ASET_NO, A.KOR_NM, A.ENG_NM, A.NTIS_EQUIP_INFO";
				sql_equSql += " FROM TB_EQU_INFO AS A";
				sql_equSql += " LEFT JOIN TB_EQU_INFO_UPDATE AS C ON (A.RND_EQU_IDX = C.RND_EQU_IDX)";
				sql_equSql += " LEFT JOIN TB_USER_COPY AS B ON (A.EQU_USER_IDX = B.USER_IDX)";
				sql_equSql += " WHERE 1=1 ";
				sql_equSql += " AND A.RND_EQU_IDX = '"+rndEquIdx+"'";
				sql_equSql += " AND (A.DELETE_YN != 'Y' or A.DELETE_YN IS NULL)";
				sql_equSql += " AND (C.UP_DELETE_YN != 'Y' or C.UP_DELETE_YN IS NULL)";
							
			pstmt = conn.prepareStatement(sql_equSql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
			equRs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
			equRs.next();
			
			String sql_yeyaSql = "SELECT CONCAT(A.USE_ST_DT,' ~ ',A.USE_ED_DT) AS USE_DT, CONCAT(A.REAL_USE_ST_DT,' ~ ',A.REAL_USE_ED_DT) AS REAL_DT, A.USE_ST_DT, A.USE_ED_DT, A.ORDER_TYPE, ";
				sql_yeyaSql += "DATE_FORMAT(A.ORDER_DT, '%Y-%m-%d %H:%i') AS ORDER_DT, DATE_FORMAT(A.ORDER_OPERATOR_DT, '%Y-%m-%d %H:%i') AS ORDER_DATA, A.REAL_USE_ST_DT, A.REAL_USE_ED_DT,";
				sql_yeyaSql += "B.PSN_NM, B.EMAIL, A.PHONE, A.DEPT_NM, A.CORP_RESPONSIBLE_USER, C.KOR_NM, C.ENG_NM, C.MODEL_NM, A.SAMPLE_NM, A.SAMPLE_NO, ";
				sql_yeyaSql += "CASE  WHEN A.USE_MEAN = '1' THEN '서비스의뢰' WHEN A.USE_MEAN = '2' THEN '직접사용' WHEN A.USE_MEAN = '3' THEN '야간 및 휴일사용' ELSE '' END AS USE_MEAN, ";
				sql_yeyaSql += "D.RENTAL_INFO, D.USE_MARK_TEXT, A.USE_PURPOSE, A.SAMPLE_MATTER, IFNULL('',A.ORG_RECEIPT_NO) AS ORG_RECEIPT_NO";
				sql_yeyaSql += " FROM TB_EQU_ORDER A ";
				sql_yeyaSql += " LEFT JOIN TB_USER_COPY B ON A.USER_IDX = B.USER_IDX";
				sql_yeyaSql += " LEFT JOIN TB_EQU_INFO C ON A.RND_EQU_IDX = C.RND_EQU_IDX ";
				sql_yeyaSql += " LEFT JOIN TB_EQU_GOODS D ON A.RND_EQU_IDX = D.RND_EQU_IDX ";
				sql_yeyaSql += " WHERE A.EQU_ORDER_IDX = '"+equOrderIdx+"' ";
			
			pstmt = null;
			pstmt = conn.prepareStatement(sql_yeyaSql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
			yeyaRs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
			yeyaRs.next();
			String orderType = yeyaRs.getString("ORDER_TYPE");
			
	 			
 			String sql_userSql = "";
	 			if(orderType.equals("ONLINE")){
	 				sql_userSql += "SELECT U.PSN_NM, O.ORG_GRP_NM, U.POSITION_NM, U.EMAIL";
	 				sql_userSql += " FROM TB_USER_COPY AS U";
	 				sql_userSql += " LEFT JOIN TB_ORG_GRP AS O ON U.ORG_GRP_CD = O.ORG_GRP_CD";
	 				sql_userSql += " LEFT JOIN JMY_BOARD_ARTICLE AS A ON U.USER_IDX = A.NUM1 AND  A.BOARD_ID = '00014'";
	 				sql_userSql += " WHERE 1=1";
	 				sql_userSql += " AND U.USER_IDX = '"+userIdx+"' ";
	 				sql_userSql += " AND U.DELETE_YN != 'Y'";
	 			}
	 			if(orderType.equals("OFFLINE")){
	 				sql_userSql += "SELECT U.PSN_NM, O.ORG_GRP_NM, U.POSITION_NM, U.EMAIL";
	 				sql_userSql += " FROM TB_OFFLINE_USER AS U";
	 				sql_userSql += " LEFT JOIN TB_ORG_GRP AS O ON U.ORG_GRP_CD = O.ORG_GRP_CD";
	 				sql_userSql += " WHERE 1=1";
	 				sql_userSql += " AND U.USER_IDX = '"+userIdx+"'";
	 				sql_userSql += " AND U.DELETE_YN != 'Y'";
	 			}
	 	
	 		
	 		pstmt = null;
 			pstmt = conn.prepareStatement(sql_userSql); // prepareStatement에서 해당 sql을 미리 컴파일한다.	
 			userRs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
 			userRs.next();
 			
 	%>	


<html>
	<head>
		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_tpl.css">
		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css">
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_3.css">
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css">
		<link href="/css/cms/sub.css" media="all" rel="stylesheet" type="text/css">
		
		<style type="text/css">
			@page Section1 {
				size: 8.27in 11.69in; 
				margin: .5in .5in .5in .5in; 
				mso-header-margin: .5in; 
				mso-footer-margin: .5in;
				mso-paper-source: 0;
			}
			
			.bdT0{border-top:0!important}
			.bdR0{border-right:0!important}
			.txtC{text-align:center!important}			
			.add_bdT{border-top:1px solid #e0e0e0}
			.add_bdR{border-right:1px solid #e0e0e0}
			.add_bdL{border-left:1px solid #e0e0e0}
			
			div.printPageWrap{page:Section1;box-sizing:border-box;width:100%;padding:36pt 36pt 24pt}
			div.printPageWrap h4{margin:24pt 0 8pt;font-size:12pt}
			
			table.skin_basic_write{margin:0}
			tr.signatureArea td{padding:36pt 0}
			
			p.txt_footer{padding:16pt 0;border-bottom:1px solid #000;font-size:10pt}
		</style>
		
		<script type="text/javascript">
			function print_window(){
				window.print();
				setTimeout(function () { 
					window.open('', '_self', '');
					window.close();
				}, 100);
			}
		</script>
	</head>
	<body onload="print_window();">
		<div class="printPageWrap">

			<div>
				<table class="skin_basic_write bdT0 add_bdL">
					<colgroup>
						<col width="20%">
						<col width="29%">
						<col width="17%">
						<col width="17%">
						<col width="17%">
					</colgroup>
					<thead>
						<tr>
							<th>접수번호</th>
							<td class="add_bdT add_bdR txtC"></td>
							<td colspan="3"></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2" rowspan="3" class="add_bdR txtC">장비 이용 신청서</td>
							<td class="txtC add_bdR">담당</td>
							<td class="txtC add_bdR">확인</td>
							<td class="txtC add_bdR">결재</td>
						</tr>
						<tr class="signatureArea">
							<td class="add_bdR"></td>
							<td class="add_bdR"></td>
							<td class="add_bdR"></td>
						</tr>
						<tr>
							<td class="txtC add_bdR"> / </td>
							<td class="txtC add_bdR"> / </td>
							<td class="txtC add_bdR"> / </td>
						</tr>
					</tbody>
				</table>
			</div>

			<div>
				<h4>장비정보</h4>
				<table class="skin_basic_write">
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<tbody>
						<tr>
							<th>NTIS등록번호</th>
							<td><%=equRs.getString("NTIS_EQUIP_INFO").equals("") ? "NTIS 미등록 장비" : equRs.getString("NTIS_EQUIP_INFO") %></td>
						</tr>
						<tr>
							<th>JEINET 등록번호</th>
							<td><%=equRs.getString("RND_EQU_IDX") == null ? "" : equRs.getString("RND_EQU_IDX") %></td>
						</tr>
						<tr>
							<th>고정자산관리번호</th>
							<td><%=equRs.getString("FIXED_ASET_NO") == null ? "" : equRs.getString("FIXED_ASET_NO") %></td>
						</tr>
						<tr>
							<th>한글장비명</th>
							<td><%=equRs.getString("KOR_NM") == null ? "" : equRs.getString("KOR_NM") %></td>
						</tr>
						<tr>
							<th>영문장비명</th>
							<td><%=equRs.getString("ENG_NM") == null ? "" : equRs.getString("ENG_NM") %></td>
						</tr>
					</tbody>
				</table>
			</div>

			<div>
				<h4>예약정보</h4>
				<table class="skin_basic_write">
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>
					<tbody>
						<tr>
							<th>JEINET 예약번호</th>
							<td colspan="3">J-<%=equOrderIdx %></td>
						</tr>
						<tr>
							<th>예약신청일</th>
							<td><%=yeyaRs.getString("ORDER_DT") == null ? "" : yeyaRs.getString("ORDER_DT") %></td>
							<th>기관접수일</th>
							<td><%=yeyaRs.getString("ORDER_DATA") == null ? "" : yeyaRs.getString("ORDER_DATA") %></td>
						</tr>
						<tr>
							<th>의용희망기간</th>
							<td><%=yeyaRs.getString("USE_DT") == null ? "" : yeyaRs.getString("USE_DT") %></td>
							<th>이용확정기간</th>
							<td><%=yeyaRs.getString("REAL_DT") == null ? "" : yeyaRs.getString("REAL_DT") %></td>
						</tr>
						<tr>
							<th>이용자명</th>
							<td><%=yeyaRs.getString("PSN_NM") == null ? "" : yeyaRs.getString("PSN_NM") %></td>
							<th>연락처</th>
							<td><%=yeyaRs.getString("EMAIL") == null ? "" : yeyaRs.getString("EMAIL") %></td>
						</tr>
						<tr>
							<th>소속기관명</th>
							<td><%=userRs.getString("ORG_GRP_NM") == null ? "" : userRs.getString("ORG_GRP_NM") %></td>
							<th>소속부서/센터</th>
							<td><%=yeyaRs.getString("DEPT_NM") == null ? "" : yeyaRs.getString("DEPT_NM") %></td>
						</tr>
						<tr>
							<th>신청자 직위</th>
							<td><%=userRs.getString("POSITION_NM") == null ? "" : userRs.getString("POSITION_NM") %></td>
							<th>책임자</th>
							<td><%=yeyaRs.getString("CORP_RESPONSIBLE_USER") == null ? "" : yeyaRs.getString("CORP_RESPONSIBLE_USER") %></td>
						</tr>
						<tr>
							<th>장비명</th>
							<td><%=yeyaRs.getString("KOR_NM") == null ? "" : yeyaRs.getString("KOR_NM") %></td>
							<th>모델명</th>
							<td><%=yeyaRs.getString("MODEL_NM") == null ? "" : yeyaRs.getString("MODEL_NM") %></td>
						</tr>
						<tr>
							<th>시료명(시료수)</th>
							<td><%=yeyaRs.getString("SAMPLE_NM") == null ? "" : yeyaRs.getString("SAMPLE_NM") %></td>
							<th>사용구분</th>
							<td><%=yeyaRs.getString("USE_MEAN") == null ? "" : yeyaRs.getString("USE_MEAN") %></td>
						</tr>
						<tr>
							<th>이용료안내</th>
							<td colspan="3"><%=yeyaRs.getString("RENTAL_INFO") == null ? "" : yeyaRs.getString("RENTAL_INFO") %></td>
						</tr>
						<tr>
							<th>이용목적</th>
							<td colspan="3"><%=yeyaRs.getString("USE_PURPOSE") == null ? "" : yeyaRs.getString("USE_PURPOSE") %></td>
						</tr>
						<tr>
							<th>특이사항</th>
							<td colspan="3"><%=yeyaRs.getString("SAMPLE_MATTER") == null ? "" : yeyaRs.getString("SAMPLE_MATTER") %></td>
						</tr>
					</tbody>
				</table>
			</div>

			<p class="txt_footer txtC"><%=yeyaRs.getString("USE_MARK_TEXT") == null ? "" : yeyaRs.getString("USE_MARK_TEXT") %></p>
		</div>
	</body>
</html>
	<%
 				
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				//equRs.close();
				//yeyaRs.close();
				//userRs.close();
				//pstmt.close();
				conn.close();   // Connection 해제
			}

	%>