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
	//ArrayList<HashMap<String, String>> listAW = request.getAttribute("listAW") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listAW");
	ArrayList<HashMap<String, String>> listQU = request.getAttribute("listQU") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listQU");
	//ArrayList<HashMap<String, String>> listEX = request.getAttribute("listEX") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEX");
	//ArrayList<HashMap<String, String>> listRE = request.getAttribute("listRE") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listRE");
	//ArrayList<HashMap<String, String>> listEV = request.getAttribute("listEV") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listEV");
	//ArrayList<HashMap<String, String>> listCO = request.getAttribute("listCO") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listCO");
	//ArrayList<HashMap<String, String>> listResultEv = request.getAttribute("listResultEv") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultEv");
	ArrayList<HashMap<String, String>> listResultCon = request.getAttribute("listResultCon") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("listResultCon");

	
	ArrayList<HashMap<String, String>> teamList = request.getAttribute("teamList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamList");
	
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
                   <col style="width:20%" />
                   <col />
                   <col style="width:20%" />
                   <col />
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

				<tr>
      	   			<th scope="row" class="tit"> 기술분류</th>
	            	<td colspan="3">
	         			<%=util.getStr(dataMap.get("PRO_SMB_CODE1_NAME")) %>						
	           		</td>

            	</tr>
			</tbody>
		</table>
		
		
		
		<h2 class="tit">소속정보</h2>
        <table class="skin_basic_write">
			<caption>소속정보</caption>
            <colgroup>
                   <col style="width:20%" />
                   <col />
                   <col style="width:20%" />
                   <col />
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
            	<col style="width:20%" />
         		<col />
         		<col style="width:20%" />
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

		<h2 class="tit">경력정보</h2>
		<table class="skin_basic_write">
			<caption>경력정보</caption>
			    <colgroup>
		            <col style="width:20%" />
	          		<col />
	         		<col style="width:20%" />
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
			<col style="width:20%" />
			<col />
			<col style="width:20%" />
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
	        <col style="width:20%" />
	        <col />
	        <col style="width:20%" />
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
     			<%=util.getStr(rs.get("TITLE_ORG"))%>
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
		<table class="skin_basic_write">
			<caption>대외활동</caption>
			    <colgroup>
	          		<col style="width:20%" />
	          		<col />
	          		<col style="width:20%" />
	          		<col />
	            </colgroup>
			<%if(listAC.size()>0){ %>
				<% for(HashMap rs:listAC) {%>
				<tr>
	         		<th scope="row" class="tit">조직(학회)명</th>
	         		<td colspan="3"><%=util.getStr(rs.get("AC_NM"))%></td>
	         	</tr>
	         	<tr>
	         		<th scope="row" class="tit">참여일</th>
	         		<td><%=util.getStr(rs.get("AC_START"))%></td>
	         		<th scope="row" class="tit">직위</th>
	         		<td><%=util.getStr(rs.get("AC_DEPT"))%></td>
	         	</tr>
	         	<tr style="border-bottom:3px solid #ddd;">
	         		<th scope="row" class="tit">주요업무</th>
	         		<!-- td><input type="text" name="acFinish" id="acFinish<%//=acCnt%>" value="<%//=util.getStr(rs.get("AC_FINISH"))%>" style="width:100%;" class="inp_txt"></td-->
	         		<td colspan="3"><%=util.getStr(rs.get("AC_WORK"))%></td>
	         	</tr>
			  <%} %>
			<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
			<%} %>
		</table>
		
		
		<!-- 자격사항 S -->
		<h2 class="tit">자격/포상</h2>
		<table class="skin_basic_write">
		<caption>자격사항</caption>
	    <colgroup>
	    	<col style="width:20%" />
	    	<col />
	    	<col style="width:20%" />
	    	<col />
	    </colgroup>
	    <%	if(listQU.size()>0){ %>
		<%		for(HashMap rs:listQU) {%>
			<tr>
	       		<th scope="row" class="tit">구분</th>
	       		<td colspan="3">
	       			<%=util.getStr(rs.get("QU_DIVIDE")) %>
	       		</td>
	       	</tr>
			<tr>
				<th scope="row" class="tit">포상/자격증명</th>   	
	       		<td><%=util.getStr(rs.get("QU_NM"))%></td>
	       		<th scope="row" class="tit">취득일자</th>
	       		<td><%=util.getStr(rs.get("QU_START"))%></td>
	       	</tr>
	       	<tr>
	       		<th scope="row" class="tit">발급기관명</th>
	       		<td colspan="3"><%=util.getStr(rs.get("QU_ORG_NM"))%></td>
	       	</tr>
	       	<tr style="border-bottom:3px solid #ddd">
	       		<th scope="row" class="tit">증빙서류</th>
	       		<td colspan="3">
	       			<%=util.getStr(rs.get("TITLE_ORG"))%>
	       		</td>
	       	</tr>
		<% 		}//for end %>
		<%	}else{//if end %>
			<tr>
				<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
			</tr>
		<%	} %>
		</table>
		<!-- 자격사항 E -->
		
		
		<h2 class="tit">연구개발과제(프로젝트) 수행실적</h2>
		<table class="skin_basic_write">
			<caption>연구개발과제(프로젝트) 수행실적</caption>
		        <colgroup>
			    	<col style="width:20%" />
			    	<col />
			    	<col style="width:20%" />
			    	<col />
			    </colgroup>
		      	
		<%if(listRD.size()>0){ %>
			<%
				for (HashMap rs : listRD) {
			%>
			  	<tr>
		     		<th scope="row" class="tit">수행실적여부</th>
		     		<td colspan="3">
		     			<%=util.getStr(rs.get("RD_TYPE")).equals("Y")?"있음":"없음"%>
		     		</td>
		     	</tr>
		     	<tr>
		     		<th scope="row" class="tit">연번</th>
		     		<td><%=util.getStr(rs.get("RD_SERIAL_NUM"))%></td>
		     		<th scope="row" class="tit">부처/기관/발주처명</th>
		     		<td><%=util.getStr(rs.get("RD_ORG_NM"))%></td>
		     	</tr>
		     	<tr>
		     		<th scope="row" class="tit">사업명</th>
		     		<td><%=util.getStr(rs.get("RD_BUSINESS_NM"))%></td>
		     		<th scope="row" class="tit">과제명</th>
		     		<td><%=util.getStr(rs.get("RD_NM"))%></td>
		     	</tr>
		     	<tr>
		     		<th scope="row" class="tit">사업시작시간</th>
		     		<td><%=util.getStr(rs.get("RD_START"))%></td>
		     		<th scope="row" class="tit">사업종료시간</th>
		     		<td>
		     			<%=util.getStr(rs.get("RD_FINISH"))%>
		     			<%=util.getStr(rs.get("RD_ING")).equals("1")?"진행중":""%>
		     		</td>
		     	</tr>
		     	<tr style='border-bottom:3px solid #ddd'>
		     		<th scope="row" class="tit">사업비</th>
		     		<td><%=util.getStr(rs.get("RD_EXPENSES"))%></td>
		     		<th scope="row" class="tit">참여형태</th>
		       		<td>
		       			<%=util.getStr(rs.get("RD_FORM"))%>
		       		</td>
				</tr>
		    <%} %>
		<%}else{%>
				<tr>
					<td  style="text-align:center;"  colspan="8">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>


		 
		<h2 class="tit">컨설팅 수행실적</h2>
		<table class="skin_basic_write">
			<caption>컨설팅 수행실적</caption>
			<colgroup>
		    	<col style="width:20%" />
		    	<col />
		    	<col style="width:20%" />
		    	<col />
		    </colgroup>
			
		 	<%if(listResultCon.size()>0){ %>
			<% for(HashMap rs:listResultCon) {%>
		    	<tr>
					<th scope="row" class="tit">컨설팅 수행실적여부</th>
					<td colspan="3">
		     			<%=util.getStr(rs.get("CON_TYPE")).equals("Y")?"있음":"없음"%>
		     		</td>
				</tr>
		    	<tr>
		 	  		<th scope="row" class="tit">컨설팅 사업명(컨설팅명)</th>
		 	  		<td>
		 	  			<%=util.getStr(rs.get("CON_NAME"))%>
		 	  		</td>
		 	  		<th scope="row" class="tit">요청기관명</th>
		 	  		<td>
		 	  			<%=util.getStr(rs.get("CON_ORG"))%>
		 	  		</td>
		 	  	</tr>
		 	  	<tr>
		 	  		<th scope="row" class="tit">컨설팅 시작시간</th>
		 	  		<td>
		 	  			<%=util.getStr(rs.get("CON_SDATE"))%>
		 	  		</td>
		 	  		<th scope="row" class="tit">컨설팅 종료시간</th>
		 	  		<td>
		 	  			<%=util.getStr(rs.get("CON_EDATE"))%>
		 	  			<%=util.getStr(rs.get("CON_ING")).equals("1")?"진행중":""%>
		 	  		</td>
		 	  	</tr>
		 	  	<tr style="border-bottom:3px solid #ddd">
		 	  		<th scope="row" class="tit">컨설팅내용</th>
		   			<td colspan="3">
		   				<%=util.getStr(rs.get("CON_CONTENT"))%>
		   			</td>
		     	</tr>
		 	<%}%>
		<%} else{%>
				<tr>
					<td  style="text-align:center;"  colspan="5">데이터가 존재하지 않습니다</td>
				</tr>
		<%} %>
		</table>
		
		<!-- 전문가분야 S -->
	
		<h2 class="tit">전문가분야</h2>
		<table class="skin_basic_write">
			<caption>전문가분야</caption>
	        <colgroup>
		        <col style="width:20%" />
		        <col />
	        </colgroup>
	        <tbody>
			<tr>
				<th scope="row" class="tit">기술사업화 코디네이터 신청</th>
				<td colspan="3">
					<input type="checkbox" name="expert_pro1" id="expert_pro1" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO1")).equals("Y"))?"checked":""%> disabled> 
					<label for="expert_pro1">
					기술사업화 코디네이터에 해당하면 선택하십시오.
					<span style="color:#e15512">* 해당 기술분야 시장성, 사업성평가 전문가(벤처캐피탈, 창업투자 등 관련분야 소속)</span>
					</label>
				</td>
			</tr>
			<tr>
				<th scope="row" class="tit">해외전문가 신청</th>
				<td colspan="3">
					<input type="checkbox" name="expert_pro2" id="expert_pro2" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO2")).equals("Y"))?"checked":""%> disabled> 
					<label for="expert_pro2">
					해외전문가에 해당하면 선택하십시오.
					<span style="color:#e15512">* 외국인, 재외한인공학인, 해외기관 근무 경력자, 해외학위 취득자 등</span>
					</label>
				</td>
			</tr>
			<tr>
				<th scope="row" class="tit">IP전문가 신청</th>
				<td colspan="3">
					<input type="checkbox" name="expert_pro3" id="expert_pro3" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO3")).equals("Y"))?"checked":""%> disabled> 
					<label for="expert_pro3">
					IP전문가에 해당하면 선택하십시오.
					<span style="color:#e15512">* 변리사, 특허분야 전문가</span>
					</label>
				</td>
			</tr>
			<tr>
				<th scope="row" class="tit">표준인증전문가 신청</th>
				<td colspan="3">
					<input type="checkbox" name="expert_pro4" id="expert_pro4" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO4")).equals("Y"))?"checked":""%> disabled> 
					<label for="expert_pro4">
					표준인증전문가에 해당하면 선택하십시오.<br>
					<span style="color:#e15512">* KS, IOS, IEC 등 국내, 국제표준화 업무 전문가(의장, 간사, PROJECT LEADER 등의 수입경력포함)<br/>
					* 표준특허전문가, 표준물질생산, 적합성평가 등 제품인증 분야 전문가, 기타 표준분야 전문가
					</span>
					</label>
				</td>
			</tr>
			<tr>
				<th scope="row" class="tit">안전전문가 신청</th>
				<td colspan="3">
					<input type="checkbox" name="expert_pro5" id="expert_pro5" value="Y" <%=(util.getStr(dataMap.get("EXPERT_PRO5")).equals("Y"))?"checked":""%> disabled> 
					<label for="expert_pro5">
					안전전문가에 해당하면 선택하십시오.<br>
					<span style="color:#e15512">* 전기, 기계, 화학, 가스 등 산업 안전분야 기사, 기술사 자격 소지자<br/>
					* 산업안전분야 관련 기업, 협회, 안전관리전문기관 등에 소속된 자<br/>
					* 소속기관에서 안전분야 관련 업무를 수행하거나 관련 지식을 보유한 자 등
					</span>
					</label>
				</td>
			</tr>
			</tbody>
		</table>
	<!-- 전문가분야 E -->
	
	<!-- 정보공개동의 S -->
	
		<h2 class="tit">정보공개동의</h2>
		<table class="skin_basic_write">
			<caption>정보공개동의</caption>
	        <colgroup>
		        <col />
	        </colgroup>
	        <tbody>
			<tr>
				<td style="text-align:right;">
					<label><input type="radio" name="expert_ok" value="Y" <%=(util.getStr(dataMap.get("EXPERT_OK")).equals("Y") || util.getStr(dataMap.get("EXPERT_OK")).equals(null))?"checked":""%> disabled> 정보제공에 동의합니다.</label>
					<label><input type="radio" name="expert_ok" value="N" <%=(util.getStr(dataMap.get("EXPERT_OK")).equals("N"))?"checked":""%> disabled> 정보제공에 동의하지 않습니다.</label>
				</td>
			</tr>
			</tbody>
		</table>
	<!-- 정보공개동의 E -->
	
	
	<!-- 개인정보이용동의 S -->
	
		<h2 class="tit">개인정보 이용 동의서</h2>
		<table class="skin_basic_write">
			<caption>개인정보 이용 동의서</caption>
	        <colgroup>
		        <col style="width:15%" />
		        <col style="width:35%" />
		        <col style="width:15%" />
		        <col style="width:35%" />
	        </colgroup>
	        <tbody>
			<tr>
				<th scope="row" class="tit"><span style="color:red;" >*</span> 동의서 파일</th>
				<td>
					<%
						if(fileList.size() > 0){
					%>
						<div id="fileDivEdit">
							<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
							<%
								int fileCnt = 1;
								for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									
							%>
								<li class="text">
									<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
								</li>
							<% fileCnt++; }%>
							</ul>
						</div>
		
		            <% } %>
		
		             	
				</td>
				<th scope="row" class="tit">동의서 상태</th>
				<td>
					미승인
				</td>
			</tr>
			<tr>
				<th scope="row" class="tit">승인일자</th>
				<td>
					-
				</td>
				<th scope="row" class="tit">만료일자</th>
				<td>
					-
				</td>
			</tr>
			</tbody>
		</table>
	<!-- 개인정보이용동의 E -->

		
		
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

window.resizeTo( "900", "620");

	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fview').submit();
	}

</script>