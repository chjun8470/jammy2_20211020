<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String mode = util.getStr(paramMap.get("mode"));
%>

<div class="clear_wrap">
						<div class="left_box w75">
				<div class="box_in">
					<p class="tr mb5"></p>
					<table id="step1" summary="연구장비의 상세정보입력" class="tbl04">
	                	<caption>연구장비 상세정보수정</caption>
	                	<colgroup>
	               			<col width="220px">
	               			<col width="">
	                	</colgroup>
	                	<tbody>
						<tr>
                			<th scope="col" class="top_sell bln"><label for="equipCd">시설장비 분류</label></th>
                			<td class="top_sell brn">
                			<label for="equipCd01">
	                			<% if(util.getInt(dataMap.get("EQUIP_CD"))==1){out.println("연구장비");}
	                			else if(util.getInt(dataMap.get("EQUIP_CD"))==2){out.println("연구시설");}%>
                			</label>
                			</td>
                		</tr>
                		<tr>
                			<th scope="row" class="bln"><label for="registCd">시설구분</label></th>
                			<td class="brn">
                			<%
                				 if(util.getInt(dataMap.get("REGIST_CD")) == 1){out.println("주장비(주시설)");}
                			else if(util.getInt(dataMap.get("REGIST_CD")) == 2){out.println("보조장비");}
                			else if(util.getInt(dataMap.get("REGIST_CD")) == 3){out.println("부대장비(부대시설)");}
                			%>
                			</td>
                		</tr>
                		<%-- <tr class="equipRegistOption" id="equipMain" >
							<th scope="row" class="bln"><label for="eqcpidlayer">주장비(주시설)</label></th>
							<td class="brn">
								<%=util.getStr(dataMap.get("EQCP_NM"))%>
								(<%=util.getStr(dataMap.get("EQCP_ID"))%>)
							</td>
						</tr> --%>
	                	<tr>
	                	
                			<th scope="col" class="top_sell bln"><label for="fixedAsetNo">고정자산관리번호</label></th>
                			<td class="top_sell brn">

	                			<%=!util.getStr(dataMap.get("FIXED_ASET_NO")).equals("") ? util.getStr(dataMap.get("FIXED_ASET_NO")) : "사용하지않음."%>
                			</td>
                		</tr>
                		
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="korNm">한글장비명</label></th>
                			<td class="top_sell brn">
                			<%=util.getStr(dataMap.get("KOR_NM"))%>
                			</td>
                		</tr>
                		
                		<tr>
                			<th scope="col" class="top_sell bln"><label for="engNm">영문장비명</label></th>
                			<td class="top_sell brn">
                			<%=util.getStr(dataMap.get("ENG_NM"))%>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col" class="top_sell bln"><label for="equProduce">제조사</label></th>
                			<td class="top_sell brn">
                			<%=util.getStr(dataMap.get("EQU_PRODUCE"))%>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="manufactureFind">모델명</label></th>
                			<td class="top_sell brn">
                			
								<%=!util.getStr(dataMap.get("MANUFACTURE_NM")).equals("")? util.getStr(dataMap.get("MANUFACTURE_NM")):"모델명 없음." %>
                			</td>
                		</tr>
                		<tr>
                			<th scope="col" class="top_sell bln"><label for="BRANCH_NM">국가연구시설장비<br/>표준분류체계</label></th>
                			<td class="top_sell brn">
								<%=util.getStr(dataMap.get("BRANCH_NM"))%>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="bln"><label for="takeCd" id="take">구축방법</label></th>
                			<td class="brn">
                			<label for="takeCd1">
                			<%
                				 if(util.getInt(dataMap.get("TAKE_CD")) == 1){out.println("구매");}
                			else if(util.getInt(dataMap.get("TAKE_CD")) == 2){out.println("개발");}
                			%>
                			</label>
                			</td>
                		</tr>
						<tr id="trTakeDt">
							<th scope="col" class="bln">
								<div class="equipCdOption" id="thTakeDt1">
									<label for="takeDt">구축기간</label>
								</div>
							</th>
							
							<td class="brn">
								<div class="equipCdOption" id="tdTakeDt2">
									<%=util.getStr(dataMap.get("TAKE_SDT"))%> ~
									<%=util.getStr(dataMap.get("TAKE_EDT"))%>
								</div>
							</td>
						</tr>
						
                		<!-- 22222222222222222222222222 -->
                		<!-- <tr>
                			<th scope="col" class="top_sell bln"><label for="">연구과제정보</label></th>
                			<td class="top_sell brn">
                				협의중
                			</td>
                		</tr> -->
                		<tr>
                			<th scope="col" class="top_sell bln"><label for="">연구과제정보</label></th>
                			<td class="top_sell brn">
                				<%=util.getStr(dataMap.get("RND_YN")).equals("Y") ? util.getStr(dataMap.get("RND_INFO")) : "비연구과제"%>
                			</td>
                		</tr>
	                	
						<tr>
							<th scope="col" class="top_sell bln"><label for="">구축비</label></th>
	               			<td class="top_sell brn">
								<table style="width:100%">
	                				<colgroup>
	                					<col width="20%">
	                					<col width="30%">
	                					<col width="20%">
	                					<col width="30%">
	                				</colgroup>
	                				<tbody>
		                				<tr>
		                					<th>토지비</th>
			                				<td>
			                				<%=util.getStr(dataMap.get("LAND_PRC"))%>(원)
			                				<%if(util.getStr(dataMap.get("LAND_PRC"))=="0"){
				                					if(util.getStr(dataMap.get("LAND_REASON"))!=""){
				                						out.println(" * "+util.getStr(dataMap.get("LAND_REASON")));	
				                					}else{
				                						out.println(" * 토지가 없음");
				                					}
			                					}
			                				%>
			                				<th>면적</th>
			                				<td><%=util.getStr(dataMap.get("LAND_AREA"))%>㎡</td>
		                				</tr>
		                			</tbody>
	                			</table>
	                			<table style="width:100%">
		                			<colgroup>
	                					<col width="20%">
	                					<col width="30%">
	                					<col width="20%">
	                					<col width="30%">
	                				</colgroup>
	                				<tbody>
		                				<tr>
		                					<th>건물비</th>
			                				<td>
			                				<%=util.getStr(dataMap.get("BUILD_PRC"))%>(원)
			                				<%if(util.getStr(dataMap.get("BUILD_PRC"))=="0"){
				                					if(util.getStr(dataMap.get("BUILD_REASON"))!=""){
				                						out.println(" * "+util.getStr(dataMap.get("BUILD_REASON")));	
				                					}else{
				                						out.println(" * 건물이 없음");
				                					}
			                					}
			                				%>
			                				<th>면적</th>
			                				<td><%=util.getStr(dataMap.get("BUILD_AREA"))%>㎡</td>	
		                				</tr>
		                				<tr>
		                					<th>지상층수</th>
			                				<td><%=util.getStr(dataMap.get("FLOOR_UP"))%>(층)</td>
			                				<th>지하층수</th>
			                				<td><%=util.getStr(dataMap.get("FLOOR_DOWN"))%>(층)</td>	
		                				</tr>
		                				
		                			</tbody>
		                		</table>
		                		<table style="width:100%">
		                			<colgroup>
	                					<col width="20%">
	                					<col width="30%">
	                					<col width="20%">
	                					<col width="30%">
	                				</colgroup>
	                				<tbody>
		                				<tr>
		                					<th>특수설비비</th>
			                				<td colspan="3">
			                				<%
			                						 if(util.getStr(dataMap.get("EQUIP_FACILITIESYN"))=="Y"){out.println("(특수설비 없음)");}
			                					else if(util.getStr(dataMap.get("EQUIP_FACILITIESYN"))=="N"){out.println(util.getStr(dataMap.get("EQUIP_FACILITIES_TAKE_PRC"))+"(원)"+"(건물비 포함)");}
			                					else{out.println(util.getStr(dataMap.get("EQUIP_FACILITIES_TAKE_PRC"))+"(원)");}
			                					%>
			                				</td>
		                				</tr>
		                			</tbody>
		                		</table>
	               				<table style="width:100%">
	                				<colgroup>
	                					<col width="20%">
	                					<col width="30%">
	                					<col width="20%">
	                					<col width="30%">
	               					</colgroup>
	                				<tbody>
		                				<tr>
		                					<th>연구장비비</th>
			                				<td colspan="3">
				                				<%= util.getStr(dataMap.get("EQUIP_TAKE_PRC_NONE_YN"))=="Y" ? "연구장비없음":util.getStr(dataMap.get("EQUIP_TAKE_PRC"))+"원"%>
			                				</td>
			                			</tr>
			                			<tr>
		                					<th >3천만원 미만<br/>연구장비</th>
			                				<td colspan="3">
			                				<%= util.getStr(dataMap.get("EQUIP_LITTLE_TAKE_PRC"))%>(원)
			                				</td>
		                				</tr>
	               					</tbody>
	               				</table>
	               				<table style="width:100%">
	               						<col width="15%">
	                					<col width="25%">
	                					<col width="10%">
	                					<col width="20%">
	                					<col width="10%">
	                					<col width="20%">
	               					<tr>
	               						<th>총 구축금액</th>
	               						<td><%= util.getStr(dataMap.get("TAKE_PRC"))%>(원)</td>
	               						<th>국산금액</th>
	               						<td><%= util.getStr(dataMap.get("TAKE_PRC_FOREIGN"))%>(원)</td>
	               						<th>외산금액</th>
	               						<td><%= util.getStr(dataMap.get("TAKE_PRC_DOMESTIC"))%>(원)</td>
	               					</tr>
	               				</table>
							</td>
						</tr>
                		
<%-- 						<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션" <%=!util.getStr(dataMap.get("REGIST_CD")).equals("1") ? "style='display:none'" : "" %>> --%>
						<tr class="equipRegistOption" id="equipMainDetail" title="주장비 추가등록 옵션">
                			<th scope="row" class="bln"><label for="modelSearchLayer">활용범위</label></th>
                			<td class="brn">
								<%
									 if(util.getInt(dataMap.get("USE_SCOPE_CD")) == 1){out.println("단독활용만 가능");}
	                			else if(util.getInt(dataMap.get("USE_SCOPE_CD")) == 2){out.println("공동활용 허용가능");}
	                			else if(util.getInt(dataMap.get("USE_SCOPE_CD")) == 3){out.println("공동활용서비스가능");}
								%>
                			</td>
                		</tr>
                		<tr class="useScopeCd" id="useScopeCd_1" <%=!util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "style='display:none'" : "" %>>
							<th scope="row" class="bln"><label for="useScope">단독활용사유</label></th>
							<td class="brn">
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
						<tr class="table01" id="useScopeRangeDiv" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "style='display:none'" : "" %>>
							<th scope="row" class="bln"><label for="useScopeRange">활용대상</label></th>
							<td class="brn">
							<%=util.getStr(dataMap.get("USE_SCOPE_RANGE"))%>
							</td>
						</tr>
						<tr class="table01" id="useScopeMeanDiv" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "style='display:none'" : "" %>>
							<th scope="row" class="bln"><label for="useScopeMean">이용방법</label></th>
							<td class="brn">
									<%=util.getStr(dataMap.get("USE_SCOPE_MEAN"))%>
							</td>
						</tr>
						<tr class="equipRegistOption" id="equipuseTypeCd" title="시설용도" <%=util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ? "style='display:none'" : "" %>>
                			<th scope="row" class="bln"><label for="useTypeCd">시설용도</label></th>
                			<td class="brn">
								<%=util.getStr(dataMap.get("USE_TYPE_CD"))%>
                			</td>
                		</tr>
						<tr class="useTypeCd" id="useTypeCd_06" <%=!util.getStr(dataMap.get("USE_TYPE_CD")).equals("기타") ? "style='display:none'" : "" %>/>
							<th scope="row" class="bln">
									시설용도사유
							</th>
							<td class="brn">
								<%=util.getStr(dataMap.get("USE_TYPE_REASON"))%>
							</td>
						</tr>
						
                		<tr class="equipRegistOption" id="equipIdleDisuseCd" title="시설상태" >
							<th scope="row" class="bln">
								<label for="idleDisuseCd">
										시설상태
								</label>
							</th>
							<td class="brn">
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
							<td class="brn">
								<%=util.getStr(dataMap.get("DISUSE_VERDICT_DT"))%>
							</td>
						</tr>
						<tr id="idleDisuseCd_4" class="idleDisuseCd" <%=!util.getStr(dataMap.get("IDLE_DISUSE_CD")).equals("04") ? "style='display:none'" : "" %>">
							<th scope="row" class="bln"><label for="disuseCd">불용처분</label></th>
							<td class="brn">
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
										<span id="thDisuseCd_04" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("04") ? "style='display:none'" : "" %>>양여일자</span>
										<span id="thDisuseCd_05" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("05") ? "style='display:none'" : "" %>>대여일자</span>
									</th>
									<td class="brn">
										<%=util.getStr(dataMap.get("DISUSE_DT"))%>
										<%=!util.getStr(dataMap.get("DISUSE_ORGAN")).equals("") ? util.getStr(dataMap.get("DISUSE_ORGAN")) : ""%>
										<p id="pDisuseCd_01" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("01") ? "style='display:none'" : "" %>><span class="f_blue">매각일자가 불용판정일자와 다를 경우, 매각된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_02" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("02") ? "style='display:none'" : "" %>><span class="f_blue">재활용일자가 불용판정일자와 다를 경우, 재활용된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_03" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("03") ? "style='display:none'" : "" %>><span class="f_blue">폐기일자가 불용판정일자와 다를 경우, 폐기된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_04" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("04") ? "style='display:none'" : "" %>><span class="f_blue">양여일자가 불용판정일자와 다를 경우, 양여된 일자로 수정해주세요 </span>
										<p id="pDisuseCd_05" <%=!util.getStr(dataMap.get("DISUSE_TYPE")).equals("05") ? "style='display:none'" : "" %>><span class="f_blue">대여일자가 불용판정일자와 다를 경우, 대여된 일자로 수정해주세요 </span>
									</td>
						</tr>

	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="location">설치장소</label></th>
                			<td class="top_sell brn">
                				<%=util.getStr(dataMap.get("LOCATION")) %>&nbsp;<%=util.getStr(dataMap.get("LOCATION_DTL")) %>
                			</td>
                		</tr>
	                	
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="feature">장비설명</label></th>
                			<td class="top_sell brn">
                				<%=util.getStr(dataMap.get("EQUIP_DETAIL_FEATURE")).replaceAll("\r\n", "<br/>") %>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="capability">구성 및 성능</label></th>
                			<td class="top_sell brn">
                			<%=util.getStr(dataMap.get("EQUIP_DETAIL_CAPABILITY")).replaceAll("\r\n", "<br/>") %>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="example">사용예</label></th>
                			<td class="top_sell brn">
								<%=util.getStr(dataMap.get("EQUIP_DETAIL_EXAMPLE")).replaceAll("\r\n", "<br/>")%>
                			</td>
                		</tr>
	                	<tr>
                			<th scope="col" class="top_sell bln"><label for="importCd">5대 중점투자분야</label></th>
                			<td class="top_sell brn">
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
                			<th scope="col" class="top_sell bln"><label for="equipCd">문의처</label></th>
                			<td class="top_sell brn">
                				<table class="tbl4">
	                				<tr>
	                					<th style="width: 100px">담당자</th>
	                					<td style="width: 200px"><%=util.getStr(dataMap.get("OPER_CHARGER")) %></td>
	                					<th style="width: 100px">직위</th>
	                					<td style="width: 200px"><%=util.getStr(dataMap.get("OPER_POSITION")) %></td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td><%=util.getStr(dataMap.get("OPER_TEL")) %></td>
	                					<th>이메일</th>
	                					<td><%=util.getStr(dataMap.get("OPER_EMAIL")) %></td>
	                				</tr>
	                				<tr>
	                					<th >팩스</th>
	                					<td><%=util.getStr(dataMap.get("OPER_FAX")) %></td>
	                					<th >비고</th>
	                					<td><%=util.getStr(dataMap.get("OPER_ETC")) %></td>
	                				</tr>
                				</table>
                			</td>
                		</tr>
				
				<%
					if(fileList.size() > 0){
				%>
						<tr>
							<th scope="col" class="tit">
								<label for="extfile">첨부파일</label>
							</th>
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
		<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
									</li>
								<% fileCnt++; }%>
								</ul>
							<%} %>
							</td>
						</tr>
                	</tbody>
                </table>
              </div>
              <div class="btn_box" >
	                	<div class="btn_right_box" >
	                		<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">수정</button>
	                		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
	                	</div>
             </div>
            </div>
<form id = "fview" name = "fview" method="">
	<input type="hidden" id = "mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" id = "rnd_equ_idx" name = "rndEquIdx" value = "<%=util.getStr(paramMap.get("rndEquIdx"))%>"/>
</form>
<script type="text/javascript">
//<![CDATA[
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
		$('#mode').val('editRsc');
		$('#fview').submit();
	}
//]]>	
</script>
