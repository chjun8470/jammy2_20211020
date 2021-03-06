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

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");

	String techNm = util.getStr(paramMap.get("techNm"));
	String techOrgNm = util.getStr(paramMap.get("techOrgNm"));
	String techBeforeInfo = util.getStr(paramMap.get("techBeforeInfo"));

	String fileGrp = "registration";
	String fileImgGrp = "registartion_img";
	String fileStatementGrp = "registartion_statement";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String fileFullImgGrp = fileImgGrp+fileSubGrp;
	String fileFullStatementGrp = fileStatementGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileImgParam = "";
	String fileDownParam = "";
	String fileImgPath = "";
	String fileTitleName = "";

	fileTitleName = util.getStr(dataMap.get("IMG_TITLE"));
	fileImgPath = util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"));

	if(util.getStr(paramMap.get("searchCd")).equals("1") || util.getStr(paramMap.get("searchCd")).equals("3")) { //???????????? REFERENCE_DATA
			fileDownParam = "?dataGrp="+util.getStr(dataMap.get("DOWN_DATA_GRP"))
							+"&amp;fileId="+String.valueOf(dataMap.get("DOWN_FILE_ID"))
							+"&amp;dataIdx="+util.getStr(dataMap.get("REFERENCE_DATA"));
			fileImgParam = "?dataGrp="+util.getStr(dataMap.get("IMG_DATA_GRP"))
							+"&amp;fileId="+String.valueOf(dataMap.get("IMG_FILE_ID"))
							+"&amp;dataIdx="+util.getStr(dataMap.get("REFERENCE_DATA"));

	} else if (util.getStr(paramMap.get("searchCd")).equals("2")) { //???????????? INTRCN_DATA
			fileDownParam = "?dataGrp="+util.getStr(dataMap.get("DOWN_DATA_GRP"))
							+"&amp;fileId="+String.valueOf(dataMap.get("DOWN_FILE_ID"))
							+"&amp;dataIdx="+util.getStr(dataMap.get("INTRCN_DATA"));
			fileImgParam = "?dataGrp="+util.getStr(dataMap.get("IMG_DATA_GRP"))
					+"&amp;fileId="+String.valueOf(dataMap.get("IMG_FILE_ID"))
					+"&amp;dataIdx="+util.getStr(dataMap.get("INTRCN_DATA"));

	} else if (util.getStr(paramMap.get("searchCd")).equals("4") || util.getStr(paramMap.get("searchCd")).equals("5")) { //?????????????????? TCHNLGY_INTRCN_DATA
			fileDownParam = "?dataGrp="+util.getStr(dataMap.get("DOWN_DATA_GRP"))
							+"&amp;fileId="+String.valueOf(dataMap.get("DOWN_FILE_ID"))
							+"&amp;dataIdx="+util.getStr(dataMap.get("TCHNLGY_INTRCN_DATA"));
			fileImgParam = "?dataGrp="+util.getStr(dataMap.get("IMG_DATA_GRP"))
					+"&amp;fileId="+String.valueOf(dataMap.get("IMG_FILE_ID"))
					+"&amp;dataIdx="+util.getStr(dataMap.get("TCHNLGY_INTRCN_DATA"));
	}

%>


<!--???????????? ?????? S-->
<!--Patent_viewWrap S-->
<div class="Patent_viewWrap">
	<div class="P_contBox">
	<%-- <div class="p_img_view">
		<div class="p_img">
			<img src="<%=(util.getStr(dataMap.get("CI_FILE_SRC")).equals("") ? "/img/jipbank/main/no_image01.gif" : util.getStr(dataMap.get("CI_FILE_PATH"))+util.getStr(dataMap.get("CI_FILE_TITLE")))%>" alt="??????CI" />
		</div>
	</div> --%>

	<div class="tit_patent02">
	<%if(util.getStr(paramMap.get("searchCd")).equals("1")) { %>[??????????????????]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("2")) { %>[?????????]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("3")) { %>[?????????]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>[????????????]<% } %>
	<%if(util.getStr(paramMap.get("searchCd")).equals("5")) { %>[?????????]<% } %>
	</div>

	<div class="tit_patent03">
	<%if(util.getStr(paramMap.get("searchCd")).equals("1")) { %><%=util.getStr(dataMap.get("INVENTION_KOR_NM"))%>(<%=util.getStr(dataMap.get("INVENTION_ENG_NM"))%>)
	<% } else if(util.getStr(paramMap.get("searchCd")).equals("5")) { %><%=util.getStr(dataMap.get("TCHNLGY_NM"))%>
	<% } else { %><%=util.getStr(dataMap.get("USE_NM"))%>
	<% } %>
	</div>
	<!-- <div class="info_text02">
	</div> -->
	<%-- <div class="info_text02">
	<%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>
		<% if(util.getStr(dataMap.get("PGM_DC")).length() > 210) { %>
			<%=util.getStr(dataMap.get("PGM_DC")).substring(0, 207)+"...."%>
		<% } else { %>
			<%=util.getStr(dataMap.get("PGM_DC"))%>
		<% } %>

	<% } else { %>
		<% if(util.getStr(dataMap.get("TECHNOLOGY_DC")).length() > 210) { %>
			<%=util.getStr(dataMap.get("TECHNOLOGY_DC")).substring(0, 207)+"...."%>
		<% } else { %>
			<%=util.getStr(dataMap.get("TECHNOLOGY_DC"))%>
		<% } %>
	<% } %>
	</div> --%>

	<%if(!"".equals(util.getStr(loginVO.getUserIdx()))) {%>
		<%-- <a href="/jipbank/sub.do?m=64&mode=write&amp;searchCd=<%=util.getStr(paramMap.get("searchCd"))%>&amp;searchId=<%=util.getStr(paramMap.get("searchId"))%>&amp;techNm=<%=techNm%>&amp;techOrgNm=<%=techOrgNm%>&amp;techBeforeInfo=<%=techBeforeInfo%>">
		<button class="btn_apply" style="cursor:pointer">????????????
		</button></a> --%>
		<a href="javascript:consultingSubmit()">
		<button class="btn_apply" style="cursor:pointer">????????????
		</button></a>
	<% } else { %>
		<button class="btn_apply" onclick="consultationGo()">????????????</button>
		<!-- <button class="btn_lft" type="button" onclick="ssoPopupShow('login')">????????????</button> -->
	<% } %>

	<div class="scoreBox">
		<div class="star_score">?????? :
			<%if(String.valueOf(dataMap.get("STAR_SCORE")).equals("1")) { %> <img src="/img/board/star1-1.png" alt="1???" /> 1???
			<% } else if(String.valueOf(dataMap.get("STAR_SCORE")).equals("2")) { %> <img src="/img/board/star2-2.png" alt="2???" /> 2???
			<% } else if(String.valueOf(dataMap.get("STAR_SCORE")).equals("3")) { %> <img src="/img/board/star3-3.png" alt="3???" /> 3???
			<% } else if(String.valueOf(dataMap.get("STAR_SCORE")).equals("4")) { %> <img src="/img/board/star4-4.png" alt="4???" /> 4???
			<% } else if(String.valueOf(dataMap.get("STAR_SCORE")).equals("5")) { %> <img src="/img/board/star5-5.png" alt="5???" /> 5???
			<% } else { %> <img src="/img/board/star5-5.png" alt="5???" /> 5???
			<% } %>
		</div>
	</div>

	</div>

<form id = "fview" name = "fview" method="get" action="sub.do">
	<input type="hidden" id="m" 					name="m" 					value="57"/>
	<input type="hidden" id="mode" 					name="mode" 				value="<%=mode%>"/>
	<input type="hidden" id="searchId" 				name="searchId" 			value="<%=util.getStr(paramMap.get("searchId"))%>"/>
	<input type="hidden" id="searchCd" 				name="searchCd" 			value="<%=util.getStr(paramMap.get("searchCd"))%>"/>
	<input type="hidden" id="listMode" 				name="listMode" 			value="<%=listMode%>"/>
	<input type="hidden" id="searchCmtIdx" 			name="searchCmtIdx" 		value=""/>
	<input type="hidden" id="cmtContent" 			name="cmtContent" 			value=""/>
	<input type="hidden" id="searchStarScore" 		name="searchStarScore" 		value="" />
	<input type="hidden" id="techNm" 				name="techNm" 				value="<%=techNm %>" />
	<input type="hidden" id="techOrgNm" 			name="techOrgNm" 			value="<%=techOrgNm %>" />
	<input type="hidden" id="techBeforeInfo" 		name="techBeforeInfo" 		value="<%=techBeforeInfo %>" />


	<table class="P_contBox2" summary="???????????? ???????????? ?????? ??????????????? ????????????, ?????????, ?????????, ????????????, ????????????(?????????), ????????????, ??????????????? ???????????? ????????????.">
	<caption>????????????, ?????????, ?????????, ????????????, ????????????(?????????), ????????????, ??????????????? ????????? ????????????.</caption>
	<colgroup>
	<col style="width:20%;" />
	<col style="width:30%;" />
	<col style="width:20%;" />
	<col style="width:30%;" />
	</colgroup>
		<thead>
			<tr>
				<th class="title" colspan="4">????????????</th>
			</tr>
		</thead>

		<tbody>
			<tr>
				<th>?????????</th>
				<td>

				<%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("10")) { %>
				<img alt="??????/??????" src="/img/board/shape11.gif" />
				<% } %> <%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("20")) { %>
				<img alt="??????/??????" src="/img/board/shape12.gif" />
				<% } %> <%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("30")) { %>
				<img alt="????????????" src="/img/board/shape13.gif" />
				<% } %> <%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("40")) { %>
				<img alt="??????" src="/img/board/shape14.gif" />
				<% } %> <%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("50")) { %>
				<img alt="?????????/??????" src="/img/board/shape15.gif" />
				<% } %> <%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("60")) { %>
				<img alt="?????????/??????" src="/img/board/shape16.gif" />
				<% } %> <%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("70")) { %>
				<img alt="???????????????" src="/img/board/shape17.gif" />
				<% } %><%if(util.getStr(dataMap.get("TCHNLGY_M_CL")).equals("80")) { %>
				<img alt="?????????" src="/img/board/shape25.gif" />
				<% } %>

				</td>
				<th>?????????</th>
				<td class="r_line_none"><%=util.getStr(dataMap.get("TCHNLGY_S_CL_NAME"))%></td>
			</tr>

			<tr>
				<th>????????????</th>
				<td>
				<%if(util.getStr(dataMap.get("BEFORE_INFO")).equals("A")) { %><img src="/img/board/shape18.gif" alt="??????, ????????????, ????????????" />
				<% } else if(util.getStr(dataMap.get("BEFORE_INFO")).equals("B")) { %><img src="/img/board/shape19.gif" alt="??????" />
				<% } else if(util.getStr(dataMap.get("BEFORE_INFO")).equals("C")) { %><img src="/img/board/shape20.gif" alt="????????????" />
				<% } else if(util.getStr(dataMap.get("BEFORE_INFO")).equals("D")) { %><img src="/img/board/shape21.gif" alt="????????????" />
				<% } else if(util.getStr(dataMap.get("BEFORE_INFO")).equals("E")) { %><img src="/img/board/shape24.gif" alt="????????????" />
				<% } else if(util.getStr(dataMap.get("BEFORE_INFO")).equals("F")) { %><img src="/img/board/shape22.gif" alt="????????????" />
				<% } else if(util.getStr(dataMap.get("BEFORE_INFO")).equals("G")) { %><img src="/img/board/shape23.gif" alt="????????????" />
				<% } %>
				</td>
				<th>????????????(?????????)</th>
				<td class="r_line_none">
				<%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>
					<%=util.getStr(dataMap.get("OWN_ORG_NM"))%>
				<% } else if(util.getStr(paramMap.get("searchCd")).equals("5")) { %>
					<%=util.getStr(dataMap.get("ORG_NM"))%>
				<% } else { %>
					<%=util.getStr(dataMap.get("OWN_ORG_NM"))%>(<%=util.getStr(dataMap.get("APLC_USER"))%>)
				<% } %>
				</td>
			</tr>

			<tr>
				 <th>????????????</th>
                      <td>
	                      <div class="shape">
							<%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("A")) { %>
							<img alt="??????" src="/img/board/shape01.gif" />
							<% } %> <%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("B")) { %>
							<img alt="??????" src="/img/board/shape02.gif" />
							<% } %> <%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("C")) { %>
							<img alt="??????" src="/img/board/shape03.gif" />
							<% } %> <%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("D")) { %>
							<img alt="??????" src="/img/board/shape04.gif" />
							<% } %> <%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("E")) { %>
							<img alt="??????" src="/img/board/shape05.gif" />
							<% } %> <%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("F")) { %>
							<img alt="??????" src="/img/board/shape06.gif" />
							<% } %> <%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("G")) { %>
							<img alt="????????????" src="/img/board/shape07.gif" />
							<% } %> <%if(util.getStr(dataMap.get("RIGHT_STATUS")).equals("H")) { %>
							<img alt="???????????????" src="/img/board/shape08.gif" />
							<% } %>
	                      </div>
                      </td>
                      <th>????????????</th>
                      <td class="r_line_none row2">
                      <%if(util.getStr(paramMap.get("searchCd")).equals("1")) { %>
                                  ???????????? : <%=util.getStr(dataMap.get("REG_NO"))%> (<%=util.getStr(dataMap.get("REG_DT"))%>)<br/>
                                  ???????????? : <%=util.getStr(dataMap.get("APLC_NO"))%> (<%=util.getStr(dataMap.get("APLC_DT"))%>)
                      <% } else if(util.getStr(paramMap.get("searchCd")).equals("2")) { %>
                                  ???????????? : (<%=util.getStr(dataMap.get("REG_NO"))%>)<br/>
                                  ???????????? : <%=util.getStr(dataMap.get("APLC_NO"))%> (<%=util.getStr(dataMap.get("APLC_DT"))%>)

                      <% } else if(util.getStr(paramMap.get("searchCd")).equals("3")) { %>
                                  ???????????? : <%=util.getStr(dataMap.get("REG_NO"))%> (<%=util.getStr(dataMap.get("REG_DT"))%>)<br/>
                                  ???????????? : <%=util.getStr(dataMap.get("INTRL_APLC_NO"))%> (<%=util.getStr(dataMap.get("INTRL_APLC_DT"))%>)
                      <% } else if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>
                                  ???????????? : <%=util.getStr(dataMap.get("REG_NO"))%> (<%=util.getStr(dataMap.get("REG_DE"))%>)<br/>
                                  ??????????????? : <%=util.getStr(dataMap.get("CRT_WORK_DE"))%>
                      <% } else if(util.getStr(paramMap.get("searchCd")).equals("5")) { %>
                                  ??????????????? : <%=util.getStr(dataMap.get("RSPNBER_USER_NM"))%> (<%=util.getStr(dataMap.get("RSPNBER_TEL_NO"))%>)<br/>
                                  ???????????? : <%=util.getStr(dataMap.get("REG_DT"))%>
                      <% } %>
                      </td>
                   </tr>
                   <tr>
                   		<th>?????????</th>
                      	<td>
                      		<%=util.getStr(dataMap.get("PSN_NM"))%>
                      	</td>
                      	<th>??????</th>
                      	<td class="r_line_none row2">
                      		<%=util.getStr(dataMap.get("POSITION_NM"))%>
                      	</td>
                   </tr>
                   <tr>
                   		<th>????????????</th>
                      	<td>
                      		<%=util.getStr(dataMap.get("TEL_NO"))%>
                      	</td>
                      	<th>?????????</th>
                      	<td class="r_line_none row2">
                      		<%=util.getStr(dataMap.get("EMAIL"))%>
                      	</td>
                   </tr>

                   <tr>
                   		<th class="row2">??????????????????<br/>(??????/????????????)</th>
                        	<td class="r_line_none" colspan="3">
                            	<%
									if(!fileList.equals(null) && fileList.size() > 0){
										for(HashMap rs:fileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DOWN_DATA_GRP"))
											+"&amp;fileId="+util.getStr(rs.get("DOWN_FILE_ID"))
											+"&amp;dataIdx="+util.getStr(rs.get("DOWN_DATA_IDX"));
								%>
								<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="???????????? ????????????">
									<img src="/img/board/ico_file.png" alt="???????????? ?????????" />&nbsp;<%=util.deStr(rs.get("DOWN_TITLE_ORG"))%> (<%=util.getStr(rs.get("DOWN_FILE_SIZE")) %> Byte)
								</a><br />
								<% } }%>
							</td>
                   </tr>
                </tbody>
    </table>


	<table class="P_contBox2" summary="???????????? ???????????? ?????? ??????????????? ??????????????????, ??????????????????(?????? / ????????????)?????? ???????????? ????????????.">
                        <caption>??????????????????, ??????????????????(?????? / ????????????)?????? ????????? ????????????.</caption>
                        <colgroup>
                                    <col style="width:65%;" />
                                    <col style="width:35%;" />
                        </colgroup>
                        <thead>
                                    <tr>
                                    <th class="title">
                                    <%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>??????????????????
                                    <% } else { %>????????????<% } %>
                                    </th>
                                    <th class="title">?????? ?????????</th>
                                    </tr>
                        </thead>

                        <tbody>
                                    <tr>
                                    <td class="jip_info">
                                    <%if(util.getStr(paramMap.get("searchCd")).equals("4")) { %>
                                                <% if(util.getStr(dataMap.get("PGM_DC")).length() > 400) { %>
                                                            <%=util.getStr(dataMap.get("PGM_DC")).substring(0, 398)+"...."%>
                                                <% } else { %>
                                                            <%=util.getStr(dataMap.get("PGM_DC"))%>
                                                <% } %>

                                    <% } else { %>
                                                <% if(util.getStr(dataMap.get("TECHNOLOGY_DC")).length() > 400) { %>
                                                            <%=util.getStr(dataMap.get("TECHNOLOGY_DC")).substring(0, 398)+"...."%>
                                                <% } else { %>
                                                            <%=util.getStr(dataMap.get("TECHNOLOGY_DC"))%>
                                                <% } %>
                                    <% } %>
                                    </td>
                                    <td class="r_line_none represent_img">
                                    <% if(!String.valueOf(dataMap.get("IMG_FILE_ID")).equals(null) && !String.valueOf(dataMap.get("IMG_FILE_ID")).equals("null") && !String.valueOf(dataMap.get("IMG_FILE_ID")).equals("") && !String.valueOf(dataMap.get("IMG_FILE_ID")).equals("0")) { %>
                                    <img src="<%=fileImgPath%>" width="400" height="282" alt="????????????"/>
                                    <% } else { %>
                                    	???????????? ???????????? ????????????.
                                    <% } %>
                                    </td>
                                    </tr>

                        </tbody>
            </table>
<%if(util.getStr(paramMap.get("searchCd")).equals("1") || util.getStr(paramMap.get("searchCd")).equals("2")  || util.getStr(paramMap.get("searchCd")).equals("3") ) { %>
    <table class="P_contBox2" summary="???????????? ???????????? ?????? ??????????????? ??????????????????, ??????????????????(?????? / ????????????)?????? ???????????? ????????????.">
                        <caption>??????????????????, ??????????????????(?????? / ????????????)?????? ????????? ????????????.</caption>
                        <colgroup>
                                    <col style="width:100%;" />
                        </colgroup>
                        <thead>
                                    <tr>
                                    	<th class="title">?????????</th>
                                    </tr>
                        </thead>

                        <tbody>
                        	<tr>
	                            <td class="jip_info r_line_none represent_img">
	                            	<%if(util.getIntStr(dataMap.get("STATE_FILE_ID")).equals(null) || util.getIntStr(dataMap.get("STATE_FILE_ID")).equals("") || util.getIntStr(dataMap.get("STATE_FILE_ID")).equals("0") ){%>
										???????????? ????????????.
									<% }else{
										String fileParam = "?dataGrp="+util.getStr(dataMap.get("STATE_DATA_GRP"))
													+"&amp;fileId="+util.getIntStr(dataMap.get("STATE_FILE_ID"))
													+"&amp;dataIdx="+util.getStr(dataMap.get("STATE_DATA_IDX"));

									%>
										<div class="PubimgBox"><iframe src = "/file/<%=fileFullStatementGrp+"/"+dataMap.get("STATE_TITLE")%>" width="100%" height="562px" scrolling="yes" ></iframe></div>
											<p class="down_publist">
												<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="???????????? ????????????"><img src="/img/board/btn_down3.gif" alt="2" width="213" height="50" id="Image4" /></a>
											</p>
									<%} %>
	                            <td>

                       		</tr>
                        </tbody>
            </table>
<%}%>
	<table class="P_contBox2" summary="???????????? ???????????? ?????? ??????????????? ???????????????, ?????? ???????????? ???????????? ????????????.">
		<caption>???????????????, ?????? ???????????? ????????? ????????????.</caption>
		<colgroup>
			<col style="width:65%;" />
			<col style="width:35%;" />
		</colgroup>
		<thead>
			<tr>
			<th class="title">???????????????</th>
			</tr>
		</thead>

		<tbody>
			<tr>
				<td class="jip_info2 r_line_none">

				<!-- ???????????? ?????? ?????? ?????? -->
				<div class="scoreBox">
					<div class="star_score">
						<input type="radio" class="check_score" name="starScore" value = "1"/><div class="star_score"><img src="/img/board/star1-1.png" alt="?????? 1???" /></div>
						<input type="radio" class="check_score" name="starScore" value = "2"/><div class="star_score"><img src="/img/board/star2-2.png" alt="?????? 2???" /></div>
						<input type="radio" class="check_score" name="starScore" value = "3"/><div class="star_score"><img src="/img/board/star3-3.png" alt="?????? 3???" /></div>
						<input type="radio" class="check_score" name="starScore" value = "4"/><div class="star_score"><img src="/img/board/star4-4.png" alt="?????? 4???" /></div>
						<input type="radio" class="check_score" name="starScore" value = "5"/><div class="star_score"><img src="/img/board/star5-5.png" alt="?????? 5???" /></div>
					</div>
					<div class="btn_rating"><a href="#" id="aScore">????????????</a></div>
				</div>


				<div class="ideaBox">

				<%-- <%if(!"".equals(util.getStr(loginVO.getUserIdx()))) { %> --%>
				<input type="text" class="input_idea" id="cmtContentText" value="" ></input>
				<input type="button" id="inpCmt" class="btn_write" value="??????" style="cursor:pointer"></input>
				<%-- <% } %> --%>
				<br />

				<div style="clear:both; margin-top:38px">
				<a href='javascript:void(0)' onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'?????? ????????? ???':'?????? ?????? ???';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';">?????? ????????? ???</a><div id="hiddenCommentDiv" style="display:">
				</div>
				<%if(cmtMap.size() > 0){%>
				<ul class="idea_list" style="display:">
				<%
				int no = 0;
					for(HashMap rs:cmtMap) {
					%>

					<li>
						<div class="idea_name"><%=util.getStr(rs.get("REG_USER_NM")) %></div>
						<div class="idea_date"><%=util.getStr(rs.get("REG_DT")) %></div>
						<div class="idea_txt" id="commentDiv" style="display:"><span id="comment<%=no%>"><%=util.getStr(rs.get("CMT_CONTENT")) %></span>
						<input id="commentUdtInput<%=no%>" name="commentUdtInput<%=no%>" style="display:none" class="input_idea" type="text" value="<%=util.getStr(rs.get("CMT_CONTENT")) %>" />
							&nbsp;
							<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
								<a id="udtTag<%=no%>" href="#" onclick="commentUpdate('<%=no%>')" style="display:">??????</a>
								<a id="delTag<%=no%>" href="#" style="display:" onclick="commentDelete('<%=util.getStr(rs.get("SEARCH_CMT_IDX")) %>')" >??????</a>
								<a id="saveTag<%=no%>" href="#" style="display:none" onclick="commentUpdateSave('<%=util.getStr(rs.get("SEARCH_CMT_IDX")) %>',<%=no%>)" >??????</a>
								<a id="cancelTag<%=no%>" href="#" style="display:none" onclick="commentUpdateCancel('<%=no%>')" >??????</a>
							<%} %>
						</div>
					</li>

					<%
					no++;
					} %>
				</ul>
				</div>
				<% } else { %>
				<div class="idea_none">????????? ????????? ????????????.</div>
				<% } %>
				</div>
				</td>

			</tr>

		</tbody>
	</table>

</form>

</div>

<div class="b_btn_area">
	<button class="btn_rgt" onclick="pageListGo()" style="cursor:pointer">??????</button>
</div>
<!--Patent_viewWrap E-->
<!--???????????? ?????? E-->


<script type="text/javascript">
//<![CDATA[
//BackSpace ??? ?????? ?????????
$(document).keydown(function(e){
	if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
		if(e.keyCode === 8){
		return false;
		}
	}
});

window.history.forward(0);

	function consultingSubmit(){
		$('#fview').attr("action","./sub.do");
		$('#fview').attr("method","POST");
		$('#m').val('64');
		$('#mode').val('write');
		$('#fview').submit();
	}


	function pageListGo(){
		history.back(-1);
		//$('#mode').val('search');
		//$('#fview').submit();
	}

	function consultationGo(){
		<c:if test="${loginVO.userIdx eq null || loginVO.userIdx eq '' }">
			alert("????????? ??? ??????????????? ???????????????.");
			ssoPopupShow('login');
			return false;
		</c:if>
	}

	//?????? ??????
	$(document).ready(function() {
		$("#aScore").click(function() {
			var starScoreCheck = $(":input:radio[name=starScore]:checked").val();

			<c:if test="${loginVO.userIdx eq null || loginVO.userIdx eq '' }">
				alert("????????? ??? ??????????????? ???????????????.");
				return false;
			</c:if>

			if(starScoreCheck ==null || starScoreCheck ==""){
				alert("????????? ????????? ?????????.");
				return false;
			}

			$('#searchStarScore').val(starScoreCheck);

			$("#mode").val("viewScore");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/web/jipbankSearch.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("?????????????????????");
					window.location.reload();
				}
			});
		});
	});

	//????????????
	$(document).ready(function() {
		$("#inpCmt").click(function() {
			<c:if test="${loginVO.userIdx eq null || loginVO.userIdx eq '' }">
			alert("????????? ??? ??????????????? ???????????????.");
			return false;
			</c:if>

			$("#cmtContent").val($("#cmtContentText").val());
			if($("#cmtContent").val() =="" || $("#cmtContent").val() ==null){
				alert("?????? ????????? ????????? ?????????.");
				$('#cmtContentText').focus()
				return false;
			}

			$("#mode").val("insertCmt");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/web/jipbankSearch.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("?????????????????????");
					window.location.reload();
				}
			});
		});
	});

	//????????????
	function commentDelete(cmtId) {
		if(confirm("????????? ?????????????????????????")) {
			$("#searchCmtIdx").val(cmtId);
			$("#mode").val("deleteCmt");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/web/jipbankSearch.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("?????????????????????");
					window.location.reload();
				}
			});
		}
	}

	//"????????????" ?????? ?????? ???
	function commentUpdate(cmtNo) {

		$("#commentUdtInput"+cmtNo).css("display","");	//????????? input
		$("#commentUdtInput"+cmtNo).focus();
		$("#comment"+cmtNo).css("display","none");	//?????????
		$("#udtTag"+cmtNo).css("display","none");	//????????????
		$("#saveTag"+cmtNo).css("display","");		//????????????
		$("#delTag"+cmtNo).css("display","none");	//????????????
		$("#cancelTag"+cmtNo).css("display","");	//????????????

		return false;
	}

	//"????????????> ????????????" ?????? ?????? ???
	function commentUpdateCancel(cmtNo) {
		$("#commentUdtInput"+cmtNo).css("display","none");	//????????? input
		$("#comment"+cmtNo).css("display","");	//?????????
		$("#udtTag"+cmtNo).css("display","");	//????????????
		$("#saveTag"+cmtNo).css("display","none");		//????????????
		$("#delTag"+cmtNo).css("display","");	//????????????
		$("#cancelTag"+cmtNo).css("display","none");	//????????????

		return false;
	}

	//?????? ??????> ??????
	function commentUpdateSave(cmtId, cmtNo) {
		if(confirm("????????? ?????????????????????????")) {
			var cmtInput = 'commentUdtInput'+cmtNo;
			var cmtCn = document.getElementById(cmtInput).value;

			$("#searchCmtIdx").val(cmtId);
			$("#cmtContent").val(cmtCn);
			$("#mode").val("editCmt");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/web/jipbankSearch.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("?????????????????????");
					window.location.reload();
				}
			});
		}
	}
//]]>
</script>
