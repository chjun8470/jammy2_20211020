<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>


	<%-- <!--leftMenu S-->
	<div id="MPleftMenu">
	
		<div class="top">
		<%
		if("MOBILE".equals(device)){ //모바일
		%>
			<a href="/mjeinet/main.do" class="home">HOME</a>
		<%
		}else{ //pc
		%>
			<a href="/sso/home.do?siteId=jeinet" class="home">HOME</a>

		<%
		}
		%>

			<input type="button" class="cls" value="X"/>
		</div>
	
		<ul class="MPleftMenuList">
			<li id="MPleft01" <%if("1".equals(menu1)){%> class="on" <%} %> ><a href="/sso/mypagecon.do" title="회원가입">정보관리</a>
				<div id="MPleftSub01" <%if(!"1".equals(menu1)){%>style="display: none;"<%} %> >
					<ul>
						<li id="MPleftSubImg0101" <%if("1".equals(menu1) && "1".equals(menu2)){%> class="on" <%}%>><a href="/sso/mypagecon.do" title="정보수정">정보수정</a></li>
						<li id="MPleftSubImg0103" <%if("1".equals(menu1) && "2".equals(menu2)){%> class="on" <%}%>><a href="/sso/passChange.do" title="비밀번호변경">비밀번호변경</a></li>
						<li id="MPleftSubImg0102" <%if("1".equals(menu1) && "3".equals(menu2)){%> class="on" <%}%>><a href="/sso/leave.do" title="회원탈퇴">회원탈퇴</a></li>
						<li id="MPleftSubImg0104" <%if("1".equals(menu1) && "4".equals(menu2)){%> class="on" <%}%>><a href="/sso/agecon.do" title="기관변경">기관변경</a></li>
					</ul>
				</div>
			</li>

			<li id="MPleft02" <%if("2".equals(menu1)){%> class="on" <%} %> ><a href="/sso/equorder.do" title="장비예약">장비예약</a>
				<div id="MPleftSub02" <%if(!"2".equals(menu1)){%>style="display: none;" <%} %> >
					<ul>
						<li id="MPleftSubImg0201" <%if("2".equals(menu1) && "1".equals(menu2)){%> class="on" <%}%>><a href="/sso/equorder.do" title="예약정보">예약정보</a></li>
						<li id="MPleftSubImg0202" <%if("2".equals(menu1) && "2".equals(menu2)){%> class="on" <%}%>><a href="/sso/myfav.do" title="장바구니">장바구니</a></li>
					</ul>
				</div>
			</li>

			<li id="MPleft03" <%if("3".equals(menu1)){%> class="on" <%} %> ><a href="/sso/education.do" title="교육정보">교육정보</a>
				<div id="MPleftSub03" <%if(!"3".equals(menu1)){%>style="display: none;" <%} %> >
					<ul>
						<li id="MPleftSubImg0301" <%if("3".equals(menu1) && "1".equals(menu2)){%> class="on" <%}%>><a href="/sso/education.do" title="전체교육일정">전체교육일정</a></li>
					</ul>
				</div>
			</li>
			<li id="MPleft04" <%if("4".equals(menu1)){%> class="on" <%} %> ><a href="/sso/event.do" title="행사정보">행사정보</a>
				<div id="MPleftSub04" <%if(!"4".equals(menu1)){%>style="display: none;" <%} %> >
					<ul>
						<li id="MPleftSubImg0401" <%if("4".equals(menu1) && "1".equals(menu2)){%> class="on" <%}%>><a href="/sso/event.do" title="행사정보">행사정보</a></li>
					</ul>
				</div>
			</li>
		<%if(util.getInt(loginVO.getAuthLv()) >= 70){%>
				<li id="MPleft05" ><a href="/sso/changeboard.do" title="담당자게시판">담당자게시판</a></li>
		<%}%>
		
			<li id="MPleft06" <%if("6".equals(menu1)){%> class="on" <%} %> ><a href="/sso/advice_01.do" title="상담게시판">상담게시핀</a>
				<div id="MPleftSub06" <%if(!"6".equals(menu1)){%>style="display: none;" <%} %> >
					<ul>
						<li id="MPleftSubImg0601" <%if("6".equals(menu1) && "1".equals(menu2)){%> class="on" <%}%>><a href="/sso/advice_01.do" title="지식재산창출상담">지식재산창출상담</a></li>
						<li id="MPleftSubImg0602" <%if("6".equals(menu1) && "2".equals(menu2)){%> class="on" <%}%>><a href="/sso/advice_02.do" title="기술이전상담">기술이전상담</a></li>
						<li id="MPleftSubImg0603" <%if("6".equals(menu1) && "3".equals(menu2)){%> class="on" <%}%>><a href="/sso/advice_03.do" title="창업상담">창업상담</a></li>
						<li id="MPleftSubImg0604" <%if("6".equals(menu1) && "4".equals(menu2)){%> class="on" <%}%>><a href="/sso/advice_04.do" title="장비이용상담">장비이용상담</a></li>
						<li id="MPleftSubImg0605" <%if("6".equals(menu1) && "5".equals(menu2)){%> class="on" <%}%>><a href="/sso/advice_05.do" title="멘토상담">멘토상담</a></li>
						
					</ul>
				</div>
			</li>
		</ul>
	</div>
	<!--leftMenu E--> --%>
