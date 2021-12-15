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
	HashMap<String, String> equGoodsDataMap = request.getAttribute("equGoodsDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("equGoodsDataMap");
	HashMap<String, String> dataMapCopy = request.getAttribute("dataMapCopy") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMapCopy");
	HashMap<String, String> equGoodsDataMapCopy = request.getAttribute("equGoodsDataMapCopy") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("equGoodsDataMapCopy");

	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String rndEquIdx = util.getStr(paramMap.get("rndEquIdx"));
	String equGoodsIdx = util.getIntStr(equGoodsDataMap.get("EQU_GOODS_IDX"));
	String equipCd = util.getIntStr(paramMap.get("equipCd"));
	String state = util.getStr(dataMap.get("STATE"));
	String reject = util.getStr(dataMap.get("REJECT"));

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

<form id = "fview" name = "fview" method="post" action="/sys/sys_jnsptotal_eq.do">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>"/>
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>"/>
	<input type="hidden" name="tmenu" id="tmenu" value="2"/>
	<input type="hidden" name="rndEquIdx" id="rndEquIdx" value="<%=rndEquIdx%>"/>
	<input type="hidden" name="equGoodsIdx" id="equGoodsIdx" value="<%=equGoodsIdx%>"/>
	<input type="hidden" name="equipCd" id="equipCd" value="<%=equipCd%>"/>
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>"/>
	<input type="hidden" name="state" id="state" value="<%=state%>"/>
	<input type="hidden" name="reject" id="reject" value="<%=reject%>"/>

	<div class="clear_wrap">
		<h3>[연구장비 상세정보]</h3>
		<table id="step1" summary="연구장비의 상세정보입력" class="skin_basic_write">
		  	<caption>연구장비 상세정보수정</caption>
		   	<colgroup>
		   		<col style="width: 220px;" />
		       	<col style="width: *;">
		    </colgroup>
			<tbody>
	            <tr>
	             	<th scope="row" class="top_sell bln">JEINET 등록번호</th>
	            	<td <% if(!util.getStr(dataMapCopy.get("RND_EQU_IDX")).equals(util.getStr(dataMapCopy.get("RND_EQU_IDX"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	            		<%=util.getStr(dataMap.get("RND_EQU_IDX")) %>
	            	</td>
	            </tr>
				<tr>
					<%if(util.getStr(dataMap.get("STATE")).equals("3") || util.getStr(dataMap.get("STATE")).equals("7") ) { %>
	            	<th scope="row" rowspan="2" class="top_sell bln"><label for="equipCd">승인상태</label></th>
	            	<%}else{%>
	            	<th scope="row" class="top_sell bln"><label for="equipCd">승인상태</label></th>
	            	<%}%>

	            	<td class="top_sell brn">
		            	<%if(util.getStr(dataMap.get("STATE")).equals("1")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(dataMap.get("STATE")).equals("2")) { %> <img alt="이용승인" src="/img/back/comm/edu_state_img_07.png"> (<%=util.getStr(String.valueOf(dataMap.get("STATE_DT"))) %>)<% } %>
						<%if(util.getStr(dataMap.get("STATE")).equals("3")) { %> <img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> (<%=util.getStr(String.valueOf(dataMap.get("STATE_DT"))) %>)<% } %>
						<%if(util.getStr(dataMap.get("STATE")).equals("5")) { %> <img alt="승인취소" src="/img/back/comm/order_state_img_5.png"> (<%=util.getStr(String.valueOf(dataMap.get("STATE_DT"))) %>)<% } %>
						<%if(util.getStr(dataMap.get("STATE")).equals("6")) { %> <img alt="수정요청" src="/img/back/comm/order_state_img_6.png"> (<%=util.getStr(String.valueOf(dataMap.get("STATE_DT"))) %>)<% } %>
						<%if(util.getStr(dataMap.get("STATE")).equals("7")) { %> <img alt="수정반려" src="/img/back/comm/order_state_img_7.png"> (<%=util.getStr(String.valueOf(dataMap.get("STATE_DT"))) %>)<% } %>
	               	</td>
	            </tr>

	             <%if(util.getStr(dataMap.get("STATE")).equals("3") || util.getStr(dataMap.get("STATE")).equals("7") ) { %>
		        	<tr>
		            	<td class="top_sell brn">반려사유 :&nbsp;<%=util.getStr(dataMap.get("REJECT"))%></td>
		            </tr>
		        <%} %>
				<tr>
	         		<th scope="row" class="top_sell bln"><label for="equipCd">시설장비 분류</label></th>
	                <td <% if(!util.getStr(dataMapCopy.get("EQUIP_CD")).equals(util.getStr(dataMapCopy.get("UP_EQUIP_CD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	               		<label for="equipCd01">
		              	<%
		                	if(util.getInt(dataMap.get("EQUIP_CD"))==1){out.println("연구장비");}
		                	else if(util.getInt(dataMap.get("EQUIP_CD"))==2){out.println("연구시설");}
		                %>
	                	</label>
	               	</td>
	            </tr>

				<tr>
					<th scope="row" class="top_sell bln"><label for="fixedAsetNo">NTIS등록번호</label></th>
	                <td <% if(!util.getStr(dataMapCopy.get("NTIS_EQUIP_INFO")).equals(util.getStr(dataMapCopy.get("UP_NTIS_EQUIP_INFO"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
		            	<%=util.getStr(dataMap.get("NTIS_EQUIP_INFO")).equals("") ? "NTIS 미등록장비": util.getStr(dataMap.get("NTIS_EQUIP_INFO"))%>
	               	</td>
	            </tr>
		        <tr>
	            	<th scope="row" class="top_sell bln"><label for="fixedAsetNo">고정자산관리번호</label></th>
	            	<td <% if(!util.getStr(dataMapCopy.get("FIXED_ASET_NO")).equals(util.getStr(dataMapCopy.get("UP_FIXED_ASET_NO"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
		        		<%=util.getStr(dataMap.get("FIXED_ASET_NO"))%>
	              	</td>
	            </tr>
		        <tr>
	            	<th scope="row" class="top_sell bln"><label for="korNm">한글장비명</label></th>
	                <td <% if(!util.getStr(dataMapCopy.get("KOR_NM")).equals(util.getStr(dataMapCopy.get("UP_KOR_NM"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	                	<%=util.getStr(dataMap.get("KOR_NM"))%>
	                </td>
	            </tr>
               	<tr>
                	<th scope="row" class="top_sell bln"><label for="korNm">한글키워드</label></th>
                	<td <% if(!util.getStr(dataMapCopy.get("KOR_KEY_WORD")).equals(util.getStr(dataMapCopy.get("UP_KOR_KEY_WORD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
                		<%=util.getStr(dataMap.get("KOR_KEY_WORD"))%>
                	</td>
                </tr>
	            <tr>
	            	<th scope="row" class="top_sell bln"><label for="engNm">영문장비명</label></th>
	            	<td <% if(!util.getStr(dataMapCopy.get("ENG_NM")).equals(util.getStr(dataMapCopy.get("UP_ENG_NM"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	            		<%=util.getStr(dataMap.get("ENG_NM"))%>
	             	</td>
	            </tr>
               	<tr>
                	<th scope="row" class="top_sell bln"><label for="korNm">한글키워드</label></th>
                	<td <% if(!util.getStr(dataMapCopy.get("END_KEY_WORD")).equals(util.getStr(dataMapCopy.get("UP_END_KEY_WORD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
                		<%=util.getStr(dataMap.get("END_KEY_WORD"))%>
                	</td>
                </tr>
	            <tr>
	            	<th scope="row" class="top_sell bln"><label for="manufactureNm">제조사</label></th>
	            	<td <% if(!util.getStr(dataMapCopy.get("MANUFACTURE_NM")).equals(util.getStr(dataMapCopy.get("UP_MANUFACTURE_NM"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	             		<%=util.getStr(dataMap.get("MANUFACTURE_NM"))%>
	            	</td>
	           	</tr>
		       	<tr>
	            	<th scope="row" class="top_sell bln"><label for="modelFind">모델명</label></th>
	            	<td <% if(!util.getStr(dataMapCopy.get("MODEL_NM")).equals(util.getStr(dataMapCopy.get("UP_MODEL_NM"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
						<%=util.getStr(util.getStr(dataMap.get("MODEL_NM"))) %>
	               	</td>
	            </tr>
	            <tr>
	            	<th scope="row" class="top_sell bln"><label for="branchNm">국가연구시설장비<br/>표준분류체계</label></th>
	             	<td <% if(!util.getStr(dataMapCopy.get("BRANCH_NM")).equals(util.getStr(dataMapCopy.get("UP_BRANCH_NM"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
						<%=util.getStr(dataMap.get("BRANCH_NM"))%>
	             	</td>
	            </tr>
		        <tr>
	            	<th scope="row" class="bln"><label for="takeCd" id="take"> 취득방법</label></th>
	               	<td <% if(!util.getStr(dataMapCopy.get("TAKE_CD")).equals(util.getStr(dataMapCopy.get("UP_TAKE_CD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	               		<label for="takeCd1">
	                	<%
	                		if(util.getInt(dataMap.get("TAKE_CD")) == 1){out.println("구매");}
	                		else if(util.getInt(dataMap.get("TAKE_CD")) == 2){out.println("개발");}
	                	%>
	                	</label>
	            	</td>
	           	</tr>

	            <%if(util.getStr(dataMap.get("EQUIP_WARRANTY"))!="" || util.getStr(dataMap.get("EQUIP_WARRANTY")) != null) {%>
	            <tr>
	            	<th scope="row" class="bln"> 내구연한</th>
	               	<td <% if(!util.getStr(dataMapCopy.get("EQUIP_WARRANTY")).equals(util.getStr(dataMapCopy.get("UP_EQUIP_WARRANTY"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	           			<%=util.getStr(dataMap.get("EQUIP_WARRANTY"))%>년
	               	</td>
	            </tr>
	            <%}%>

				<tr id="trTakeDt">
					<th scope="row" class="bln">
						<div class="equipCdOption" id="thTakeDt1" <%=util.getInt(dataMap.get("TAKE_CD")) != 1 ? "style='display:none'":""%>>
							<label for="takeDt">취득일자</label>
						</div>
						<div class="equipCdOption" id="thTakeDt2" <%=util.getInt(dataMap.get("TAKE_CD")) != 2 ? "style='display:none'":""%>>
							<label for="takeSdt">개발기간</label>
						</div>
					</th>
					<td class="brn">
						<div <% if(!util.getStr(dataMapCopy.get("TAKE_SDT")).equals(util.getStr(dataMapCopy.get("UP_TAKE_SDT"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='equipCdOption'");} %>
						 id="tdTakeDt1" <%=util.getInt(dataMap.get("TAKE_CD")) != 1 ? "style='display:none'":""%>>
							<%=util.getStr(dataMap.get("TAKE_SDT"))%>
						</div>
						<div <% if((!util.getStr(dataMapCopy.get("TAKE_SDT")).equals(util.getStr(dataMapCopy.get("UP_TAKE_SDT"))) && !dataMapCopy.equals(null))||(!util.getStr(dataMapCopy.get("TAKE_EDT")).equals(util.getStr(dataMapCopy.get("UP_TAKE_EDT"))) && !dataMapCopy.equals(null))){out.println("class='txt_red'");}else{out.println("class='equipCdOption'");} %>
						 id="tdTakeDt2" <%=util.getInt(dataMap.get("TAKE_CD")) != 2 ? "style='display:none'":""%>>
							<%=util.getStr(dataMap.get("TAKE_SDT"))%> ~
							<%=util.getStr(dataMap.get("TAKE_EDT"))%>
						</div>
					</td>
				</tr>
				<tr id="takePrcSource">
					<th scope="row" class="bln">
						<div class="equipCdOption" id="thTakePrc1" >
							<label for="takeDt">사업비출처</label>
						</div>
					</th>
					<td class="brn">
						<div <% if((!util.getStr(dataMapCopy.get("TAKE_SOURCE")).equals(util.getStr(dataMapCopy.get("UP_TAKE_SOURCE"))) && !dataMapCopy.equals(null))||(!util.getStr(dataMapCopy.get("TAKE_SOURCE_DT")).equals(util.getStr(dataMapCopy.get("UP_TAKE_SOURCE_DT"))) && !dataMapCopy.equals(null))){out.println("class='txt_red'");}else{out.println("class='equipCdOption'");} %>
						 id="takeSourceDiv" >
							<%if(util.getStr(dataMap.get("TAKE_SOURCE")).equals("1")){out.println("국비"); }%>
							<%if(util.getStr(dataMap.get("TAKE_SOURCE")).equals("2")){out.println("국비+지방비"); }%>
							<%if(util.getStr(dataMap.get("TAKE_SOURCE")).equals("3")){
								out.println("지방비");

								if(util.getStr(dataMap.get("TAKE_SOURCE_DT")).equals("1")){
									out.println("(도비)");
								}
								else if(util.getStr(dataMap.get("TAKE_SOURCE_DT")).equals("2")){
									out.println("(지방비)");
								}

							  }
							%>
							<%if(util.getStr(dataMap.get("TAKE_SOURCE")).equals("4")){out.println("자체"); }%>
						</div>
					</td>
				</tr>
				<tr id="trTakePrc">
					<th scope="row" class="bln">
						<div class="equipCdOption" id="thTakePrc1" <%=util.getInt(dataMap.get("TAKE_CD")) != 1 ? "style='display:none'":""%>>
							<label for="takeDt">취득금액</label>
						</div>
						<div class="equipCdOption" id="thTakePrc2" <%=util.getInt(dataMap.get("TAKE_CD")) != 2 ? "style='display:none'":""%>>
							<label for="takeSdt">개발금액</label>
						</div>
					</th>
					<td class="brn">
						<div <% if(!util.getStr(dataMapCopy.get("TAKE_PRC")).equals(util.getStr(dataMapCopy.get("UP_TAKE_PRC"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='equipCdOption'");} %>
						 id="tdTakePrc" >
							 <%=util.getComma(util.getStr(dataMap.get("TAKE_PRC")))%>원
						</div>
					</td>
				</tr>
				<tr id = "thOpenYn" <%=util.getInt(dataMap.get("TAKE_CD")) != 2 ? "style='display:none'":""%>>
	            	<th scope="row" class="top_sell bln"><label for="devOpenYn">개발장비공개여부</label></th>
	               	<td <% if(!util.getStr(dataMapCopy.get("DEV_OPEN_YN")).equals(util.getStr(dataMapCopy.get("UP_DEV_OPEN_YN"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	              		<%=util.getStr(dataMap.get("DEV_OPEN_YN")).equals("Y") ? "공개" : "미공개" %>
	              	</td>
	            </tr>
	            <tr id = "thDevSpec" <%=util.getInt(dataMap.get("TAKE_CD")) != 2 ? "style='display:none'":""%>>
	             	<th scope="row" class="top_sell bln"><label for="devOpenYn">개발장비비중</label></th>
	             	<td <% if(!util.getStr(dataMapCopy.get("DEV_SPEC")).equals(util.getStr(dataMapCopy.get("UP_DEV_SPEC"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell brn'");} %>>
	             		<%=util.getStr(dataMap.get("DEV_SPEC"))%>
	                </td>
	            </tr>

	            <tr id="rndCommitTR">
	            	<th scope="row" class="bln"><label for = "rndCommit" id="rndCommitLB">과제수행부처ㆍ청</label></th>
	                <td <% if(!util.getStr(dataMapCopy.get("RND_COMMIT")).equals(util.getStr(dataMapCopy.get("UP_RND_COMMIT"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn srch_label'");} %>>
	                	<%=util.getStr(dataMap.get("RND_COMMIT"))%>
	                </td>
	            </tr>
	            <tr id="rndBizTR">
	            	<th scope="row" class="bln"><label for = "rndBiz" id="rndBizLB" >세부사업명</label></th>
	             	<td <% if(!util.getStr(dataMapCopy.get("RND_BIZ")).equals(util.getStr(dataMapCopy.get("UP_RND_BIZ"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn srch_label'");} %>>
	             		<%=util.getStr(dataMap.get("RND_BIZ"))%>
	                </td>
	            </tr>
	            <tr id="rndTaskTR">
	            	<th scope="row" class="bln"><label for = "rndTask" id="rndTaskLB" >세부과제명</label></th>
	           		<td <% if(!util.getStr(dataMapCopy.get("RND_TASK")).equals(util.getStr(dataMapCopy.get("UP_RND_TASK"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn srch_label'");} %>>
	                	<%=util.getStr(dataMap.get("RND_TASK"))%>
	               	</td>
	            </tr>
	            <tr id="rndMainOrgTR">
	            	<th scope="row" class="bln"><label for = "rndMainOrg" id="rndMainOrgLB" >주관기관명</label></th>
	            	<td <% if(!util.getStr(dataMapCopy.get("RND_MAIN_ORG")).equals(util.getStr(dataMapCopy.get("UP_RND_MAIN_ORG"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn srch_label'");} %>>
	            		<%=util.getStr(dataMap.get("RND_MAIN_ORG"))%>
	           		</td>
	           	</tr>
	            <tr id="rndDivisionTR">
	            	<th scope="row" class="bln"><label for = "rndDivision" id="rndDivisionLB" >6T분류</label></th>
	                <td <% if(!util.getStr(dataMapCopy.get("RND_DIVISION")).equals(util.getStr(dataMapCopy.get("UP_RND_DIVISION"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn srch_label'");} %>>
	           			<%=util.getStr(dataMap.get("RND_DIVISION")).equals("BT") ? "BT(Biology Technology)" : "" %>
						<%=util.getStr(dataMap.get("RND_DIVISION")).equals("ET") ? "ET(Environment Technology)" : "" %>
						<%=util.getStr(dataMap.get("RND_DIVISION")).equals("IT") ? "IT(Information Technology)" : "" %>
						<%=util.getStr(dataMap.get("RND_DIVISION")).equals("NT") ? "NT(Nano Technology)" : "" %>
						<%=util.getStr(dataMap.get("RND_DIVISION")).equals("ST") ? "ST(Space Technology)" : "" %>
						<%=util.getStr(dataMap.get("RND_DIVISION")).equals("CT") ? "CT(Culture Technology)" : "" %>
						<%=util.getStr(dataMap.get("RND_DIVISION")).equals("ETC") ? "기타" : "" %>
	                </td>
	            </tr>
	            <tr id="rndDtTR">
	            	<th scope="row" class="bln"><label for="rndStDt" id="rndDtLB">과제수행기간</label></th>
	            	<td <% if((!util.getStr(dataMapCopy.get("RND_ST_DT")).equals(util.getStr(dataMapCopy.get("UP_RND_ST_DT"))) && !dataMapCopy.equals(null))||(!util.getStr(dataMapCopy.get("RND_ED_DT")).equals(util.getStr(dataMapCopy.get("UP_RND_ED_DT"))) && !dataMapCopy.equals(null))){out.println("class='txt_red'");}else{out.println("class='brn srch_label'");} %>>
	             		<%=util.getStr(dataMap.get("RND_ST_DT"))%><%=!util.getStr(dataMap.get("RND_ED_DT")).equals("")?"~":"" %><%=util.getStr(dataMap.get("RND_ED_DT"))%>
	                </td>
	            </tr>
				<tr>
	            	<th scope="row" class="bln"><label for="registCd">장비구분</label></th>
	             	<td <% if(!util.getStr(dataMapCopy.get("REGIST_CD")).equals(util.getStr(dataMapCopy.get("UP_REGIST_CD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
	             	<%
	                	     if(util.getInt(dataMap.get("REGIST_CD")) == 1){out.println("주장비(주시설)");}
	                	else if(util.getInt(dataMap.get("REGIST_CD")) == 2){out.println("보조장비");}
	                	else if(util.getInt(dataMap.get("REGIST_CD")) == 3){out.println("부대장비(부대시설)");}
	                %>
	                </td>
	            </tr>

				<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션" >
	            	<th scope="row" class="bln"><label for="modelSearchLayer">활용범위</label></th>
	            	<td <% if(!util.getStr(dataMapCopy.get("USE_SCOPE_CD")).equals(util.getStr(dataMapCopy.get("UP_USE_SCOPE_CD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
					<%
						if(util.getInt(dataMap.get("USE_SCOPE_CD")) == 1){
							out.println("단독활용만 가능");
						}else if(util.getInt(dataMap.get("USE_SCOPE_CD")) == 2){
							out.println("공동활용 허용가능");
						}else if(util.getInt(dataMap.get("USE_SCOPE_CD")) == 3){
							out.println("공동활용서비스가능");
						}
					%>
	                </td>
	             </tr>
	           	 <tr class="useScopeCd" id="useScopeCd_1" <%=util.getInt(dataMap.get("USE_SCOPE_CD")) != 1 ? "style='display:none'" : "" %>>
					<th scope="row" class="bln"><label for="useScope">단독활용사유<%=dataMap.get("USE_SCOPE_CD")%></label></th>
					<td <% if(!util.getStr(dataMapCopy.get("USE_SCOPE_REASON")).equals(util.getStr(dataMapCopy.get("UP_USE_SCOPE_REASON"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
					<%
						     if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("01")){out.println("자체 수요가 많아 내부 활용도가 매우 높은 장비<br/>(장비가동률 100%, 년간 2000시간 이상 장비)");}
		            	else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("02")){out.println("시작품 시제품 수준으로 아직 시험운영중이거나<br/>요소 부품 및 기술 개발중인 장비");}
		                else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("03")){out.println("특수목적용 장비로서 반드시 자체 특화된 연구에만 전용되어야 하는 장비");}
		                else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("04")){out.println("상시 모니터링 및 계측용으로 연중 실시간 또는 지속적으로 활용되어지는 장비");}
		                else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("05")){out.println("국가안보, 기술유출 등으로 보안 및 기밀유지가 요구되는 장비");}
		                else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("06")){out.println("위험물질 취급 및 고위험성으로 인하여 이용이 제한되어 있는 장비");}
		                else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("07")){out.println("초고감도 정밀장비로 오염 및 손상시 복구가 불가능한 장비");}
		                else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("08")){out.println("라이센스 계약에 묶여있어 타이용자가 사용이 불가능한 장비");}
		                else if(util.getStr(dataMap.get("USE_SCOPE_REASON")).equals("09")){out.println("기타");}
					%>
					</td>
				  </tr>
				  <tr class="table01" id="useScopeRangeDiv" <%=!util.getStr(dataMap.get("USE_SCOPE_CD")).equals("2") ? "style='display:none'" : "" %>>
				    <th scope="row" class="bln"><label for="useScopeRange">활용대상</label></th>
					<td <% if(!util.getStr(dataMapCopy.get("USE_SCOPE_RANGE")).equals(util.getStr(dataMapCopy.get("UP_USE_SCOPE_RANGE"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
						<%=util.getStr(dataMap.get("USE_SCOPE_RANGE"))%>
					</td>
				  </tr>
				  <tr class="table01" id="useScopeMeanDiv" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "style='display:none'" : "" %>>
					<th scope="row" class="bln"><label for="useScopeMean">이용방법</label></th>
					<td <% if(!util.getStr(dataMapCopy.get("USE_SCOPE_MEAN")).equals(util.getStr(dataMapCopy.get("UP_USE_SCOPE_MEAN"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
						<%=util.getStr(dataMap.get("USE_SCOPE_MEAN"))%>
					</td>
				  </tr>
				  <tr class="equipRegistOption" id="equipuseTypeCd">
	              	<th scope="row" class="bln"><label for="useTypeCd">장비용도</label></th>
	              	<td <% if(!util.getStr(dataMapCopy.get("USE_TYPE_CD")).equals(util.getStr(dataMapCopy.get("UP_USE_TYPE_CD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
						<%=util.getStr(dataMap.get("USE_TYPE_CD"))%>
	               	</td>
	              </tr>
				  <tr class="useTypeCd" id="useTypeCd_06" <%=!util.getStr(dataMap.get("USE_TYPE_CD")).equals("기타") ? "style='display:none'" : "" %>>
					<th scope="row" class="bln">장비용도사유</th>
					<td <% if(!util.getStr(dataMapCopy.get("USE_TYPE_REASON")).equals(util.getStr(dataMapCopy.get("UP_USE_TYPE_REASON"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
						<%=util.getStr(dataMap.get("USE_TYPE_REASON"))%>
					</td>
				  </tr>
	              <tr class="equipRegistOption" id="equipIdleDisuseCd">
					<th scope="row" class="bln"><label for="idleDisuseCd">장비상태</label></th>
					<td <% if(!util.getStr(dataMapCopy.get("IDLE_DISUSE_CD")).equals(util.getStr(dataMapCopy.get("UP_IDLE_DISUSE_CD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
					<%
							 if(util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("01")){out.println("활용");}
			            else if(util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("02")){out.println("재활용");}
			         	else if(util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("03")){out.println("유휴");}
		                else if(util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04")){out.println("불용");}
		                else if(util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("05")){out.println("대여");}
					%>
					</td>
				  </tr>
				  <tr id="disuseVerdictDt_4" class="disuseVerdictDt" <%=!util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "style='display:none'" : "" %>>
					<th scope="row" class="bln"><label for="disuseVerdictDt">불용판정일자</label></th>
					<td <% if(!util.getStr(dataMapCopy.get("DISUSE_VERDICT_DT")).equals(util.getStr(dataMapCopy.get("UP_DISUSE_VERDICT_DT"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
						<%=util.getStr(dataMap.get("DISUSE_VERDICT_DT"))%>
					</td>
				  </tr>
				  <tr id="idleDisuseCd_4" class="idleDisuseCd" <%=!util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "style='display:none'" : "" %>>
					<th scope="row" class="bln"><label for="disuseCd">불용처분</label></th>
					<td <% if(!util.getStr(dataMapCopy.get("DISUSE_TYPE")).equals(util.getStr(dataMapCopy.get("UP_DISUSE_TYPE"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
					<%
							 if(util.getStr(dataMap.get("DISUSE_TYPE")).equals("01")){out.println("매각");}
		             	else if(util.getStr(dataMap.get("DISUSE_TYPE")).equals("02")){out.println("재활용");}
		               	else if(util.getStr(dataMap.get("DISUSE_TYPE")).equals("03")){out.println("폐기");}
		            	else if(util.getStr(dataMap.get("DISUSE_TYPE")).equals("04")){out.println("양여");}
		             	else if(util.getStr(dataMap.get("DISUSE_TYPE")).equals("05")){out.println("대여");}
					%>
						<br/><span class="f_orange mb5"> ※ 장비처분 시, 해당 기관의 ‘장비심의위원회’의 승인사항입니다.</span>
					</td>
				  </tr>

				  <tr id="trDisuseCd" class="disuseCd" <%=!util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "style='display:none'" : "" %>>
					<th scope="row" class="bln">
						<span id="thDisuseCd_01" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("01") ? "style='display:none'" : "" %>>매각일자</span>
						<span id="thDisuseCd_02" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("02") ? "style='display:none'" : "" %>>재활용일자</span>
						<span id="thDisuseCd_03" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("03") ? "style='display:none'" : "" %>>폐기일자</span>
						<span id="thDisuseCd_04" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("04") ? "style='display:none'" : "" %>>양여기관</span>
						<span id="thDisuseCd_05" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("05") ? "style='display:none'" : "" %>>대여기관</span>
					</th>
					<td <% if(!util.getStr(dataMapCopy.get("DISUSE_TYPE")).equals(util.getStr(dataMapCopy.get("UP_DISUSE_TYPE"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='brn'");} %>>
						<%=util.getStr(dataMap.get("DISUSE_DT"))%>
						<p id="pDisuseCd_02" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("02") ? "style='display:none'" : "" %>><span class="f_blue">재활용일자가 불용판정일자와 다를 경우, 재활용된 일자로 수정해주세요 </span>
						<p id="pDisuseCd_03" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("03") ? "style='display:none'" : "" %>><span class="f_blue">폐기일자가 불용판정일자와 다를 경우, 폐기된 일자로 수정해주세요 </span>
						<p id="pDisuseCd_04" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("04") ? "style='display:none'" : "" %>><span class="f_blue">양여일자가 불용판정일자와 다를 경우, 양여된 일자로 수정해주세요 </span>
						<p id="pDisuseCd_05" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("05") ? "style='display:none'" : "" %>><span class="f_blue">대여일자가 불용판정일자와 다를 경우, 대여된 일자로 수정해주세요 </span>
					</td>
				  </tr>

	            <tr>
	            	<th scope="row" class="top_sell bln">지역명</th>
	                <td <% if(!util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(dataMapCopy.get("UP_AREA_SIGUNGU"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
		             	<%=util.getStr(dataMap.get("areaNm"))%>
	                </td>
	            </tr>
		          <tr>
	             	<th scope="row" class="top_sell bln"><label for="location">설치장소</label></th>
	               	<td <% if((!util.getStr(dataMapCopy.get("LOCATION")).equals(util.getStr(dataMapCopy.get("UP_LOCATION"))) && !dataMapCopy.equals(null))||(!util.getStr(dataMapCopy.get("LOCATION_DTL")).equals(util.getStr(dataMapCopy.get("UP_LOCATION_DTL"))) && !dataMapCopy.equals(null))){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
	             		<%=util.getStr(dataMap.get("LOCATION")) %>&nbsp;<%=util.getStr(dataMap.get("LOCATION_DTL")) %>
						
						<%if(!util.getStr(equGoodsDataMap.get("MAP_X")).equals("")&&!util.getStr(equGoodsDataMap.get("MAP_Y")).equals("")){%>
							<div id="settingMap" style="width:100%;height:300px;" ></div>
						<%}%>
	              	</td>
	              </tr>

	            <tr>
	            	<th scope="row" class="top_sell bln">보유기관</th>
	                <td <% if(!util.getStr(equGoodsDataMapCopy.get("OWN_ORG_NM")).equals(util.getStr(equGoodsDataMapCopy.get("UP_OWN_ORG_NM"))) && !equGoodsDataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
		             	<%=util.getStr(equGoodsDataMap.get("OWN_ORG_NM"))%>
	                </td>
	            </tr>
	            <tr>
	            	<th scope="row" class="top_sell bln">보유부서</th>
	                <td <% if(!util.getStr(equGoodsDataMapCopy.get("OWN_ORG_SUB_NM")).equals(util.getStr(equGoodsDataMapCopy.get("UP_OWN_ORG_SUB_NM"))) && !equGoodsDataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
		             	<%=util.getStr(equGoodsDataMap.get("OWN_ORG_SUB_NM"))%>
	                </td>
	            </tr>
		          <tr>
	              	<th scope="row" class="top_sell bln"><label for="feature">장비설명</label></th>
	              	<td <% if(!util.getStr(dataMapCopy.get("EQUIP_DETAIL_FEATURE")).equals(util.getStr(dataMapCopy.get("UP_EQUIP_DETAIL_FEATURE"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
	              		<%=util.getStr(dataMap.get("EQUIP_DETAIL_FEATURE")).replaceAll("\r\n", "<br/>") %>
	              	</td>
	              </tr>
		          <tr>
	            	<th scope="row" class="top_sell bln"><label for="capability">구성 및 성능</label></th>
	             	<td <% if(!util.getStr(dataMapCopy.get("EQUIP_DETAIL_CAPABILITY")).equals(util.getStr(dataMapCopy.get("UP_EQUIP_DETAIL_CAPABILITY"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
	            		<%=util.getStr(dataMap.get("EQUIP_DETAIL_CAPABILITY")).replaceAll("\r\n", "<br/>") %>
	            	</td>
	              </tr>
		          <tr>
	              	<th scope="row" class="top_sell bln"><label for="example">사용예</label></th>
	                <td <% if(!util.getStr(dataMapCopy.get("EQUIP_DETAIL_EXAMPLE")).equals(util.getStr(dataMapCopy.get("UP_EQUIP_DETAIL_EXAMPLE"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
						<%=util.getStr(dataMap.get("EQUIP_DETAIL_EXAMPLE")).replaceAll("\r\n", "<br/>")%>
	                </td>
	              </tr>
		          <tr>
	              	<th scope="row" class="top_sell bln"><label for="importCd">5대 중점투자분야</label></th>
	             	<td <% if(!util.getStr(dataMapCopy.get("IMPORT_CD")).equals(util.getStr(dataMapCopy.get("UP_IMPORT_CD"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
	            	<%
							 if(util.getStr(dataMap.get("IMPORT_CD")).equals("1")){out.println("국가주도기술 핵심역량 확보");}
		            	else if(util.getStr(dataMap.get("IMPORT_CD")).equals("2")){out.println("글로벌 이슈대응 연구개발 추진");}
		             	else if(util.getStr(dataMap.get("IMPORT_CD")).equals("3")){out.println("기초과학·융합기술 연구개발 활성화");}
		          		else if(util.getStr(dataMap.get("IMPORT_CD")).equals("4")){out.println("신산업 창출 핵심기술개발 강화");}
		        		else if(util.getStr(dataMap.get("IMPORT_CD")).equals("5")){out.println("주력기간산업 기술 고도화");}
					%>
	            	</td>
	           	  </tr>
		          <tr>
	              	<th scope="row" class="top_sell bln"><label for="equipCd">담당자 정보</label></th>
	              	<td class="top_sell brn">
	                	<table class="skin_basic_write">
                			<tr>
                				<th style="width:100px">기관명</th>
                				<td <% if(!util.getStr(dataMapCopy.get("OPER_CHARGER")).equals(util.getStr(dataMapCopy.get("UP_OPER_CHARGER"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>
									style="width:200px"  id="operChargerTd">
                					<%=util.getStr(dataMap.get("OPER_ORG_GRP")) %>
                				</td>
                				<th style="width:100px">부서명</th>
                				<td <% if(!util.getStr(dataMapCopy.get("OPER_CHARGER")).equals(util.getStr(dataMapCopy.get("UP_OPER_CHARGER"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>
									style="width:200px"  id="operPositionTd">
                					<%=util.getStr(dataMap.get("OPER_ORG_GRP_SUB")) %>
                				</td>
                			</tr>
		             		<tr>
		                		<th style="width:100px">이름</th>
		                		<td <% if(!util.getStr(dataMapCopy.get("OPER_CHARGER")).equals(util.getStr(dataMapCopy.get("UP_OPER_CHARGER"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>
		                		    style="width:200px" id="operChargerTd">
		                			<%=util.getStr(dataMap.get("OPER_CHARGER")) %>
		                		</td>
		                		<th style="width:100px">직위</th>
		                		<td <% if(!util.getStr(dataMapCopy.get("OPER_POSITION")).equals(util.getStr(dataMapCopy.get("UP_OPER_POSITION"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>
		                		    style="width:200px" id="operPositionTd">
		                			<%=util.getStr(dataMap.get("OPER_POSITION")) %>
		                		</td>
		                	</tr>
		                	<tr>
		                		<th>전화번호</th>
		                		<td <% if(!util.getStr(dataMapCopy.get("OPER_TEL")).equals(util.getStr(dataMapCopy.get("UP_OPER_TEL"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>
		                			id="operTelTd">
		                			<%=util.getStr(dataMap.get("OPER_TEL")) %>
		                		</td>
		                		<th>이메일</th>
		                		<td <% if(!util.getStr(dataMapCopy.get("OPER_EMAIL")).equals(util.getStr(dataMapCopy.get("UP_OPER_EMAIL"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>
		                			id="operEmailTd">
		                			<%=util.getStr(dataMap.get("OPER_EMAIL")) %>
		                		</td>
		                	</tr>
		                	<%-- <tr>
		                		<th >팩스</th>
		                		<td <% if(!util.getStr(dataMapCopy.get("OPER_FAX")).equals(util.getStr(dataMapCopy.get("UP_OPER_FAX"))) && !dataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>
		                			colspan="3" id="operFaxTd">
									<%=util.getStr(dataMap.get("OPER_FAX")) %>
								</td>
		                	</tr> --%>
	           			</table>
	      			</td>
	      		  </tr>
	      		  <% if( "".equals( util.getStr(dataMap.get("OPER_CHARGER"))) ){ %>
		          <tr>
	              	<th scope="row" class="top_sell bln"><label for="equipCd">장비 담당자</label></th>
	              	<td class="top_sell brn">
	                	<table class="skin_basic_write">
		             		<tr>
		                		<th style="width:100px">이름</th>
		                		<td style="width:200px" id="operChargerTd2">
		                			<%=util.getStr(dataMap.get("OPER_CHARGER2")) %>
		                		</td>
		                		<th style="width:100px">직위</th>
		                		<td style="width:200px" id="operPositionTd2">
		                			<%=util.getStr(dataMap.get("OPER_POSITION2")) %>
		                		</td>
		                	</tr>
		                	<tr>
		                		<th>전화번호</th>
		                		<td id="operTelTd2">
		                			<%=util.getStr(dataMap.get("OPER_TEL2")) %>
		                		</td>
		                		<th>이메일</th>
		                		<td id="operEmailTd2">
		                			<%=util.getStr(dataMap.get("OPER_EMAIL2")) %>
		                		</td>
		                	</tr>
		                	<tr>
		                		<th >팩스</th>
		                		<td colspan="3" id="operFaxTd2">
									<%=util.getStr(dataMap.get("OPER_FAX2")) %>
								</td>
		                	</tr>
	           			</table>
	      			</td>
	      		  </tr>
	      		  <% } %>

			      <% if(fileList.size() > 0){ %>
				  <tr>
					<th scope="row" class="tit"><label for="extfile">첨부파일</label></th>
					<td>
						<ul class="file" style="line-height: 22px;">
						<%
							int fileCnt = 1;
							for(HashMap rs:fileList){
							String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
												+"&amp;rndEquIdx="+util.getStr(rs.get("RND_EQU_IDX"));
						%>
							<li class="text" >
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px;padding:10px"/>
								<%-- <%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
							</li>
						<% fileCnt++; }%>
						</ul>
					 </td>
				   </tr>
				   <%} %>
			</tbody>
		</table>

		<h3>[연구장비 예약정보]</h3>
	    <table summary="연구장비의 상세정보" class="skin_basic_write">
		  	<caption>연구장비 예약정보</caption>
		    <colgroup>
		    	<col style="width: 220px;" />
		       	<col style="width: *;">
		    </colgroup>
		   	<tbody>
	            <tr>
	          		<th scope="row" class="top_sell bln">이용 안내</th>
	               	<td <% if(!util.getStr(equGoodsDataMapCopy.get("HOW_USE")).equals(util.getStr(equGoodsDataMapCopy.get("UP_HOW_USE"))) && !equGoodsDataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
		           		<pre><%=util.getStr(equGoodsDataMap.get("HOW_USE"))%></pre>
	               	</td>
	           	</tr>
	            <tr>
	          		<th scope="row" class="top_sell bln">유의 사항</th>
	               	<td <% if(!util.getStr(equGoodsDataMapCopy.get("EQU_ATTENTION")).equals(util.getStr(equGoodsDataMapCopy.get("UP_EQU_ATTENTION"))) && !equGoodsDataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
		           		<pre><%=util.getStr(equGoodsDataMap.get("EQU_ATTENTION"))%></pre>
	               	</td>
	           	</tr>
	           	<tr>
	             	<th scope="row" class="top_sell bln">이용료 안내</th>
	             	<td <% if(!util.getStr(equGoodsDataMapCopy.get("RENTAL_INFO")).equals(util.getStr(equGoodsDataMapCopy.get("UP_RENTAL_INFO"))) && !equGoodsDataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
	            		<pre><%=util.getStr(equGoodsDataMap.get("RENTAL_INFO"))%></pre>
	                </td>
	            </tr>
	            <tr>
	          		<th scope="row" class="top_sell bln">이용신청서표기문구</th>
	               	<td <% if(!util.getStr(equGoodsDataMapCopy.get("USE_MARK_TEXT")).equals(util.getStr(equGoodsDataMapCopy.get("UP_USE_MARK_TEXT"))) && !equGoodsDataMapCopy.equals(null)){out.println("class='txt_red'");}else{out.println("class='top_sell bln'");} %>>
		           		<%=util.getStr(equGoodsDataMap.get("USE_MARK_TEXT"))%>
	               	</td>
	           	</tr>
			</tbody>
		</table>
	</div>

	<div class="btn_box" >
		<div class="btn_left_box" >
		<!-- 권한주기 최고,기관관리자,담당자 -->
	    <% if(util.loginCheck() && Integer.parseInt(loginVO.getAuthLv()) == 99) {%>
		 	<!-- 승인요청상태일경우 -->
			<%if(util.getStr(dataMap.get("STATE")).equals("1")) { %>
				<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('2')">요청 승인</button>
				<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">반려</button>
			<!-- 승인상태일경우 -->
			<% }else if(util.getStr(dataMap.get("STATE")).equals("2")) { %>
				<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">승인 취소</button>
			<!-- 수정요청일경우 -->
			<% }else if(util.getStr(dataMap.get("STATE")).equals("6")) { %>
		    	<button class="btn_inp_b_01" type="button" onclick="resveUpdateGo('2')">수정 승인</button>
		    	<button class="btn_inp_b_01" type="button" onclick="resveReturnEditDisplay()">수정 반려</button>
		    <% } %>
		<% } %>
		</div>

		<div class="btn_right_box" >
		<%if(Integer.parseInt(loginVO.getAuthLv()) >= 70) {%>
			<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
		<%} %>
			<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
		</div>
	</div>

	<div id="rejectDisplayDiv" style="display:none;">
		<table class="skin_basic_write">
			<tr>
				<th class="top_sell bln" width="220">반려사유</th>
				<td class="top_sell brn" width="470">
					<textarea rows="5" cols="55" id="rejectTxt" name="rejectTxt"></textarea>
				</td>
				<td class="top_sell brn" width="330" valign="bottom">
					<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('3')">반려확인</button>
					<button class="btn_inp_w_01" type="button" onclick="calcleBtn()">취소</button>
				</td>
			</tr>
		</table>
	</div>
	<div id="rejectEditDisplayDiv" style="display:none;">
		<table class="skin_basic_write">
			<tr>
				<th class="top_sell bln" width="220">반려사유</th>
				<td class="top_sell brn" width="470">
					<textarea rows="5" cols="55" id="rejectEditTxt" name="rejectEditTxt"></textarea>
				</td>
				<td class="top_sell brn" width="330" valign="bottom">
					<button class="btn_inp_b_01" type="button" onclick="resveUpdateGo('7')">반려확인</button>
					<button class="btn_inp_w_01" type="button" onclick="calcleEditBtn()">취소</button>
				</td>
			</tr>
		</table>
	</div>

</form>


<script type="text/javascript">
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}

	function pageDelGo(){
		if(confirm("삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fview').submit();
		}
	}

	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}

	function resveConsentGo(state){

		var rejectTxt = document.getElementById('rejectTxt').value;

		if(state == '2'){ //이용승인
			if(confirm("정말 이용승인 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./jnsptotalProc.do"
				$('#state').val(state);
				//alert("승인 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(state == '3'){ //승인취소
			if(confirm("정말 승인거절 하시겠습니까?")){
				$('#mode').val('stateEdit');
				document.fview.action = "./jnsptotalProc.do"
				$('#state').val(state);
				$('#reject').val(rejectTxt);
				//alert("반려 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}
	}

	function resveUpdateGo(state){

		var rejectEditTxt = document.getElementById('rejectEditTxt').value;

		if(state == '2'){ //수정승인
			if(confirm("정말 수정승인 하시겠습니까?")){
				$('#mode').val('stateUpdate');
				document.fview.action = "./jnsptotalProc.do"
				$('#state').val(state);
				//alert("승인 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}

		if(state == '7'){ //수정거절
			if(confirm("정말 수정거절 하시겠습니까?")){
				$('#mode').val('stateUpdate');
				document.fview.action = "./jnsptotalProc.do"
				$('#state').val(state);
				$('#reject').val(rejectEditTxt);
				//alert("반려 되었습니다.");
				$('#fview').submit();
			} else {
				return false;
			}
		}
	}

	function resveReturnDisplay(){
		$('#rejectDisplayDiv').show();
	}
	function calcleBtn(){
		$('#rejectTxt').val('');
		$('#rejectDisplayDiv').hide();
	}
	function resveReturnEditDisplay(){
		$('#rejectEditDisplayDiv').show();
	}
	function calcleEditBtn(){
		$('#rejectEditTxt').val('');
		$('#rejectEditDisplayDiv').hide();
	}

</script>
<%if(!util.getStr(equGoodsDataMap.get("MAP_X")).equals("")&&!util.getStr(equGoodsDataMap.get("MAP_Y")).equals("")){%>
<!-- <script src="//apis.daum.net/maps/maps3.js?apikey=895a5253cb907c143781b186db4b0c18&libraries=services"></script> -->
<script type="text/javascript">

    var mapContainer = document.getElementById('settingMap'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(<%=util.getStr(equGoodsDataMap.get("MAP_X"))%>, <%=util.getStr(equGoodsDataMap.get("MAP_Y"))%>), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(<%=util.getStr(equGoodsDataMap.get("MAP_X"))%>, <%=util.getStr(equGoodsDataMap.get("MAP_Y"))%>),
        map: map
    });
</script>
<%}%>