<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> supportTypeList = request.getAttribute("supportTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportTypeList");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분
	
	
	
	System.out.println("siteId:::::::::::::::"+siteId);

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
	</script>
<%
		return;
	}
%>

<div class="skin_list">
     <div>
		<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
            <input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
            <input type="hidden" name="mode" id="mode" value="<%=mode%>" />
            <input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
            <input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
            <input type="hidden" name="m" id="m" value="<%=m%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />



     	    <div class="basic_grid basic_grid2">
     	    <%if(siteId.equals("jntis")){ %>
               	<h4 style="">지원유형 </h4>
             		<div class="search_box" style="">
                    	<div class="board-search" style="line-height:25px;">

                        	<div style="position:relative;">
						    	<%
									int cnt = 1;
									for(HashMap rs:supportTypeList) {

										String ckChecked = "NO";
										if(request.getParameterValues("searchSupportType[]") != null){
											String[] ckTp = request.getParameterValues("searchSupportType[]");

											for(int i =0;  i < ckTp.length ; i++){
												if(util.getStr(rs.get("CODE_CD")).equals(ckTp[i])){
													ckChecked = "YES";
												}
											}
										}

								%>
								<span style="float:left; padding:0px 5px;"><input type="checkbox" name="searchSupportType[]" id="sstp<%=cnt%>" value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if("YES".equals(ckChecked)) {%> checked="checked" <%}%>/>
									  <label for="sstp<%=cnt%>"><%=util.getStr(rs.get("CODE_NM"))%></label>
								</span>
								<%
									cnt++;
									}
								%>
							</div>

                            <div style="position:relative;clear:both;">
	                            <label  for="searchReceipt" ></label>
								<!-- 검색필드 -->
	                            <label class="hide" for="searchType"></label>

                            </div>
                        </div>
                        <!-- board-search e -->
                     </div>
                     <!-- search_box e -->

					
					<%} %>

        			 <div class="list_top_1 margin_left_20px">
                     	<div class="b_srchBox_1 ">
                        	<div class="b_srchBox_1_du">접수상태 :&nbsp;</div>
                                <select class="b_select_1" name="searchReceipt" id="searchReceipt">
                                	<option value="">전체</option>
                                    <option value="접수전" <%if("접수전".equals(util.getStr(paramMap.get("searchReceipt")))) {%> selected="selected" <%}%>>접수전</option>
                                    <option value="접수중" <%if("접수중".equals(util.getStr(paramMap.get("searchReceipt")))) {%> selected="selected" <%}%>>접수중</option>
                                    <option value="접수마감" <%if("접수마감".equals(util.getStr(paramMap.get("searchReceipt")))) {%> selected="selected" <%}%>>접수마감</option>
                                </select>
                            </div>
					 </div>


					 <div class="list_top_1">
                     	<div class="b_srchBox_1" style="width: auto;">

							<div style="margin: 0px 0px 0px 20px; height: 35px; line-height: 35px; float: left;">검색필드 :&nbsp;</div>
							<select class="b_select_1" name="searchType" id="searchType">
                            	<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>사업명</option>
                                <option value="PROCHARGE" <%if("PROCHARGE".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>사업담당자</option>
                            </select>

                            <div class="b_srch">
                            	<input type="text" name="searchWord" title="검색단어입력" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:97%;"/>
                            </div>
							<!-- 검색버튼 -->
							<div class="b_srch_dn">
                            	<input class="b_go_btn" onclick="goSubmit('list')" type="button"  value="검색" />
                            </div>
                     	</div>
                     </div>
              </div>
              <!-- basic_grid basic_grid2 e -->

		</form>
        <!-- searchForm e -->


		<!--list_top S-->
		<div class="list_top">
			<div class="board_count">
				전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
			</div>
		</div>
		<!--list_top E-->


		<!-- skin_basic_list s -->
		<table class="skin_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 14%;" />
				<col style="width: 24%;" />
				<col style="width: 12%;" />				
				<col style="width: 15%;" />
				<col style="width: 10%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col" class="number">번호</th>
					<th scope="col" class="r_line_none2">지원유형</th>
					<th scope="col" class="r_line_none2">사업명</th>
					<th scope="col" class="r_line_none2">공고/접수기간</th>					
					<th scope="col" class="r_line_none2">사업담당자</th>
					<th scope="col" class="r_line_none file">접수상태</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					if(dataList.size() == 0){
				%>
					<tr><td class="r_line_none" colspan="7">데이터가 존재하지 않습니다</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				<tr>
					<td class="number "><%=cont%></td>
					<td class="r_line_none2">
						<%if(util.getStr(rs.get("CODE_NM")).length()>8){%><%=util.getStr(rs.get("CODE_NM")).substring(0, 8)+" · · · "%><%}else{%><%=util.getStr(rs.get("CODE_NM"))%><%}%>
					</td>
					<td class="b_notice line_new_lft">
					 	<a href="/<%=siteId%>/sub.do?m=<%=m%>&mode=view&boardIdx=<%=util.getStr(rs.get("ARTICLE_ID"))%>",'eventpopup">
							<u><%if(util.getStr(rs.get("SUBJECT")).length()>15){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 15).replaceAll("&", "&#38;")+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%></u>
						</a>

					</td>
					<td class="r_line_none2">
						<%=util.getStr(rs.get("DATA03"))%>&nbsp;~<br />
						<%=util.getStr(rs.get("DATA04"))%>
					</td>
					
					<td class="r_line_none2">
						<%if(util.getStr(rs.get("DATA09")).length()>8){%><%=util.getStr(rs.get("DATA09")).substring(0, 8)+" · · · "%><%}else{%><%=util.getStr(rs.get("DATA09"))%><%}%>
					</td>
					<td class="r_line_none file">
						<% if("접수중".equals(util.getStr(rs.get("RECEIPT_NM")))){ %>
						<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("접수전".equals(util.getStr(rs.get("RECEIPT_NM")))){ %>
						<img alt="접수전" src="/img/back/comm/edu_state_img_02.png" />
						<% }else{%>
						<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
						<% }%>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>

		<div class="b_btn_area">
			&nbsp;
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
				<input type="button" class="btn_rgt" value="글쓰기" onclick="goSubmit('write')"/>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">

	function goSubmit(mode,boardIdx){
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
	
	
	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});

	function winResize(){
		var win_w = $(window).width();
		
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
			if($('.skin_list colgroup col').size()<=4){
				$('.skin_list').find('col:eq(2)').after("<col style='width: 12%'>");
				$('.skin_list').find('col:eq(3)').after("<col style='width: 15%'>");
				$('.skin_list').find('col:eq(4)').after("<col style='width: 15%'>");
			}
			$('.skin_list tr').find('th:eq(3)').show();
			$('.skin_list tr').find('th:eq(4)').show();
			$('.skin_list tr').find('th:eq(5)').show();
			$('.skin_list tr').find('td:eq(3)').show();
			$('.skin_list tr').find('td:eq(4)').show();
			$('.skin_list tr').find('td:eq(5)').show();
			
			
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			if($('.skin_list colgroup col').size()>=7){
				$('.skin_list').find('col:eq(3)').remove();
				$('.skin_list').find('col:eq(3)').remove();
				$('.skin_list').find('col:eq(3)').remove();
			}
			$('.skin_list tr').find('td:eq(3)').hide();
			$('.skin_list tr').find('td:eq(4)').hide();
			$('.skin_list tr').find('td:eq(5)').hide();
			$('.skin_list tr').find('th:eq(3)').hide();
			$('.skin_list tr').find('th:eq(4)').hide();
			$('.skin_list tr').find('th:eq(5)').hide();
			
		}else{ //기본사이즈
			//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //네번째 td 없애기
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			
		}
		
	}
</script>
