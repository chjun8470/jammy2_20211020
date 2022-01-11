<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");

	
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	ArrayList<HashMap<String, String>> listSC = request.getAttribute("listSC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listSC");
	ArrayList<HashMap<String, String>> listCR = request.getAttribute("listCR") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCR");
	ArrayList<HashMap<String, String>> listAC = request.getAttribute("listAC") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAC");
	ArrayList<HashMap<String, String>> listRD = request.getAttribute("listRD") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRD");
	ArrayList<HashMap<String, String>> listRP = request.getAttribute("listRP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRP");
	ArrayList<HashMap<String, String>> listIP = request.getAttribute("listIP") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listIP");
	ArrayList<HashMap<String, String>> listAW = request.getAttribute("listAW") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAW");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
	ArrayList<HashMap<String, String>> listEX = request.getAttribute("listEX") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEX");
	ArrayList<HashMap<String, String>> listRE = request.getAttribute("listRE") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRE");
	ArrayList<HashMap<String, String>> listEV = request.getAttribute("listEV") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEV");
	ArrayList<HashMap<String, String>> listCO = request.getAttribute("listCO") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCO");
	ArrayList<HashMap<String, String>> listResultEv = request.getAttribute("listResultEv") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultEv");
	ArrayList<HashMap<String, String>> listResultCon = request.getAttribute("listResultCon") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultCon");
<<<<<<< HEAD
	
	ArrayList<HashMap<String, String>> teamList = request.getAttribute("teamList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamList");
	
=======
	ArrayList<HashMap<String, String>> teamList = request.getAttribute("teamList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamList");
	

>>>>>>> parent of d943127 (211215 1001)
	String fileGrp = "expertManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String userIdx = util.getIntStr(paramMap.get("userIdx"));
	String proState = util.getStr(paramMap.get("proState"));

	LoginVO loginVO = util.getLoginInfo(request);
	


%>

<form name="fview" id="fview" action="<%=myPage%>" method="post" >
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
	<input type="hidden" name="proState" id="proState" value="<%=proState%>" />
	<input type="hidden" name="userId" id="userId" value="<%=util.getStr(dataMap.get("USER_ID"))%>" />
	<div  class="skin_bbs_write" style="margin-top: 30px">

		<h2 class="tit">기본정보</h2>
		<table class="skin_basic_write" >
			<caption>기본정보</caption>
			<colgroup>
                   <col style="width:15%" />
                   <col style="width:35%" />
                   <col style="width:15%" />
                   <col style="width:35%" />
            </colgroup>
			<thead>
			</thead>
			<tbody>
				<tr>
					<th scope="row" class="tit">이름</th>
			  		<td><%=util.getStr(dataMap.get("PSN_NM")) %></td>
		     		<th scope="row" class="tit">성별</th>
		     		<td><input type="text" name="GenderTypeCd" id="GenderTypeCd"  <%=(util.getStr(dataMap.get("GENDER_TYPE_CD"))).equals("M")? "value='남자'" : "value='여자'" %> style="border:0px;"  readonly  maxlength="20"></td>
		     	</tr>
		        <tr>
		    		<th scope="row" class="tit">출생년도</th>
		    		<td><% if(util.getStr(dataMap.get("BIRTH_DATE")).length() > 4){ out.println( util.getStr(dataMap.get("BIRTH_DATE")).substring(0,4) );  }else{ out.println( util.getStr(dataMap.get("BIRTH_DATE")) ); } %></td>
		       		<th scope="row" class="tit">email</th>
		        	<td><%=util.getStr(dataMap.get("EMAIL")) %></td>
		        </tr>
				<tr>
		       		<th scope="row" class="tit">출생지역</th>
		       		<td colspan="3">
		       			<%=util.getStr(dataMap.get("PRO_USER_AREA")).equals("1")?"전라남도":""%>
		       			<%=util.getStr(dataMap.get("PRO_USER_BIRTHPLACE"))%>
		       		</td>
		        </tr>
		    	<tr>
		    		<th scope="row" class="tit">전화번호</th>
		    		<td><%=util.getStr(dataMap.get("TEL_NO")) %></td>
		 			<th scope="row" class="tit">휴대전화</th>
		    		<td><%=util.getStr(dataMap.get("CP_NO")) %></td>
				</tr>
				<tr>
					<th scope="row" class="tit">전문가 구분</th>
			         <td  colspan="4">
						정책기획 <input type="checkbox" name="proJntisPlanning" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_PLANNING"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						연구개발 <input type="checkbox" name="proJntisRnd" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_RND"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						기업지원 <input type="checkbox" name="proJntisCompany" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_COMPANY"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						연구장비 <input type="checkbox" name="proJeinet" value="Y" <%=(util.getStr(dataMap.get("PRO_JEINET"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						지식재산 <input type="checkbox" name="proJipbank" value="Y" <%=(util.getStr(dataMap.get("PRO_JIPBANK"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						인력양성 <input type="checkbox" name="proJntisEducation" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_EDUCATION"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						컨설팅 <input type="checkbox" name="proJntisConsulting" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_CONSULTING"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						마케팅 <input type="checkbox" name="proJntisMarketing" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_MARKETING"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
						기타 <input type="checkbox" name="proJntisEtc" value="Y" <%=(util.getStr(dataMap.get("PRO_JNTIS_ETC"))).equals("Y")? "checked='checked'" : "" %> disabled='disabled' />&nbsp;&nbsp;
					</td>
				</tr>
<<<<<<< HEAD

				<tr>
      	   			<th scope="row" class="tit"> 기술분류</th>
	            	<td colspan="3">
	         			<%=util.getStr(dataMap.get("PRO_SMB_CODE1_NAME")) %>						
	           		</td>

=======
				<tr>
      	   			<th scope="row" class="tit"><span style="color:red;" >*</span> 소속기관유형</th>
            		<td colspan="3">
					<% 
					int teamCnt = 1; 
					for(HashMap te:teamList){ %>
						<%=util.getStr(te.get("CODE_NM"))%> <input type="checkbox" name="team_<%=util.getStr(te.get("CODE_CD"))%>" <%=(util.getStr(dataMap.get("PRO_SMB_TEAM"+teamCnt))).equals("Y")? "checked='checked'" : "" %>  disabled='disabled' value="Y" />
					<% teamCnt++; } %>	
					</td>
            	</tr>
            	<tr>
            		<th scope="row" class="tit">관심분야</th>
            		<td colspan="4">
						<%=util.getStr(dataMap.get("PRO_USER_INTEREST_WORLD"))%>
					</td>
>>>>>>> parent of d943127 (211215 1001)
            	</tr>
			</tbody>
		</table>
		
		
		
		<h2 class="tit">소속정보</h2>
        <table class="skin_basic_write">
			<caption>소속정보</caption>
            <colgroup>
                   <col style="width:15%">
                   <col style="width:35%">
                   <col style="width:15%">
                   <col style="width:35%">
            </colgroup>
            <tbody>
        	<tr>
        		<th scope="row" class="tit"> 소속기관명</th>
        		<td colspan="3"><%=(util.getStr(dataMap.get("COM_NM")))%></td>
        	</tr>
        	<tr>
  	   			<th scope="row" class="tit"> 소속기관유형</th>
        		<td colspan="3">
				<% 
				int teamCnt = 1; 
				for(HashMap te:teamList){ %>
					<%=util.getStr(te.get("CODE_NM"))%> <input type="checkbox" name="team_<%=util.getStr(te.get("CODE_CD"))%>" <%=(util.getStr(dataMap.get("PRO_SMB_TEAM"+teamCnt))).equals("Y")? "checked='checked'" : "" %> value="Y"  disabled='disabled' />
				<% teamCnt++; } %>	
				</td>
        	</tr>
        	<tr>
           		<th scope="row" class="tit"><span style="color:red;">*</span> 부서</th>
           		<td>
           			<%=(util.getStr(dataMap.get("DEPT_NM")))%>
           		</td>
           		<th scope="row" class="tit"><span style="color:red;">*</span> 직위</th>
           		<td>
           			<%=(util.getStr(dataMap.get("POSITION_NM")))%>                           			
           		</td>
           	</tr>
            <tr>
        		<th scope="row" class="tit"> 회사주소</th>
        		<td colspan="3">
        			<%=(util.getStr(dataMap.get("COM_ADDR1")))%> <%=(util.getStr(dataMap.get("COM_ADDR2")))%>
        		</td>
        	</tr>
        	<tr>
        		<th scope="row" class="tit"> 대표번호</th>
        		<td colspan="3">
        		<%=util.getStr(dataMap.get("COM_TEL"))%>
        		</td>
        	</tr>
        	</tbody>
		</table>
		
		
		
		
		<h2 class="tit">학력정보</h2>
		<table class="skin_basic_write">
			<caption>학력정보</caption>
		    <colgroup>
            	<col style="width:15%" />
         		<col />
         		<col style="width:15%" />
         		<col />
            </colgroup>
			<%if(listSC.size()>0){ %>
			   	
				<% for(HashMap rs:listSC) {%>
			   	<tr>
	            	<th scope="row" class="tit">학교명</th>
	          		<td><%=util.getStr(rs.get("SC_NM"))%></td>
	          		<th scope="row" class="tit">전공</th>
	          		<td>
	          			<%=util.getStr(rs.get("SC_CONAME"))%>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit">교육시작일</th>
	          		<td><%=util.getStr(rs.get("SC_START"))%></td>
	          		<th scope="row" class="tit">교육종료일</th>
	          		<td>
	          			<%=util.getStr(rs.get("SC_FINISH"))%>
	          		</td>
	          	</tr>
	          	<tr>
	          		<th scope="row" class="tit">취득학위</th>
	          		<td>
	          			<%=util.getStr(rs.get("SC_DEGREE"))%>
	          		</td>
	          		<th scope="row" class="tit">학위취득일자</th>
	          		<td><%=util.getStr(rs.get("SC_DATE"))%></td>
	          	</tr>
	          	<tr style="border-bottom:3px solid #ddd;">
	          		<th scope="row" class="tit">증빙문서</th>
	          		<td colspan="3">
	          			<%=util.getStr(rs.get("TITLE_ORG"))%>
	          		</td>
	          	</tr>
				<%} %>
			<%} %>
		</table>
<<<<<<< HEAD
		
		
=======
		<h3>○ 전공분야</h3>
		<table class="skin_basic_write textCenter">
			<caption>전문분야</caption>
			<colgroup>
			  <col style="width:15%" />
			  <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
		      <col style="width:15%" />
		      <col style="width:18%" />
			</colgroup>

		<%if(listEX.isEmpty()){ %>
			
			<tr>
				<th scope="row" class="tit" >전공계열1</th>
				<td ></td>
				<th scope="row" class="tit">전공분야</th>
				<td></td>
				<th scope="row" class="tit">세부전공</th>
				<td></td>
			</tr>
			<tr>
				<th scope="row" class="tit">복수전공계열</th>
				<td></td>
				<th scope="row" class="tit">전공분야</th>
				<td></td>
				<th scope="row" class="tit">세부전공</th>
				<td></td>
			</tr>
			
			
		<%
			
		} else{%>
			
			<% for(HashMap rs:listEX) {
				
			%>
			<tr>
				<th scope="row" class="tit" >전공계열</th>
				<td ><% if(rs != null) out.println(util.getStr(rs.get("EX_MAJOR_NAME"))); %></td>
				<th scope="row" class="tit">전공분야</th>
				<td><% if(rs != null) out.println(util.getStr(rs.get("EX_REALM_NAME"))); %></td>
				<th scope="row" class="tit">세부전공</th>
				<td><% if(rs != null) out.println(util.getStr(rs.get("EX_DETAIL_NAME")));%></td>
			</tr>
			<tr>
				<th scope="row" class="tit">복수전공계열</th>
				<td><% if(rs != null) out.println(util.getStr(rs.get("EX_MAJOR_PLURAL_NAME"))); %></td>
				<th scope="row" class="tit">전공분야</th>
				<td><% if(rs != null) out.println(util.getStr(rs.get("EX_REALM_PLURAL_NAME"))); %></td>
				<th scope="row" class="tit">세부전공</th>
				<td><% if(rs != null) out.println(util.getStr(rs.get("EX_DETAIL_PLURAL_NAME"))); %></td>
			</tr>
			
		<%	} 
		}
		%>
		</table>
>>>>>>> parent of d943127 (211215 1001)
		<h2 class="tit">경력정보</h2>
		<table class="skin_basic_write">
			<caption>경력정보</caption>
			    <colgroup>
		            <col style="width:15%" />
	          		<col />
	         		<col style="width:15%" />
	         		<col />
	            </colgroup>
			<%if(listCR.size()>0){ %>
				<% for(HashMap rs:listCR) {%>
				<tr>
	        		<th scope="row" class="tit">근무처</th>
					<td><%=util.getStr(rs.get("CR_NM"))%></td>
					<th scope="row" class="tit">최종직위</th>
					<td><%=util.getStr(rs.get("CR_DEPT"))%></td>
				</tr>
				<tr>
					<th scope="row" class="tit"> 근무시작일</th>
					<td>
						<%=util.getStr(rs.get("CR_START"))%>
					</td>
					<th scope="row" class="tit"> 근무종료일</th>
					<td>
						<%=util.getStr(rs.get("CR_FINISH"))%>
						<%=util.getStr(rs.get("CR_ING")).equals("1")?"재직중":""%>					
					</td>
				</tr>
				<tr class="career_info ">
					<th scope="row" class="tit"> 주요업무</th>
					<td colspan="3"><%=util.getStr(rs.get("CR_WORK"))%></td>
	            </tr>
	            <tr class="career_info " style='border-bottom:3px solid #ddd'>
					<th scope="row" class="tit"> 증빙문서</th>
					<td colspan="3">
						<%=util.getStr(rs.get("TITLE_ORG"))%>
					</td>
	            </tr>
				<%} %>
			<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="6">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		
		<h2 class="tit">연구논문 실적</h2>
		<table class="skin_basic_write" >
		<caption>연구논문 실적</caption>
		<colgroup>
			<col style="width:15%" />
			<col />
			<col style="width:15%" />
			<col />
		</colgroup>
		<table class="skin_basic_write" >
		<%if(listRP.size()>0){ %>
		<% for(HashMap rs:listRP) {%>
     	<tr>
     		<th scope="row" class="tit">논문명</th>
     		<td><%=util.getStr(rs.get("RP_NM"))%></td>
     		<th scope="row" class="tit">게제년도</th>
     		<td><%=util.getStr(rs.get("RP_START"))%></td>
     	</tr>
     	<tr>
     		<th scope="row" class="tit">학술지명</th>
     		<td><%=util.getStr(rs.get("RP_JOURNAL_NM"))%></td>
     		<th scope="row" class="tit">SCI 논문여부구분</th>
     		<td>
				<%=util.getStr(rs.get("RP_TYPE"))%>
     		</td>
		</tr>
		<tr style='border-bottom:3px solid #ddd'>
			<th scope="row" class="tit">증빙문서</th>
			<td colspan="3">
				<%=util.getStr(rs.get("TITLE_ORG"))%>
			</td>
         </tr>
		
		<%} %>
		<%} else{%>
		<tr>
			<td  style="text-align:center;"  colspan="6">데이터가 존재하지 않습니다</td>
		</tr>
		<%} %>
		</table>
		
		
		<h2 class="tit">지식재산 실적</h2>
		<table class="skin_basic_write">
		<caption>지식재산 실적</caption>
        <colgroup>
	        <col style="width:15%" />
	        <col />
	        <col style="width:15%" />
	       	<col />
        </colgroup>
        <%if(listIP.size()>0){ %>
		<% for(HashMap rs:listIP) {%>
     	<tr>
     		<th scope="row" class="tit">지식재산명</th>
     		<td><%=util.getStr(rs.get("IP_NM"))%></td>
     		<th scope="row" class="tit">지식재산유형</th>
     		<td>
				
     		</td>
     	</tr>
     	<tr>
     		<th scope="row" class="tit">출원등록구분</th>
     		<td><%=util.getStr(rs.get("IP_STATE")) %></td>
     		<th scope="row" class="tit">출원등록일자</th>
     		<td><%=util.getStr(rs.get("IP_START"))%></td>
     	</tr>
     	<tr>
     		<th scope="row" class="tit">인증/발행처</th>
     		<td colspan="3"><%=util.getStr(rs.get("IP_PUBLICATION"))%></td>
		</tr>
		<tr style="border-bottom:3px solid #ddd;">
     		<th scope="row" class="tit">증빙문서</th>
     		<td colspan="3">
     			
     		</td>
		</tr>
		<% }
		}else{ %>
		<tr>
			<td  style="text-align:center;"  colspan="6">데이터가 존재하지 않습니다</td>
		</tr>
		<%} %>
        </table>
		
		<h2 class="tit">대외활동</h2>
		<table class="skin_basic_write textCenter">
			<caption>대외활동</caption>
			    <colgroup>
			          <col style="width:30%" />
			          <col style="width:10%" />
			          <col style="width:10%" />
			          <col style="width:20%" />
			          <col style="width:30%" />
			    </colgroup>
				<tr>
					<th scope="row" class="tit">조직(학회)명</th>
					<th scope="row" class="tit" colspan="2">기간</th>
					<th scope="row" class="tit">직위</th>
					<th scope="row" class="tit">주요업무</th>
				</tr>
			<%if(listAC.size()>0){ %>
				<% for(HashMap rs:listAC) {%>
				<tr>
					<td><%=util.getStr(rs.get("AC_NM"))%></td>
					<td><%=util.getStr(rs.get("AC_START"))%></td>
					<td><%=util.getStr(rs.get("AC_FINISH"))%></td>
					<td><%=util.getStr(rs.get("AC_DEPT"))%></td>
					<td><%=util.getStr(rs.get("AC_WORK"))%></td>
				</tr>
			  <%} %>
			<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		<h2 class="tit">연구개발과제(프로젝트) 수행실적</h2>
		<table class="skin_basic_write textCenter">
			<caption>연구개발과제(프로젝트) 수행실적</caption>
		        <colgroup>
		              <col style="width:10%" />
		              <col style="width:15%" />
		              <col style="width:15%" />
		              <col style="width:15%" />
		              <col style="width:10%" />
		              <col style="width:10%" />
		              <col style="width:10%" />
		              <col style="width:15%" />
		        </colgroup>
		      	<tr>
					<th scope="row" class="tit">연번</th>
					<th scope="row" class="tit">부처/기관/발주처명</th>
					<th scope="row" class="tit">사업명</th>
					<th scope="row" class="tit">과제명</th>
					<th scope="row" class="tit" colspan="2">총사업참여기간</th>
					<th scope="row" class="tit">사업비</th>
					<th scope="row" class="tit">참여형태</th>
				</tr>

		<%if(listRD.size()>0){ %>
			<%
				for (HashMap rs : listRD) {
			%>
			  	<tr>
			  		<td><%=util.getStr(rs.get("RD_SERIAL_NUM"))%></td>
			  		<td><%=util.getStr(rs.get("RD_ORG_NM"))%></td>
			  		<td><%=util.getStr(rs.get("RD_BUSINESS_NM"))%></td>
			  		<td><%=util.getStr(rs.get("RD_NM"))%></td>
			  		<td><%=util.getStr(rs.get("RD_START"))%></td>
			  		<td><%=util.getStr(rs.get("RD_FINISH"))%></td>
			  		<td><%=util.getStr(rs.get("RD_EXPENSES"))%></td>
			  		<td><%=util.getStr(rs.get("RD_FORM"))%></td>
			  	</tr>
		    <%} %>
		<%}else{%>
				<tr>
					<td  style="text-align:center;"  colspan="8">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>



		<h2 class="tit">외부평가 수행실적</h2>
		<table class="skin_basic_write textCenter">
			<caption>외부평가 수행실적</caption>
			 <colgroup>
	        	<col style="width:30%" />
			    <col style="width:20%" />
			    <col style="width:10%" />
			    <col style="width:10%" />
			    <col style="width:30%" />
        	</colgroup>
		   	<tr>
		 		<th scope="row" class="tit">평가대상 사업명(평가명)</th>
		 		<th scope="row" class="tit">요청기관명</th>
		 		<th scope="row" class="tit" colspan="2">평가기간</th>
		 		<th scope="row" class="tit">평가내용</th>
	 		</tr>
		 	<%
			if (listResultEv.size() > 0) {
			%>
			<% for(HashMap rs:listResultEv) {%>
		   	<tr>
		  		<td><%=util.getStr(rs.get("EV_NAME"))%></td>
		  		<td><%=util.getStr(rs.get("EV_ORG"))%></td>
		  		<td><%=util.getStr(rs.get("EV_SDATE"))%></td>
		  		<td><%=util.getStr(rs.get("EV_EDATE"))%></td>
		  		<td><%=util.getStr(rs.get("EV_CONTENT"))%></td>
		   	</tr>
		   	<%}%>
		<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		<h2 class="tit">컨설팅 수행실적</h2>
		<table class="skin_basic_write textCenter">
			<caption>컨설팅 수행실적</caption>
			<colgroup>
	        	<col style="width:30%" />
			    <col style="width:20%" />
			    <col style="width:10%" />
			    <col style="width:10%" />
			    <col style="width:30%" />
	        </colgroup>
			<tr>
		 		<th scope="row" class="tit">컨설팅 사업명(컨설팅명)</th>
		 		<th scope="row" class="tit">요청기관명</th>
		 		<th scope="row" class="tit" colspan="2">컨설팅기간</th>
		 		<th scope="row" class="tit">컨설팅내용</th>
		 	</tr>
		 	<%if(listResultCon.size()>0){ %>
			<% for(HashMap rs:listResultCon) {%>
		    	<tr>
		 	  		<td><%=util.getStr(rs.get("CON_NAME"))%></td>
			  		<td><%=util.getStr(rs.get("CON_ORG"))%></td>
			  		<td><%=util.getStr(rs.get("CON_SDATE"))%></td>
			  		<td><%=util.getStr(rs.get("CON_EDATE"))%></td>
			  		<td><%=util.getStr(rs.get("CON_CONTENT"))%></td>
			 	  	</tr>
		 	<%}%>
		<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>

		<!-- 연구논문 실적 S -->
		<h2 class="tit">연구논문 실적</h2>
		<table class="skin_basic_write textCenter" >
			<caption>연구논문 실적</caption>
		       <colgroup>
		        <col style="width:10%" />
		        <col style="width:34%" />
		        <col style="width:23%" />
		        <col style="width:23%" />
		       	<col style="width:10%" />
		       </colgroup>
			   	<tr>
					<th scope="row" class="tit">연번</th>
					<th scope="row" class="tit">논문명</th>
					<th scope="row" class="tit">논문유형</th>
					<th scope="row" class="tit">학술지명</th>
					<th scope="row" class="tit">게제년도</th>
				</tr>
		<%if(listRP.size()>0){ %>
			<%
				for (HashMap rs : listRP) {
			%>
		    	<tr>
		    		<td><%=util.getStr(rs.get("RP_SERIAL_NUM"))%></td>
		    		<td><%=util.getStr(rs.get("RP_NM"))%></td>
		    		<td><%=util.getStr(rs.get("RP_TYPE"))%></td>
		    		<td><%=util.getStr(rs.get("RP_JOURNAL_NM"))%></td>
		    		<td><%=util.getStr(rs.get("RP_START"))%></td>
				</tr>
		<%} %>
		<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		<!-- 연구논문 실적 E -->
		<!-- 지식재산 실적 S -->
		<h2 class="tit">지식재산 실적</h2>
		<table class="skin_basic_write textCenter">
			<caption>지식재산 실적</caption>
		        <colgroup>
			        <col style="width:10%" />
			        <col style="width:34%" />
			        <col style="width:23%" />
			        <col style="width:23%" />
			       	<col style="width:10%" />
		        </colgroup>
			   	<tr>
					<th scope="row" class="tit">연번</th>
					<th scope="row" class="tit">지식재산명</th>
					<th scope="row" class="tit">지식재산유형</th>
					<th scope="row" class="tit">인증/발행처</th>
					<th scope="row" class="tit">등록년도</th>
				</tr>
		<%if(listIP.size()>0){ %>
		     	<%
		     		for (HashMap rs : listIP) {
		     	%>
		     	<tr>
		     		<td><%=util.getStr(rs.get("IP_SERIAL_NUM"))%></td>
		     		<td><%=util.getStr(rs.get("IP_NM"))%></td>
		     		<td><%=util.getStr(rs.get("IP_TYPE"))%></td>
		     		<td><%=util.getStr(rs.get("IP_PUBLICATION"))%></td>
		     		<td><%=util.getStr(rs.get("RP_START"))%></td>
				</tr>
				<%} %>
		<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		<!-- 지식재산 실적 E -->
		<!-- 수상 실적 S -->
		<h2 class="tit">수상실적</h2>
		<table class="skin_basic_write textCenter">
			<caption>수상 실적</caption>
		        <colgroup>
			        <col style="width:10%" />
			        <col style="width:23%" />
			        <col style="width:10%" />
			        <col style="width:23%" />
			       	<col style="width:34%" />
		        </colgroup>
			   	<tr>
					<th scope="row" class="tit">연번</th>
					<th scope="row" class="tit">훈격</th>
					<th scope="row" class="tit">수여일자</th>
					<th scope="row" class="tit">수여기관</th>
					<th scope="row" class="tit">공적내용</th>

				</tr>
		<%if(listAW.size()>0){ %>
		     	<%
		     		for (HashMap rs : listAW) {
		     	%>
		     	<tr>
		     		<td><%=util.getStr(rs.get("AW_SERIAL_NUM"))%></td>
		     		<td><%=util.getStr(rs.get("AW_BADGE"))%></td>
		     		<td><%=util.getStr(rs.get("AW_START"))%></td>
		     		<td><%=util.getStr(rs.get("AW_PRESENT"))%></td>
		     		<td><%=util.getStr(rs.get("AW_CONTENT"))%></td>
				</tr>
				<%} %>
			<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		<!-- 수상 실적 E -->
		<h2 class="tit">자격사항</h2>
		<table class="skin_basic_write textCenter">
			<caption>자격사항</caption>
		    <colgroup>
				<col style="width:10%" />
		        <col style="width:10%" />
		        <col style="width:23%" />
		        <col style="width:23%" />
		       	<col style="width:34%" />
			</colgroup>
			<tr>
				<th scope="row" class="tit">연번</th>
				<th scope="row" class="tit">취득일</th>
				<th scope="row" class="tit">발급기관명</th>
				<th scope="row" class="tit">자격구분</th>
				<th scope="row" class="tit">자격명</th>
			</tr>

		<%if(listQU.size()>0){ %>
	               <%
	               	for (HashMap rs : listQU) {
	               %>
			<tr>
				<td><%=util.getStr(rs.get("QU_SERIAL_NUM"))%></td>
	                  		<td><%=util.getStr(rs.get("QU_START"))%></td>
	                  		<td><%=util.getStr(rs.get("QU_ORG_NM"))%></td>
	                  		<td><%=util.getStr(rs.get("QU_DIVIDE"))%></td>
	                  		<td><%=util.getStr(rs.get("QU_NM"))%></td>
	                  	</tr>
	                <%} %>
	         <%} else{%>
				<tr>
					<td style="text-align:center;" colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		<div class="btn_box">
			<%if(util.loginCheck()){ %>
				<%if((util.getStr(dataMap.get("PRO_STATE"))).equals("요청")){%>
				<div>
					<input type="button" class="btn_inp_b_01" value="승인" onclick="goSubmit('20')"/>
					<input type="button" class="btn_inp_b_01" value="반려" onclick="goSubmit('30')"/>
				</div>
				<%}%>
			<%} %>
				<div class="btn_right_box">
			<%if(util.loginCheck()){ %>
					<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('edit')"/>
				<% if(!util.getStr(paramMap.get("xt")).equals("1")){ %>
					<input type="button" class="btn_inp_b_01" value="삭제" onclick="goSubmit('del')"/>
				<% } %>
			<%} %>
				<% if(!util.getStr(paramMap.get("xt")).equals("1")){ %>
					<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
				<% }else{ %>
					<input type="button" class="btn_inp_w_01" value="이전" onclick="history.go(-1)"/>
				<% } %>
				</div>
		</div>
	</div>
</form>


<script type="text/javascript">

window.resizeTo( "850", "620");

	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fview').submit();
	}

</script>