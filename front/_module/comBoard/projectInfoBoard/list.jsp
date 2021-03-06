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
	String siteId = util.getStr(paramMap.get("siteId")); //???????????????
		

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
	//<![CDATA[
		alert("????????? ???????????????.");
		history.back(-1); //??????????????????
	//]]>	
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
               	<h4 style="">???????????? </h4>
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
								<span style="float:left; padding:0px 5px;">
									<input type="checkbox" name="searchSupportType[]" id="sstp<%=cnt%>" value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if("YES".equals(ckChecked)) {%> checked="checked" <%}%>/>
									<label for="sstp<%=cnt%>"><%=util.getStr(rs.get("CODE_NM")).replaceAll("&amp;","&").replaceAll("&","&amp;")%></label>
								</span>
								<%
									cnt++;
									}
								%>
							</div>

                            <div style="position:relative;clear:both;">
	                            <label  for="searchReceipt" ></label>
								<!-- ???????????? -->
	                            <label class="hide" for="searchType"></label>

                            </div>
                        </div>
                        <!-- board-search e -->
                     </div>
                     <!-- search_box e -->

					
					<%} %>

        			 <div class="list_top_1 margin_left_20px">
                     	<div class="b_srchBox_1 ">
                        	<div class="b_srchBox_1_du"><label for="searchReceipt">???????????? :&nbsp;</label></div>
                                <select class="b_select_1" name="searchReceipt" id="searchReceipt" title="???????????? ??????">
                                	<option value="" selected="selected">??????</option>
                                    <option value="?????????" <%if("?????????".equals(util.getStr(paramMap.get("searchReceipt")))) {%> <%}%>>?????????</option>
                                    <option value="?????????" <%if("?????????".equals(util.getStr(paramMap.get("searchReceipt")))) {%> <%}%>>?????????</option>
                                    <option value="????????????" <%if("????????????".equals(util.getStr(paramMap.get("searchReceipt")))) {%> <%}%>>????????????</option>
                                </select>
                            </div>
					 </div>


					 <div class="list_top_1">
                     	<div class="b_srchBox_1" style="width: auto; float:none">

							<div style="margin: 0px 0px 0px 20px; height: 35px; line-height: 35px; float: left;"><label for="searchType">???????????? :&nbsp;</label></div>
							<select class="b_select_1" name="searchType" id="searchType" title="???????????? ??????">
                            	<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
                                <option value="COMPNAME" <%if("COMPNAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>???????????????</option>
                                <option value="PROCHARGE" <%if("PROCHARGE".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>???????????????</option>
                            </select>

                            <div class="b_srch">
                                <label class="hide" for="searchWord">???????????? ???????????????</label>
                            	<input type="text" name="searchWord" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:97%;"/>
                            </div>
							<!-- ???????????? -->
							<div class="b_srch_dn">
                            	<input class="b_go_btn" onclick="goSubmit('list')" type="button"  value="??????" />
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
				?????? <span class="blue1"><%=staticVO.getTotalCount()%></span>???
			</div>
		</div>
		<!--list_top E-->


		<!-- skin_basic_list s -->
		<table class="skin_list" summary="?????? ???????????? ????????? ???????????? ?????????, ????????????, ?????????, ??????/????????????, ????????????, ?????????, ??????????????? ???????????? ????????????.">
          <caption>?????? ????????????</caption>
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 14%;" />
				<col style="width: 24%;" />
				<col style="width: 12%;" />				
				<col style="width: 18%;" />
				<col style="width: 10%;" /> 
				<col style="width: 5%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col" class="number">??????</th>
					<th scope="col" class="r_line_none2">????????????</th>
					<th scope="col" class="r_line_none2">?????????</th>
					<th scope="col" class="r_line_none2">??????/????????????</th>
					<th scope="col" class="r_line_none2">????????????</th>				
					<th scope="col" class="r_line_none2">?????????</th>
					<th scope="col" class="r_line_none file">????????????</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
					if(dataList.size() == 0){
				%>
					<tr><td class="r_line_none" colspan="8">???????????? ???????????? ????????????</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				
				<tr>
					<td class="number "><%=cont%></td>
					<td class="r_line_none2">
						<%if(util.getStr(rs.get("CODE_NM")).length()>20){%>
							<%=util.getStr(rs.get("CODE_NM")).substring(0, 20)+" ?? ?? ?? "%>
						<%}else{%>
							<%=util.getStr(rs.get("CODE_NM"))%>
						<%}%>
					</td>
					<td class="b_notice line_new_lft">
					 	<a href="/<%=siteId%>/sub.do?m=<%=m%>&mode=view&boardIdx=<%=util.getStr(rs.get("ARTICLE_ID"))%>",'eventpopup">
							<u><%if(util.getStr(rs.get("SUBJECT")).length()>45){%>
								<%=util.getStr(rs.get("SUBJECT")).substring(0, 45).replaceAll("&", "&#38;")+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%></u>
						</a>

					</td>
					<td class="r_line_none2">
						<%=util.getStr(rs.get("DATA03"))%>&nbsp;~<br />
						<%=util.getStr(rs.get("DATA04"))%>
					</td>
					
					<td>
						<%=util.getStr(rs.get("DATA07"))%>
					</td>
					
					<td class="r_line_none2">
						<%if(util.getStr(rs.get("DATA10")).length()>8){%><%=util.getStr(rs.get("DATA10")).substring(0, 8)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("DATA10"))%><%}%>
					</td>
					
					
					
					<td class="r_line_none file">
						<% if("?????????".equals(util.getStr(rs.get("RECEIPT_NM")))){ %>
						<img alt="?????????" src="/img/back/comm/edu_state_img_01.png" />
						<% }else if("?????????".equals(util.getStr(rs.get("RECEIPT_NM")))){ %>
						<img alt="?????????" src="/img/back/comm/edu_state_img_02.png" />
						<% }else{%>
						<img alt="????????????" src="/img/back/comm/edu_state_img_03.png" />
						<% }%>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>

		<div class="b_btn_area">
			&nbsp;
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
				<input type="button" class="btn_rgt" value="??????" onclick="goSubmit('write')"/>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
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
		
		if(win_w < 1198 && win_w >= 768){ //????????? 1198 , 768 ???????????? 100%
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
			
			
		}else if(win_w < 768){ //????????? 769 ???????????? 100%
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
			
		}else{ //???????????????
			//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //????????? td ?????????
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			
		}
		
	}
//]]>	
</script>
