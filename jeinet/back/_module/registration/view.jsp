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
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	String list_mode = util.getStr(paramMap.get("list_mode"));
	HashMap<String,String> dataMap = new HashMap<String , String>();
	HashMap<String,String> viewMap = new HashMap<String , String>();
	ArrayList<HashMap<String, String>> fileList = new ArrayList();
	ArrayList<HashMap<String, String>> imgfileList = new ArrayList();
	ArrayList<HashMap<String, String>> statementfileList = new ArrayList();
	StaticVO staticVO = new StaticVO();

	String fileImgPath = "";
	fileImgPath = util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"));
	String idx ="";
	if(list_mode.equals("utility")){
		dataMap = request.getAttribute("utilityData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("utilityData");
		viewMap = request.getAttribute("Compare") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("Compare");
		staticVO = request.getAttribute("utilityStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("utilityStaticVO");
		statementfileList = request.getAttribute("statementfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("statementfileList");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
		idx = util.getIntStr(dataMap.get("SEARCH_PATENT_IDX"));
	}
	if(list_mode.equals("design")){
		dataMap = request.getAttribute("designData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("designData");
		viewMap = request.getAttribute("Compare") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("Compare");
		staticVO = request.getAttribute("designStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("designStaticVO");
		statementfileList = request.getAttribute("statementfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("statementfileList");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
		idx = util.getIntStr(dataMap.get("SEARCH_DESIGN_IDX"));
	}
	if(list_mode.equals("brand")){
		dataMap = request.getAttribute("brandData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("brandData");
		viewMap = request.getAttribute("Compare") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("Compare");
		staticVO = request.getAttribute("brandStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("brandStaticVO");
		statementfileList = request.getAttribute("statementfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("statementfileList");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
		idx = util.getIntStr(dataMap.get("SEARCH_BRAND_IDX"));
	}
	if(list_mode.equals("program")){
		dataMap = request.getAttribute("programData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("programData");
		viewMap = request.getAttribute("Compare") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("Compare");
		staticVO = request.getAttribute("programStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("programStaticVO");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
		idx = util.getIntStr(dataMap.get("SEARCH_PROGRAM_IDX"));
	}
	if(list_mode.equals("knowhow")){
		dataMap = request.getAttribute("knowhowData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("knowhowData");
		viewMap = request.getAttribute("Compare") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("Compare");
		staticVO = request.getAttribute("knowHowStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("knowHowStaticVO");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
		idx = util.getIntStr(dataMap.get("SEARCH_KNOWHOW_IDX"));
	}

 	String mode = util.getStr(paramMap.get("mode"));
 	String nowPage = util.getStr(paramMap.get("nowPage"));

 	String fileGrp = "registration";
	String fileImgGrp = "registartion_img";
	String fileStatementGrp = "registartion_statement";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String fileFullImgGrp = fileImgGrp+fileSubGrp;
	String fileFullStatementGrp = fileStatementGrp+fileSubGrp;

%>
<style type="text/css">
	#utility {display:none;}
	#design {display:none;}
	#brand {display:none;}
	#program {display:none;}
	#knowhow {display:none;}
	.txt_red {color:red !important; }
	.txt_center1 td {text-align: center  !important; vertical-align: middle  !important;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	var skin = "<%=list_mode%>";
	$('#utility_list').css('display', 'none');
	$('#design_list').css('display', 'none');
	$('#brand_list').css('display', 'none');
	$('#program_list').css('display', 'none');
	$('#knowhow_list').css('display', 'none');
	$('#'+skin+'_list').css('display', 'block');
});
</script>

<form id = "fview" name = "fview" method="post" action="<%=myPage%>" >
	<input type="hidden" 	id="mode" 			name="mode" 		value="<%=mode%>"/>
	<input type="hidden" 	id="nowPage" 			name="nowPage" 		value="<%=nowPage%>"/>
	<input type="hidden" 	id="idx" 				name="idx"		value="<%=idx%>"/>
	<input type="hidden" 	name="reUrl" 			id="reUrl" 		value="./<%=myPage%>?mode=view&list_mode=<%=list_mode%>&idx=<%=idx%>" />
	<input type="hidden" 	name="list_mode" 		id="list_mode" 	value="<%=list_mode%>" />
	<input type="hidden" 	name="reject" 		id="reject" 	value="" />
	<input type="hidden" 	name="copy" 		id="copy" 	value="" />
	<input type="hidden" 	id="state" 			name="state" 		value="<%=util.getStr(paramMap.get("state"))%>"/>
</form>
	<div id="utility_list">
		<div class="skin_bbs_write" style="margin-top: 30px">
			<h2 class="tit">&nbsp;특허실용</h2>
			<table class="skin_basic_write">
				<caption>특허실용</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="tit">출원번호</th>
						<td <% if(!util.getStr(viewMap.get("APLC_NO")).equals(util.getStr(viewMap.get("UP_APLC_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_NO")) %>
						</td>
						<th scope="row" class="tit">출원국</th>
						<td <% if(!util.getStr(viewMap.get("APLC_NATION")).equals(util.getStr(viewMap.get("UP_APLC_NATION"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_NATION")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">출원일자</th>
						<td <% if(!util.getStr(viewMap.get("APLC_DT")).equals(util.getStr(viewMap.get("UP_APLC_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_DT")) %>
						</td>
						<th scope="row" class="tit">출원인</th>
						<td <% if(!util.getStr(viewMap.get("APLC_USER")).equals(util.getStr(viewMap.get("UP_APLC_USER"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_USER")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">발명명칭(국문)</th>
						<td <% if(!util.getStr(viewMap.get("INVENTION_KOR_NM")).equals(util.getStr(viewMap.get("UP_INVENTION_KOR_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("INVENTION_KOR_NM")) %>
						</td>
						<th scope="row" class="tit">발명명칭(영문)</th>
						<td <% if(!util.getStr(viewMap.get("INVENTION_ENG_NM")).equals(util.getStr(viewMap.get("UP_INVENTION_ENG_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("INVENTION_ENG_NM"))%>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">대리인</th>
						<td <% if(!util.getStr(viewMap.get("AGENT")).equals(util.getStr(viewMap.get("UP_AGENT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AGENT")) %>
						</td>
						<th scope="row" class="tit">발명자</th>
						<td <% if(!util.getStr(viewMap.get("INVENTOR")).equals(util.getStr(viewMap.get("UP_INVENTOR"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("INVENTOR")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">ICP분류</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("ICP_CL")).equals(util.getStr(viewMap.get("UP_ICP_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ICP_CL")) %>
						</td>

					</tr>
					<tr>
						<th scope="row" class="tit">권리구분</th>
						<td <% if(!util.getStr(viewMap.get("RIGHT_SE")).equals(util.getStr(viewMap.get("UP_RIGHT_SE"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RIGHT_SE")) %>
						</td>
						<th scope="row" class="tit">권리상태</th>
						<td <% if(!util.getStr(viewMap.get("RIGHT_STATUS")).equals(util.getStr(viewMap.get("UP_RIGHT_STATUS"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RIGHT_STATUS")) %>
						</td>
					</tr>
					<tr>

						<th scope="row" class="tit">등록번호</th>
						<td <% if(!util.getStr(viewMap.get("REG_NO")).equals(util.getStr(viewMap.get("UP_REG_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("REG_NO")) %>
						</td>
						<th scope="row" class="tit">등록일자</th>
						<td <% if(!util.getStr(viewMap.get("REG_DT")).equals(util.getStr(viewMap.get("UP_REG_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr((String.valueOf(dataMap.get("REG_DT")))) %>
						</td>

					</tr>
					<tr>
						<th scope="row" class="tit">공개번호</th>
						<td <% if(!util.getStr(viewMap.get("PUBLIC_NO")).equals(util.getStr(viewMap.get("UP_PUBLIC_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PUBLIC_NO")) %>
						</td>
						<th scope="row" class="tit">공개일자</th>
						<td <% if(!util.getStr(viewMap.get("PUBLIC_DT")).equals(util.getStr(viewMap.get("UP_PUBLIC_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PUBLIC_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">이전정보</th>
						<td <% if(!util.getStr(viewMap.get("BEFORE_INFO")).equals(util.getStr(viewMap.get("UP_BEFORE_INFO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("BEFORE_INFO")) %>
						</td>
						<th scope="row" class="tit">기술등급</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGYY_GRADE")).equals(util.getStr(viewMap.get("UP_TCHNLGYY_GRADE"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGYY_GRADE")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술분류(중분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_M_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_M_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_M_CL")) %>
						</td>
						<th scope="row" class="tit">기술분류(소분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_S_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_S_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_S_CL")) %>
						</td>

					</tr>
					<tr>
						<th scope="row" class="tit">기술설명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("TECHNOLOGY_DC")).equals(util.getStr(viewMap.get("UP_TECHNOLOGY_DC"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TECHNOLOGY_DC")) %>
						</td>

					</tr>
					<tr>
						<th scope="row" class="tit">최초등록료납부일</th>
						<td <% if(!util.getStr(viewMap.get("FIRST_PAYMENT_DT")).equals(util.getStr(viewMap.get("UP_FIRST_PAYMENT_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("FIRST_PAYMENT_DT")) %>
						</td>
						<th scope="row" class="tit">연차등록료납부일</th>
						<td <% if(!util.getStr(viewMap.get("YEAR_PAYMENT_DT")).equals(util.getStr(viewMap.get("UP_YEAR_PAYMENT_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("YEAR_PAYMENT_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">보유기관명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_ORG_NM")).equals(util.getStr(viewMap.get("UP_OWN_ORG_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%if(util.getStr(dataMap.get("ORG_GRP_NM")).equals(null) || util.getStr(dataMap.get("ORG_GRP_NM")).equals("")){ %>
								<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>
							<%}else{ %>
								<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
							<%} %>
						</td>
						<th scope="row" class="tit">보유부서명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_DEPT_NM")).equals(util.getStr(viewMap.get("UP_OWN_DEPT_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">지역명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("AREA")).equals(util.getStr(viewMap.get("UP_AREA"))) || !util.getStr(viewMap.get("AREA_SIGUNGU")).equals(util.getStr(viewMap.get("UP_AREA_SIGUNGU"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AREA_CODE")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">담당자</th>
						<td colspan="3">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("MANAGER_ORG")) %>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("DEPT_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("PSN_NM")) %>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("POSITION_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("TEL_NO")) %>
	                					</td>
	                					<th>이메일</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("EMAIL")) %>
	                					</td>
	                				</tr>

	                			</table>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">대표도</th>
						<td colspan="3">
							<% if(!(util.getIntStr(dataMap.get("IMG_FILE_ID"))).equals("0")) { %>
                                    <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" width="200" height="184" alt="장비사진"/>
                                    <% } else { %>
                                    이미지가 존재하지 않습니다.
                                    <% } %>
						</td>
					</tr>
					<tr>
						<%-- <th scope="row" class="tit">명세서</th>
						<td <% if(!util.getStr(viewMap.get("DETAILED_STATEMENT")).equals(util.getStr(viewMap.get("UP_DETAILED_STATEMENT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("DETAILED_STATEMENT")) %>
						</td> --%>
						<th scope="row" class="tit">명세서</th>
						<td colspan="3">
							<!-- 첨부파일 -->
							<div style="clear:both;">
								<%if(statementfileList.size() > 0){%>

									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
										<%
											int fileCnt = 1;
											for(HashMap rs:statementfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
										%>
											<li class="text">
												<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
					                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
					                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
					                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
					         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
					                        </li>
										<% fileCnt++; }%>
									</ul>
								<%} %>
							</div>
						</td>

					</tr>
					<tr>
						<th scope="row" class="tit">참조자료</th>
						<td colspan="3">
						<!-- 첨부파일 -->
						<div style="clear:both;">
							<%if(fileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:fileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %>
						</div>
						</td>
					</tr>

				</tbody>
			</table>
		</div>
		<div class="btn_box" >

			<div class="btn_left_box" >

				<!-- 권한주기 최고,기관관리자,담당자 -->
				<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99) {%>
					<%if(util.getStr(dataMap.get("STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('2')">요청 승인</button>

						<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('patentRejectDisplayDiv')">반려</button>
					<% } else if(util.getStr(dataMap.get("STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
						<%-- <%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- 사용일이 지났을경우 -->
							<button class="btn_inp_b_01" type="button" onclick="consentGo('4')">이용 완료</button>
						<% } %> --%>
						<button class="btn_inp_b_01" type="button" onclick="consentGo('5')">승인 취소</button>
					<% }else if(util.getStr(dataMap.get("STATE")).equals("6")) { %>  <!-- 승인요청상태일경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('6')">수정승인</button>
						<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('editRejectUtilityDiv')">수정반려</button>
					<% }%>
				<% } %>
			</div>

           	<div class="btn_right_box" >
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('edit','<%=util.getIntStr(dataMap.get("SEARCH_PATENT_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">수정</button>
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('del','<%=util.getIntStr(dataMap.get("SEARCH_PATENT_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">삭제</button>
           		<button class="btn_inp_w_01" type="button" onclick="goSubmit('list', '', '<%=util.getStr(paramMap.get("list_mode")) %>')">목록</button>
           	</div>
       	</div>
      </div>
      <div id="patentRejectDisplayDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectUtilityTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('3','rejectUtilityTxt')">반려확인</button>
	 </div>
	 <div id="editRejectUtilityDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectUtilityEditTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('7','rejectUtilityEditTxt')">반려확인</button>
	 </div>


      <div id="design_list">
		<div class="skin_bbs_write" style="margin-top: 30px">
			<h2 class="tit">&nbsp;디자인</h2>
			<table class="skin_basic_write">
				<caption>디자인</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="tit">출원번호</th>
						<td <% if(!util.getStr(viewMap.get("APLC_NO")).equals(util.getStr(viewMap.get("UP_APLC_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_NO")) %>
						</td>
						<th scope="row" class="tit">출원일자</th>
						<td <% if(!util.getStr(viewMap.get("APLC_DT")).equals(util.getStr(viewMap.get("UP_APLC_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">출원인</th>
						<td <% if(!util.getStr(viewMap.get("APLC_USER")).equals(util.getStr(viewMap.get("UP_APLC_USER"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_USER")) %>
						</td>
						<th scope="row" class="tit">출원국</th>
						<td <% if(!util.getStr(viewMap.get("KOREA_CL")).equals(util.getStr(viewMap.get("UP_KOREA_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%if(util.getStr(dataMap.get("KOREA_CL")).equals("A")){%>
								대한민국
							<%}else{%>
								국외
							<%}%>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">디자인일련번호</th>
						<td <% if(!util.getStr(viewMap.get("DESIGN_NO")).equals(util.getStr(viewMap.get("UP_DESIGN_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("DESIGN_NO")) %>
						</td>
						<th scope="row" class="tit">명칭</th>
						<td <% if(!util.getStr(viewMap.get("USE_NM")).equals(util.getStr(viewMap.get("UP_USE_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("USE_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">권리상태</th>
						<td <% if(!util.getStr(viewMap.get("RIGHT_STATUS")).equals(util.getStr(viewMap.get("UP_RIGHT_STATUS"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RIGHT_STATUS"))%>
						</td>
						<th scope="row" class="tit">국제분류</th>
						<td <% if(!util.getStr(viewMap.get("INTRL_CL")).equals(util.getStr(viewMap.get("UP_INTRL_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("INTRL_CL")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">창작자</th>
						<td <% if(!util.getStr(viewMap.get("CREATION_USER")).equals(util.getStr(viewMap.get("UP_CREATION_USER"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("CREATION_USER")) %>
						</td>
						<th scope="row" class="tit">대리인</th>
						<td <% if(!util.getStr(viewMap.get("AGENT")).equals(util.getStr(viewMap.get("UP_AGENT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AGENT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">등록번호</th>
						<td <% if(!util.getStr(viewMap.get("REG_NO")).equals(util.getStr(viewMap.get("UP_REG_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(String.valueOf(dataMap.get("REG_NO"))) %>
						</td>
						<th scope="row" class="tit">등록일자</th>
						<td <% if(!util.getStr(viewMap.get("REG_DT")).equals(util.getStr(viewMap.get("UP_REG_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(String.valueOf(dataMap.get("REG_DT"))) %>
						</td>
					</tr>
					<%-- <tr>
						<th scope="row" class="tit">공개번호</th>
						<td <% if(!util.getStr(viewMap.get("PUBLIC_NO")).equals(util.getStr(viewMap.get("UP_PUBLIC_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PUBLIC_NO")) %>
						</td>
						<th scope="row" class="tit">공개일자</th>
						<td <% if(!util.getStr(viewMap.get("PUBLIC_DT")).equals(util.getStr(viewMap.get("UP_PUBLIC_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PUBLIC_DT")) %>
						</td>
					</tr> --%>
					<tr>
						<th scope="row" class="tit">이전정보</th>
						<td <% if(!util.getStr(viewMap.get("BEFORE_INFO")).equals(util.getStr(viewMap.get("UP_BEFORE_INFO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("BEFORE_INFO")) %>
						</td>
						<th scope="row" class="tit">최초등록료납부일</th>
						<td <% if(!util.getStr(viewMap.get("YEAR_PAYMENT_DT")).equals(util.getStr(viewMap.get("UP_YEAR_PAYMENT_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("YEAR_PAYMENT_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술분류(중분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_M_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_M_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_M_CL")) %>
						</td>
						<th scope="row" class="tit">기술분류(소분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_S_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_S_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_S_CL")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술설명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("TECHNOLOGY_DC")).equals(util.getStr(viewMap.get("UP_TECHNOLOGY_DC"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TECHNOLOGY_DC")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">보유기관명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_ORG_NM")).equals(util.getStr(viewMap.get("UP_OWN_ORG_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
						</td>
						<th scope="row" class="tit">보유부서명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_DEPT_NM")).equals(util.getStr(viewMap.get("UP_OWN_DEPT_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">지역명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("AREA")).equals(util.getStr(viewMap.get("UP_AREA"))) || !util.getStr(viewMap.get("AREA_SIGUNGU")).equals(util.getStr(viewMap.get("UP_AREA_SIGUNGU"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AREA_CODE")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">담당자</th>
						<td colspan="3">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("MANAGER_ORG")) %>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("DEPT_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("PSN_NM")) %>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("POSITION_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("TEL_NO")) %>
	                					</td>
	                					<th>이메일</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("EMAIL")) %>
	                					</td>
	                				</tr>

	                			</table>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">대표도</th>
						<td colspan="3">
						<!-- 첨부파일 -->
							<%-- <%if(imgfileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>
				                        	<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
				         					<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %> --%>
							<% if(!(util.getIntStr(dataMap.get("IMG_FILE_ID"))).equals("0")) { %>
                                    <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" width="200" height="184" alt="장비사진"/>
                                    <% } else { %>
                                    이미지가 존재하지 않습니다.
                                    <% } %>
						</td>
					</tr>
					<tr>
						<%-- <th scope="row" class="tit">명세서</th>
						<td <% if(!util.getStr(viewMap.get("DETAILED_STATEMENT")).equals(util.getStr(viewMap.get("UP_DETAILED_STATEMENT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("DETAILED_STATEMENT")) %>
						</td> --%>
						<th scope="row" class="tit">명세서</th>
						<td colspan="3">
							<!-- 첨부파일 -->
							<div style="clear:both;">
								<%if(statementfileList.size() > 0){%>

									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
										<%
											int fileCnt = 1;
											for(HashMap rs:statementfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
										%>
											<li class="text">
												<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
					                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
					                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
					                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
					         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
					                        </li>
										<% fileCnt++; }%>
									</ul>
								<%} %>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">참조자료</th>
						<td colspan="3">
						<!-- 첨부파일 -->
						<div style="clear:both;">
							<%if(fileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:fileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %>
						</div>
						</td>
					</tr>

				</tbody>
			</table>
		</div>
		<div class="btn_box" >

		<div class="btn_left_box" >

				<!-- 권한주기 최고,기관관리자,담당자 -->
				<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99) {%>
					<%if(util.getStr(dataMap.get("STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('2')">요청 승인</button>

						<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('designRejectDisplayDiv')">반려</button>
						<% } else if(util.getStr(dataMap.get("STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
						<%-- <%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- 사용일이 지났을경우 -->
							<button class="btn_inp_b_01" type="button" onclick="consentGo('4')">이용 완료</button>
						<% } %> --%>
						<button class="btn_inp_b_01" type="button" onclick="consentGo('5')">승인 취소</button>
					<% }else if(util.getStr(dataMap.get("STATE")).equals("6")) { %>  <!-- 승인요청상태일경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('6')">수정승인</button>
						<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('editRejectDesignDiv')">수정반려</button>
					<% }%>
				<% } %>
			</div>

           	<div class="btn_right_box" >
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('edit','<%=util.getIntStr(dataMap.get("SEARCH_DESIGN_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">수정</button>
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('del','<%=util.getIntStr(dataMap.get("SEARCH_DESIGN_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">삭제</button>
           		<button class="btn_inp_w_01" type="button" onclick="goSubmit('list', '', '<%=util.getStr(paramMap.get("list_mode")) %>')">목록</button>
           	</div>
       	</div>
      </div>
      <div id="designRejectDisplayDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectDesignTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('3','rejectDesignTxt')">반려확인</button>
	  </div>
	  <div id="editRejectDesignDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectDesignEditTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('7','rejectDesignEditTxt')">반려확인</button>
	  </div>


      <div id="brand_list">
		<div class="skin_bbs_write" style="margin-top: 30px">
			<h2 class="tit">&nbsp;상표</h2>
			<table class="skin_basic_write">
				<caption>상표</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="tit">출원(국제등록)번호</th>
						<td <% if(!util.getStr(viewMap.get("INTRL_APLC_NO")).equals(util.getStr(viewMap.get("UP_INTRL_APLC_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("INTRL_APLC_NO")) %>
						</td>
						<th scope="row" class="tit">출원(국제등록)일자</th>
						<td <% if(!util.getStr(viewMap.get("INTRL_APLC_DT")).equals(util.getStr(viewMap.get("UP_INTRL_APLC_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("INTRL_APLC_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">출원인</th>
						<td <% if(!util.getStr(viewMap.get("APLC_USER")).equals(util.getStr(viewMap.get("UP_APLC_USER"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("APLC_USER")) %>
						</td>
						<th scope="row" class="tit">대리인</th>
						<td <% if(!util.getStr(viewMap.get("AGENT")).equals(util.getStr(viewMap.get("UP_AGENT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AGENT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">명칭</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("USE_NM")).equals(util.getStr(viewMap.get("UP_USE_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("USE_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">상품분류</th>
						<td <% if(!util.getStr(viewMap.get("GOODS_CL")).equals(util.getStr(viewMap.get("UP_GOODS_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("GOODS_CL")) %>
						</td>
						<th scope="row" class="tit">도형코드</th>
						<td <% if(!util.getStr(viewMap.get("FIGURE_CODE")).equals(util.getStr(viewMap.get("UP_FIGURE_CODE"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("FIGURE_CODE")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">등록번호</th>
						<td <% if(!util.getStr(viewMap.get("REG_NO")).equals(util.getStr(viewMap.get("UP_REG_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("REG_NO"))%>
						</td>
						<th scope="row" class="tit">등록일자</th>
						<td <% if(!util.getStr(viewMap.get("REG_DT")).equals(util.getStr(viewMap.get("UP_REG_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("REG_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">공고번호</th>
						<td <% if(!util.getStr(viewMap.get("PBLANC_NO")).equals(util.getStr(viewMap.get("UP_PBLANC_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PBLANC_NO")) %>
						</td>
						<th scope="row" class="tit">공고일자</th>
						<td <% if(!util.getStr(viewMap.get("PBLANC_DT")).equals(util.getStr(viewMap.get("UP_PBLANC_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PBLANC_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">권리상태</th>
						<td <% if(!util.getStr(viewMap.get("RIGHT_STATUS")).equals(util.getStr(viewMap.get("UP_RIGHT_STATUS"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RIGHT_STATUS")) %>
						</td>
						<th scope="row" class="tit">이전정보</th>
						<td <% if(!util.getStr(viewMap.get("BEFORE_INFO")).equals(util.getStr(viewMap.get("UP_BEFORE_INFO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("BEFORE_INFO")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술분류(중분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_M_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_M_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_M_CL")) %>
						</td>
						<th scope="row" class="tit">기술분류(소분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_S_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_S_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_S_CL")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술설명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("TECHNOLOGY_DC")).equals(util.getStr(viewMap.get("UP_TECHNOLOGY_DC"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TECHNOLOGY_DC")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">보유기관명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_ORG_NM")).equals(util.getStr(viewMap.get("UP_OWN_ORG_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
						</td>
						<th scope="row" class="tit">보유부서명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_DEPT_NM")).equals(util.getStr(viewMap.get("UP_OWN_DEPT_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">지역명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("AREA")).equals(util.getStr(viewMap.get("UP_AREA"))) || !util.getStr(viewMap.get("AREA_SIGUNGU")).equals(util.getStr(viewMap.get("UP_AREA_SIGUNGU"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AREA_CODE")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">담당자</th>
						<td colspan="3">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("MANAGER_ORG")) %>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("DEPT_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("PSN_NM")) %>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("POSITION_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("TEL_NO")) %>
	                					</td>
	                					<th>이메일</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("EMAIL")) %>
	                					</td>
	                				</tr>

	                			</table>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">최초등록료납부일</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("YEAR_PAYMENT_DT")).equals(util.getStr(viewMap.get("UP_YEAR_PAYMENT_DT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("YEAR_PAYMENT_DT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">대표도 </th>
						<td colspan="3">
						<!-- 첨부파일 -->
							<%-- <%if(imgfileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>
				                        	<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
				         					<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %> --%>
							<% if(!(util.getIntStr(dataMap.get("IMG_FILE_ID"))).equals("0")) { %>
                                    <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" width="200" height="184" alt="장비사진"/>
                                    <% } else { %>
                                    이미지가 존재하지 않습니다.
                                    <% } %>
						</td>
					</tr>
					<tr>
						<%-- <th scope="row" class="tit">명세서</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("DETAILED_STATEMENT")).equals(util.getStr(viewMap.get("UP_DETAILED_STATEMENT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("DETAILED_STATEMENT")) %>
						</td> --%>
						<th scope="row" class="tit">명세서</th>
						<td colspan="3">
							<!-- 첨부파일 -->
							<div style="clear:both;">
								<%if(statementfileList.size() > 0){%>

									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
										<%
											int fileCnt = 1;
											for(HashMap rs:statementfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
										%>
											<li class="text">
												<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
					                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
					                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
					                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
					         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
					                        </li>
										<% fileCnt++; }%>
									</ul>
								<%} %>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">참조자료</th>
						<td colspan="3">
						<!-- 첨부파일 -->
						<div style="clear:both;">
							<%if(fileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:fileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %>
						</div>
						</td>
					</tr>

				</tbody>
			</table>
		</div>
		<div class="btn_box" >

		<div class="btn_left_box" >

			<!-- 권한주기 최고,기관관리자,담당자 -->
			<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99) {%>
				<%if(util.getStr(dataMap.get("STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
					<button class="btn_inp_b_01" type="button" onclick="consentGo('2')">요청 승인</button>

					<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('brandRejectDisplayDiv')">반려</button>
					<% } else if(util.getStr(dataMap.get("STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
					<%-- <%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- 사용일이 지났을경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('4')">이용 완료</button>
					<% } %> --%>
					<button class="btn_inp_b_01" type="button" onclick="consentGo('5')">승인 취소</button>
				<%  }else if(util.getStr(dataMap.get("STATE")).equals("6")) { %>  <!-- 승인요청상태일경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('6')">수정승인</button>
						<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('editRejectBrandDiv')">수정반려</button>
				<% }%>
			<% } %>
		</div>

           	<div class="btn_right_box" >
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('edit','<%=util.getIntStr(dataMap.get("SEARCH_BRAND_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">수정</button>
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('del','<%=util.getIntStr(dataMap.get("SEARCH_BRAND_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">삭제</button>
           		<button class="btn_inp_w_01" type="button" onclick="goSubmit('list', '', '<%=util.getStr(paramMap.get("list_mode")) %>')">목록</button>
           	</div>
       	</div>
      </div>
      <div id="brandRejectDisplayDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectBrandTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('3','rejectBrandTxt')">반려확인</button>
	  </div>
      <div id="editRejectBrandDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectBrandEditTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('7','rejectBrandEditTxt')">반려확인</button>
	  </div>


      <div id="program_list">
		<div class="skin_bbs_write" style="margin-top: 30px">
			<h2 class="tit">&nbsp;프로그램</h2>
			<table class="skin_basic_write">
				<caption>프로그램</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="tit">등록번호</th>
						<td <% if(!util.getStr(viewMap.get("REG_NO")).equals(util.getStr(viewMap.get("UP_REG_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("REG_NO")) %>
						</td>
						<th scope="row" class="tit">등록연월일</th>
						<td <% if(!util.getStr(viewMap.get("REG_DE")).equals(util.getStr(viewMap.get("UP_REG_DE"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("REG_DE")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">창작년월일</th>
						<td <% if(!util.getStr(viewMap.get("CRT_WORK_DE")).equals(util.getStr(viewMap.get("UP_CRT_WORK_DE"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("CRT_WORK_DE")) %>
						</td>
						<th scope="row" class="tit">공표연월일</th>
						<td <% if(!util.getStr(viewMap.get("PUBLICT_DE")).equals(util.getStr(viewMap.get("UP_PUBLICT_DE"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PUBLICT_DE")) %>
						</td>
					</tr>

					<tr>
						<th scope="row" class="tit">명칭</th>
						<td <% if(!util.getStr(viewMap.get("REG_NO")).equals(util.getStr(viewMap.get("UP_REG_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("REG_NO")) %>
						</td>
						<th scope="row" class="tit">이전정보</th>
						<td <% if(!util.getStr(viewMap.get("BEFORE_INFO")).equals(util.getStr(viewMap.get("UP_BEFORE_INFO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("BEFORE_INFO")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">프로그램저작자</th>
						<td <% if(!util.getStr(viewMap.get("PGM_AUTHOR")).equals(util.getStr(viewMap.get("UP_PGM_AUTHOR"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PGM_AUTHOR"))%>
						</td>
						<th scope="row" class="tit">창작에참여한자</th>
						<td <% if(!util.getStr(viewMap.get("CRT_PARTICIPANT")).equals(util.getStr(viewMap.get("UP_CRT_PARTICIPANT"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("CRT_PARTICIPANT")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술분류(중분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_M_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_M_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_M_CL")) %>
						</td>
						<th scope="row" class="tit">기술분류(소분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_S_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_S_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_S_CL")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">프로그램설명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("PGM_DC")).equals(util.getStr(viewMap.get("UP_PGM_DC"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("PGM_DC")) %>
						</td>

					</tr>
					<tr>
						<th scope="row" class="tit">보유기관명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_ORG_NM")).equals(util.getStr(viewMap.get("UP_OWN_ORG_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
						</td>
						<th scope="row" class="tit">보유부서명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_DEPT_NM")).equals(util.getStr(viewMap.get("UP_OWN_DEPT_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">지역명</th>
						<td colspa="3" <% if(!util.getStr(viewMap.get("AREA")).equals(util.getStr(viewMap.get("UP_AREA"))) || !util.getStr(viewMap.get("AREA_SIGUNGU")).equals(util.getStr(viewMap.get("UP_AREA_SIGUNGU"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AREA_CODE")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">담당자</th>
						<td colspan="3">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("MANAGER_ORG")) %>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("DEPT_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("PSN_NM")) %>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("POSITION_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("TEL_NO")) %>
	                					</td>
	                					<th>이메일</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("EMAIL")) %>
	                					</td>
	                				</tr>

	                			</table>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">대표도</th>
						<td colspan="3">
						<!-- 첨부파일 -->
							<%-- <%if(imgfileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>
				                        	<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
				         					<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %> --%>
							<% if(!(util.getIntStr(dataMap.get("IMG_FILE_ID"))).equals("0")) { %>
                                    <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" width="200" height="184" alt="장비사진"/>
                                    <% } else { %>
                                    이미지가 존재하지 않습니다.
                                    <% } %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술소개자료</th>
						<td colspan="3">
						<!-- 첨부파일 -->
						<div style="clear:both;">
							<%if(fileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:fileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_box" >

		<div class="btn_left_box" >

			<!-- 권한주기 최고,기관관리자,담당자 -->
			<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99) {%>
				<%if(util.getStr(dataMap.get("STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
					<button class="btn_inp_b_01" type="button" onclick="consentGo('2')">요청 승인</button>

					<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('programRejectDisplayDiv')">반려</button>
				<% } else if(util.getStr(dataMap.get("STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
					<%-- <%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- 사용일이 지났을경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('4')">이용 완료</button>
					<% } %> --%>
					<button class="btn_inp_b_01" type="button" onclick="consentGo('5')">승인 취소</button>
				<%  }else if(util.getStr(dataMap.get("STATE")).equals("6")) { %>  <!-- 승인요청상태일경우 -->
						<button class="btn_inp_b_01" type="button" onclick="consentGo('6')">수정승인</button>
						<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('editRejectProgramDiv')">수정반려</button>
				<% }%>
			<% } %>
		</div>

           	<div class="btn_right_box" >
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('edit','<%=util.getIntStr(dataMap.get("SEARCH_PROGRAM_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">수정</button>
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('del','<%=util.getIntStr(dataMap.get("SEARCH_PROGRAM_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">삭제</button>
           		<button class="btn_inp_w_01" type="button" onclick="goSubmit('list', '', '<%=util.getStr(paramMap.get("list_mode")) %>')">목록</button>
           	</div>
       	</div>
      </div>
      <div id="programRejectDisplayDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectProgramTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('3','rejectProgramTxt')">반려확인</button>
	  </div>
	  <div id="editRejectProgramDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectProgramEditTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('7','rejectProgramEditTxt')">반려확인</button>
	  </div>


      <div id="knowhow_list">
		<div class="skin_bbs_write" style="margin-top: 30px">
			<h2 class="tit">&nbsp;미분류</h2>
			<table class="skin_basic_write">
				<caption>노하우</caption>
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="tit">노하우번호</th>
						<td <% if(!util.getStr(viewMap.get("KNOW_HOW_NO")).equals(util.getStr(viewMap.get("UP_KNOW_HOW_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("KNOW_HOW_NO")) %>
						</td>
						<th scope="row" class="tit">기술명</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_NM")).equals(util.getStr(viewMap.get("UP_TCHNLGY_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술분류(중분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_M_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_M_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_M_CL")) %>
						</td>
						<th scope="row" class="tit">기술분류(소분류)</th>
						<td <% if(!util.getStr(viewMap.get("TCHNLGY_S_CL")).equals(util.getStr(viewMap.get("UP_TCHNLGY_S_CL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TCHNLGY_S_CL")) %>
						</td>

					</tr>
					<tr>
						<th scope="row" class="tit">소속기관명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_ORG_NM")).equals(util.getStr(viewMap.get("UP_OWN_ORG_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
						</td>
						<th scope="row" class="tit">소속부서명</th>
						<td <% if(!util.getStr(viewMap.get("OWN_DEPT_NM")).equals(util.getStr(viewMap.get("UP_OWN_DEPT_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">지역명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("AREA")).equals(util.getStr(viewMap.get("UP_AREA"))) || !util.getStr(viewMap.get("AREA_SIGUNGU")).equals(util.getStr(viewMap.get("UP_AREA_SIGUNGU"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("AREA_CODE")) %>
						</td>
					</tr>

					<tr>
						<th scope="row" class="tit">담당자</th>
						<td colspan="3">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("MANAGER_ORG")) %>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("DEPT_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("PSN_NM")) %>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;" <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("POSITION_NM")) %>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("TEL_NO")) %>
	                					</td>
	                					<th>이메일</th>
	                					<td <% if(!util.getStr(viewMap.get("MANAGER_IDX")).equals(util.getStr(viewMap.get("UP_MANAGER_IDX"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
	                						<%=util.getStr(dataMap.get("EMAIL")) %>
	                					</td>
	                				</tr>

	                			</table>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">이전정보</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("BEFORE_INFO")).equals(util.getStr(viewMap.get("UP_BEFORE_INFO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("BEFORE_INFO")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술설명</th>
						<td colspan="3" <% if(!util.getStr(viewMap.get("TECHNOLOGY_DC")).equals(util.getStr(viewMap.get("UP_TECHNOLOGY_DC"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("TECHNOLOGY_DC")) %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">대표도</th>
						<td colspan="3">
						<!-- 첨부파일 -->
							<%-- <%if(imgfileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>
				                        	<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
				         					<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %> --%>
							<% if(!(util.getIntStr(dataMap.get("IMG_FILE_ID"))).equals("0")) { %>
                                    <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" width="200" height="184" alt="장비사진"/>
                                    <% } else { %>
                                    이미지가 존재하지 않습니다.
                                    <% } %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit">기술소개자료</th>
						<td colspan="3">
						<!-- 첨부파일 -->
						<div style="clear:both;">
							<%if(fileList.size() > 0){%>

								<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:fileList){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
															+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
															+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
				                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
				                        	<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
				                        	<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
				         					<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
				                        </li>
									<% fileCnt++; }%>
								</ul>
							<%} %>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			<table class="skin_basic_write txt_center1">
				<caption>전문가등록</caption>
				<colgroup>
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:20%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" class="tit">기술보유자</th>
						<th scope="row" class="tit">직위</th>
						<th scope="row" class="tit">전화번호</th>
						<th scope="row" class="tit">휴대폰</th>
						<th scope="row" class="tit">이메일</th>
					</tr>
					<tr>
						<td <% if(!util.getStr(viewMap.get("RSPNBER_USER_NM")).equals(util.getStr(viewMap.get("UP_RSPNBER_USER_NM"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RSPNBER_USER_NM")) %>
						</td>
						<td <% if(!util.getStr(viewMap.get("RSPNBER_OFC_POSITION")).equals(util.getStr(viewMap.get("UP_RSPNBER_OFC_POSITION"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RSPNBER_OFC_POSITION")) %>
						</td>
						<td <% if(!util.getStr(viewMap.get("RSPNBER_TEL_NO")).equals(util.getStr(viewMap.get("UP_RSPNBER_TEL_NO"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RSPNBER_TEL_NO"))%>
						</td>
						<td <% if(!util.getStr(viewMap.get("RSPNBER_MOBILE_PHONE")).equals(util.getStr(viewMap.get("UP_RSPNBER_MOBILE_PHONE"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RSPNBER_MOBILE_PHONE")) %>
						</td>
						<td <% if(!util.getStr(viewMap.get("RSPNBER_EMAIL")).equals(util.getStr(viewMap.get("UP_RSPNBER_EMAIL"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=util.getStr(dataMap.get("RSPNBER_EMAIL")) %>
						</td>
					</tr>
					<%-- <tr>
						<th scope="row" class="tit"></th>
						<th scope="row" class="tit" colspan="2">개발참여자(이름)</th>
						<th scope="row" class="tit">개발참여자(소속)</th>
						<th scope="row" class="tit">개발참여자(직위)</th>
					</tr>

<%
if(!(util.getStr(dataMap.get("PARTICIPANT_USER_NAME"))).equals("") && !(util.getStr(dataMap.get("PARTICIPANT_USER_NAME"))).equals(null)){
		String name[] = dataMap.get("PARTICIPANT_USER_NAME").split(", ");
		String position[] = dataMap.get("PARTICIPANT_POSITION").split(", ");
		String ofcPosition[] = dataMap.get("PARTICIPANT_OFC_POSITION").split(", ");

		if(name.length > 0){
			for(int i=0; i<name.length; i++){

%>					<tr>
						<td>
							<%=i+1%>
						</td>
						<td colspan="2" <% if(!util.getStr(viewMap.get("PARTICIPANT_USER_NAME")).equals(util.getStr(viewMap.get("UP_PARTICIPANT_USER_NAME"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=name[i]%>
						</td>
						<td <% if(!util.getStr(viewMap.get("PARTICIPANT_POSITION")).equals(util.getStr(viewMap.get("UP_PARTICIPANT_POSITION"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=position[i]%>
						</td>
						<td <% if(!util.getStr(viewMap.get("PARTICIPANT_OFC_POSITION")).equals(util.getStr(viewMap.get("UP_PARTICIPANT_OFC_POSITION"))) && !viewMap.equals(null)){out.println("class='txt_red'");} %>>
							<%=ofcPosition[i]%>
						</td>
					</tr>
<%			}
		}else{
%>
					<tr>
						<td colspan="5"  class="txt_center1">
							참여자 없음
						</td>
					</tr>
<%		}
} %>
 --%>
				</tbody>
			</table>
		</div>
		<div class="btn_box" >

		<div class="btn_left_box" >

			<!-- 권한주기 최고,기관관리자,담당자 -->
			<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99) { %>
				<%if(util.getStr(dataMap.get("STATE")).equals("1")) { %>  <!-- 승인요청상태일경우 -->
					<button class="btn_inp_b_01" type="button" onclick="consentGo('2')">요청 승인</button>
					<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('howRejectDisplayDiv')">반려</button>

				<% } else if(util.getStr(dataMap.get("STATE")).equals("2")) { %> <!-- 이용승인상태일경우 -->
					<button class="btn_inp_b_01" type="button" onclick="consentGo('5')">승인 취소</button>
				<% }else if(util.getStr(dataMap.get("STATE")).equals("6")) { %>  <!-- 승인요청상태일경우 -->
					<button class="btn_inp_b_01" type="button" onclick="consentGo('6')">수정승인</button>
					<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay('editRejecthowDiv')">수정반려</button>
				<% }%>
			<% } %>
		</div>



           	<div class="btn_right_box" >
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('edit','<%=util.getIntStr(dataMap.get("SEARCH_KNOWHOW_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">수정</button>
           		<button class="btn_inp_b_01" type="button" onclick="goSubmit('del','<%=util.getIntStr(dataMap.get("SEARCH_KNOWHOW_IDX")) %>', '<%=util.getStr(paramMap.get("list_mode")) %>')">삭제</button>
           		<button class="btn_inp_w_01" type="button" onclick="goSubmit('list', '', '<%=util.getStr(paramMap.get("list_mode")) %>')">목록</button>
           	</div>
       	</div>
      </div>

      <br/>
		<div id="howRejectDisplayDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectKnowhowTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('3','rejectKnowhowTxt')">반려확인</button>
		</div>
		<div id="editRejecthowDiv" style="display:none; ">
			반려 사유 : <textarea rows="3" cols="50" id="rejectKnowhowEditTxt" name="rejectTxt"></textarea>
			<button class="btn_inp_b_01" type="button" onclick="consentGo('7','rejectKnowhowEditTxt')">반려확인</button>
		</div>



<script type="text/javascript">
	function goSubmit(mode,idx, list_mode){
		if(mode == "del"){
			if(confirm("삭제하시겠습니까?")){
				$('#mode').val('del');
				$('#reUrl').val("/sys/sys_jip_registration.do?list_mode="+list_mode);
				$('#fview').submit();
			}else{
				return false;
			}
		}
		$('#mode').val(mode);
		$('#idx').val(idx);
		$('#fview').submit();
	}
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}

	function pageDelGo(idx,list_mode){
		if(confirm("삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fview').submit();
		}
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}

	function consentGo(state,reject){


		if(state == '2'){ //이용승인
			if(confirm("정말 이용승인 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./registration.do"
				$('#state').val(state);
				//alert("승인 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(state == '3'){ //승인반려
			if(confirm("정말 승인거절 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./registration.do"
				$('#state').val(state);
				$('#reject').val(reject);
				alert("반려 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(state == '5'){ //승인취소
			if(confirm("정말 승인취소 하시겠습니까?")){
				$('#mode').val('stateEdit');
				$('#state').val(state);
				//alert("승인 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(state == '6'){ //수정승인
			if(confirm("정말 수정승인 하시겠습니까?")){
				$('#mode').val('stateEdit');
				$('#state').val("2");
				$('#copy').val("Y");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(state == '7'){ //수정반려
			if(confirm("정말 수정을 반려 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./registration.do"
				$('#state').val(state);
				$('#reject').val(reject);
				alert("수정반려 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

	}

	function resveReturnDisplay(rejectDivName){
		$('#'+rejectDivName).show();
	}

</script>